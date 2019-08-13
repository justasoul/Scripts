create or replace package bn_utils AUTHID CURRENT_USER is
  procedure clone_object (pv_object_name VARCHAR2, pv_clone_name VARCHAR2 default NULL );

  procedure cow_me (pv_table_name varchar2);
end bn_utils;
/

create or replace package body bn_utils is

  procedure clone_object (pv_object_name VARCHAR2, pv_clone_name VARCHAR2 default NULL ) is 
    -- lclob_package_original CLOB;
    -- lclob_package_final    CLOB;

    lv_object_name VARCHAR2(32);
    lv_clone_name  VARCHAR2(32);
    lv_object_type VARCHAR2(100);  

    procedure clone (pv_object_type varchar2, pv_obj_name varchar2, pv_clone_name varchar2) is 
      lclob_object_ddl CLOB; 
      lclob_clone_ddl  CLOB;
    begin

      lclob_object_ddl := DBMS_METADATA.get_ddl (pv_object_type, pv_obj_name);

      lclob_clone_ddl := regexp_replace(lclob_object_ddl, pv_obj_name, pv_clone_name, 1, 0, 'i'); 

      if pv_object_type = 'TABLE' then
        lclob_clone_ddl := regexp_replace(lclob_clone_ddl, ' LOB \(".*"\) STORE AS BASICFILE ".*"\(ENABLE STORAGE IN ROW CHUNK \d* RETENTION ' || chr(10) || 
                           '  NOCACHE LOGGING \)', ''); 
      end if;

      dbms_output.put_line('=> ' || lclob_clone_ddl);  
      execute immediate lclob_clone_ddl;

    end clone;

  begin 

    lv_object_name := upper(pv_object_name);
    lv_clone_name  := upper(nvl(pv_clone_name, lv_object_name || '_TMP'));

    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SQLTERMINATOR'     , false);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SEGMENT_ATTRIBUTES', false);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE'           , false);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'PRETTY'            , true);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'CONSTRAINTS'       , false);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'REF_CONSTRAINTS'   , false);
    -- DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'LOB_STORAGE'       , 'BASICFILE' );    


    Select distinct case when object_type like 'PACKAGE%' then 'PACKAGE'
                         when object_type like 'TABLE%'   then 'TABLE'
                         else object_type end 
      into lv_object_type 
      from user_objects UO  
     where UO.object_name = lv_object_name -- lv_object_name 
    ; 

    case when lv_object_type = 'PACKAGE' then 
           begin
             clone ('PACKAGE_SPEC', lv_object_name, lv_clone_name);
             clone ('PACKAGE_BODY', lv_object_name, lv_clone_name);
           end;   
         else clone (lv_object_type, lv_object_name, lv_clone_name); 
    end case;


  end clone_object;

  procedure cow_me (pv_table_name varchar2) is  
    
      lv_table_name                VARCHAR2(100) := pv_table_name;
      lv_table_pk                  USER_CONSTRAINTS.CONSTRAINT_NAME%TYPE;
      lv_pk_columns                VARCHAR2(500);
      lv_all_columns               VARCHAR2(4000);
      lv_pk_columns_or_is_not_null VARCHAR2(4000);
      lv_cow_table_name VARCHAR2(100) := upper('BN_' || lv_table_name || '_COW');
      -- lv_cow_vw_name    VARCHAR2(100) := upper('BN_' || lv_table_name || '_COW_VW');
      lv_cow_vw_name    VARCHAR2(100) := upper('BN_' || lv_table_name || '_VW');

      lv_cow_trg_ioi    VARCHAR2(100) := 'bn_trg_' || regexp_replace(lv_table_name, '(.*?)(_.+)', '\1') || '_vw_ioi';
      lv_cow_trg_iou    VARCHAR2(100) := 'bn_trg_' || regexp_replace(lv_table_name, '(.*?)(_.+)', '\1') || '_vw_iou';
      lv_cow_trg_iod    VARCHAR2(100) := 'bn_trg_' || regexp_replace(lv_table_name, '(.*?)(_.+)', '\1') || '_vw_iod';

      lclob_trg_ioi_ddl CLOB := q'[
  Create or replace trigger #TRG_IOI_NAME#  
    instead of insert on #COW_VIEW_NAME# 
  declare
    ln_cnt NUMBER;
  begin

    Select count(1)
      into ln_cnt 
      from #COW_TABLE#
     where (#PK_COLUMNS#) = ((#PK_COLUMNS_:NEW#))
    ; 

    if #PK_COLUMNS_OR_IS_NOT_NULL_:NEW#
    then 
      raise_application_error (-20001, 'Todos os campos da PK devem estar preenchidos (#PK_COLUMNS#) ');
    end if;

    if ln_cnt > 0 then  -- Se a linha já existir na tabela de COW
      update #COW_TABLE# 
         set (#ALL_TABLE_COLUMNS#) = (Select #ALL_TABLE_COLUMNS_:NEW# from dual )
           , status = 'INS'  
       where (#PK_COLUMNS#) = ((#PK_COLUMNS_:NEW#))
      ; 
    else  
      insert into #COW_TABLE# (#ALL_TABLE_COLUMNS#, status) values (#ALL_TABLE_COLUMNS_:NEW#, 'INS');
    end if; 

  end #TRG_IOI_NAME# ;
  ]';

      lclob_trg_iou_ddl CLOB := q'[
  Create or replace trigger #TRG_IOU_NAME#  
    instead of update on #COW_VIEW_NAME#  
  declare
    ln_cnt NUMBER;
  begin

    Select count(1)
      into ln_cnt 
      from #COW_TABLE#
     where (#PK_COLUMNS#) = ((#PK_COLUMNS_:OLD#))
    ; 

    if #PK_COLUMNS_OR_IS_NOT_NULL_:NEW#
    then 
      raise_application_error (-20001, 'Todos os campos da PK devem estar preenchidos (#PK_COLUMNS#) ');
    end if;

    if ln_cnt > 0 then  -- Se a linha já existir na tabela de COW
      update #COW_TABLE#
         set (#ALL_TABLE_COLUMNS#) = (Select #ALL_TABLE_COLUMNS_:NEW# from dual )
           , status = 'UPD-COW'
       where (#PK_COLUMNS#) = ((#PK_COLUMNS_:OLD#))
      ; 
    else 
      -- Se a linha AINDA NÃO EXISTIR na tabela de COW
       insert into #COW_TABLE# (#ALL_TABLE_COLUMNS#, status) values (#ALL_TABLE_COLUMNS_:NEW#, 'UPD');
    end if; 
   
  end #TRG_IOU_NAME# ;
  ]';


      lclob_trg_iod_ddl CLOB := q'[

  Create or replace trigger #TRG_IOD_NAME# 
    instead of delete on #COW_VIEW_NAME# 
  declare
    ln_cnt NUMBER;
  begin

    Select count(1)
      into ln_cnt 
      from #COW_TABLE#
     where (#PK_COLUMNS#) = ((#PK_COLUMNS_:OLD#))
    ; 

    if ln_cnt > 0 then  -- Se a linha já existir na tabela de COW
      update  #COW_TABLE#
         set status = 'DEL-COW'
       where (#PK_COLUMNS#) = ((#PK_COLUMNS_:OLD#))
      ; 
    else 
      -- Se a linha AINDA NÃO EXISTIR na tabela de COW
       insert into #COW_TABLE# (#PK_COLUMNS#, status) values (#PK_COLUMNS_:OLD#, 'DEL');
    end if; 
   
  end #TRG_IOD_NAME# ;

  ]';




      function add_alias_to_column_list (pv_columns_list VARCHAR2, pv_alias varchar2) 
        return varchar2 is 
      begin
        return pv_alias || '.' || replace(pv_columns_list, ',', ', ' || pv_alias || '.');
      end add_alias_to_column_list;     

      function replace_snippets (pclob_template CLOB)
        return CLOB is
        lt_replace_array       PCK_UTILS.T_ASSOC_ARRAY;
        lt_replace_array_empty PCK_UTILS.T_ASSOC_ARRAY;  
        lclob_res        CLOB;

      begin
        lclob_res := pclob_template;

        lt_replace_array('#TABLE_NAME#'           ) := lv_table_name     ;
        lt_replace_array('#COW_TABLE#'            ) := lv_cow_table_name ;
        lt_replace_array('#COW_VIEW_NAME#'        ) := lv_cow_vw_name    ;

        lt_replace_array('#PK_COLUMNS#'           ) := lv_pk_columns     ;
        lt_replace_array('#PK_COLUMNS_COW#'       ) := add_alias_to_column_list(lv_pk_columns, 'COW') ;
        lt_replace_array('#PK_COLUMNS_COW1#'       ) := add_alias_to_column_list(lv_pk_columns,  'COW1');
        lt_replace_array('#PK_COLUMNS_:NEW#'       ) := add_alias_to_column_list(lv_pk_columns,  ':NEW');
        lt_replace_array('#PK_COLUMNS_:OLD#'       ) := add_alias_to_column_list(lv_pk_columns,  ':OLD');
        lt_replace_array('#PK_COLUMNS_OR_IS_NOT_NULL_:NEW#')  := replace(lv_pk_columns_or_is_not_null, '[ALIAS]', ':NEW.');

        lt_replace_array('#ALL_TABLE_COLUMNS#'    ) := lv_all_columns    ;
        lt_replace_array('#ALL_TABLE_COLUMNS_COW#' ) := add_alias_to_column_list(lv_all_columns, 'COW');

        lt_replace_array('#TRG_IOI_NAME#'         ) := lv_cow_trg_ioi    ;
        lt_replace_array('#TRG_IOU_NAME#'         ) := lv_cow_trg_iou    ;
        lt_replace_array('#TRG_IOD_NAME#'         ) := lv_cow_trg_iod    ;


        lt_replace_array('#ALL_TABLE_COLUMNS_:NEW#') := add_alias_to_column_list(lv_all_columns, ':NEW');

        lclob_res :=  pck_utils.mult_replace(lclob_res, lt_replace_array);
        lt_replace_array := lt_replace_array_empty;

        return lclob_res;

      end replace_snippets; 

      procedure get_params_and_validation is 
      begin 

        -- Garantir que a tabela indicada tem uma PK 
        begin 
          Select constraint_name  
            into lv_table_pk
            from user_constraints 
           where table_name      = lv_table_name
             and constraint_type = 'P'
          ;
        exception
           when no_data_found then 
             raise_application_error(-20001, 'A tabela indicada ("' || lv_table_name ||  '") tem de apresentar uma Primary key!'); 
     
        end;

        -- Obter lista de colunas da PK 
        begin
          Select to_char(wm_concat(UCC.column_name))
            into lv_pk_columns 
            from user_cons_columns UCC 
           where UCC.constraint_name = lv_table_pk  
          ;
        end;

        -- Obter lista de colunas da PK como uma série de condições OR para garantir que nenhum dos valores é null 
        begin
          Select replace ( 
                    to_char(wm_concat('[ALIAS]' || UCC.column_name || ' is null ')) 
                  , ',', 'or '
                 ) bla 
            into lv_pk_columns_or_is_not_null 
            from user_cons_columns UCC 
           where UCC.constraint_name = lv_table_pk  
          ;
        end;

        -- Obter todas as colunas da tabela
        begin
          Select to_char(wm_concat(UTC.column_name))
            into lv_all_columns 
            from user_tab_columns UTC 
           where UTC.table_name = lv_table_name  
          ;
        end; 

      end get_params_and_validation; 

      procedure create_COW_table is       
        le_table_already_exists EXCEPTION;
        pragma exception_init (le_table_already_exists, -955);
      begin 

        begin 
          dbms_output.put_line(lv_table_name || ' => ' || lv_cow_table_name );
          bn_clone_object (lv_table_name, lv_cow_table_name);
        exception 
          when le_table_already_exists then 
            raise_application_error(-20001, 'A tabela COW "' || lv_cow_table_name || '"  já existe! Correr "drop table ' || lv_cow_table_name || '" ! '); 
        end;

        execute immediate Q'[alter table ]' || lv_cow_table_name || q'[ add (status varchar2(10) check ( status in ('INS', 'DEL', 'UPD', 'UPD-COW', 'DEL', 'DEL-COW') ))]';
        dbms_output.put_line ('Criada a tabela COW: ' || lv_cow_table_name );
          
      end create_COW_table;

      procedure create_COW_view is 
        lclob_vw_ddl CLOB := Q'[
  create or replace view #COW_VIEW_NAME#  as 
    Select #ALL_TABLE_COLUMNS# from #TABLE_NAME# where (#PK_COLUMNS#) not in (Select #PK_COLUMNS_COW# from #COW_TABLE# COW )
    union all 
    Select #ALL_TABLE_COLUMNS_COW# from #COW_TABLE# COW
     where (#PK_COLUMNS_COW#) not in (Select #PK_COLUMNS_COW1# 
                              from #COW_TABLE# COW1  
                             where status like 'DEL%'
                           )
  ]';

      begin

        lclob_vw_ddl := replace_snippets (lclob_vw_ddl);

        dbms_output.put_line('=> ' || lclob_vw_ddl);

        execute immediate lclob_vw_ddl;

        dbms_output.put_line ('Criada a view COW: ' || lv_cow_vw_name );

      end create_COW_view;  

      procedure create_cow_trg_instead_of (pv_dml_operation varchar2) is 
        lclob_trg_ddl CLOB;
      begin

        lclob_trg_ddl := case upper(pv_dml_operation)
                           when 'INSERT' then replace_snippets (lclob_trg_ioi_ddl)
                           when 'UPDATE' then replace_snippets (lclob_trg_iou_ddl)
                           when 'DELETE' then replace_snippets (lclob_trg_iod_ddl)
                         end; 

        dbms_output.put_line('=> ' || lclob_trg_ddl);  
        execute immediate lclob_trg_ddl;

        dbms_output.put_line ('Criado o trigger Instead Of ' || upper(pv_dml_operation) ||  ': ' || lclob_trg_ddl );

      end create_cow_trg_instead_of; 

      
    begin 

      get_params_and_validation;
    
      create_COW_table;
      create_COW_view;

      create_cow_trg_instead_of('INSERT');
      create_cow_trg_instead_of('UPDATE');
      create_cow_trg_instead_of('DELETE');

  end cow_me;

end bn_utils;
/
 