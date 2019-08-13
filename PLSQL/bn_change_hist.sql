CREATE TABLE bn_ddl_change_hist
    (timestamp_cri                  TIMESTAMP (6),
    hostname                       VARCHAR2(100),
    ip                             VARCHAR2(100),
    osuser                         VARCHAR2(100),
    action                         VARCHAR2(100),
    object_type                    VARCHAR2(100),
    object_name                    VARCHAR2(100),
    source                         CLOB
) 
/


CREATE OR REPLACE TRIGGER bn_change_hist
 AFTER
  CREATE OR ALTER OR DROP
 ON SCHEMA
BEGIN

  /*
    ver: https://docs.oracle.com/cd/B10501_01/appdev.920/a96590/adg14evt.htm


  */

  declare

    procedure record_ddl_change is 

      sql_text ora_name_list_t;
      stmt CLOB;
      n number; 
      -- lt_session V$SESSION%ROWTYPE;
      lv_session_data VARCHAR2(600);

    begin

      -- Get Change Context
      Select         sys_context('USERENV', 'HOST')         
           || ';' || sys_context('USERENV', 'IP_ADDRESS') 
           || ';' || sys_context('USERENV', 'OS_USER')      
           || ';' || ora_sysevent
           || ';' || ORA_DICT_OBJ_TYPE
           || ';' || ORA_DICT_OBJ_name
        into lv_session_data
        from dual
     ;
      -- Get Source
      n := ora_sql_txt(sql_text);
      FOR i IN 1..n LOOP
       stmt := stmt || to_clob(sql_text(i));
      END LOOP;

      if upper(stmt) like to_clob('ALTER%COMPILE%') then

        null;
 
      else 

        -- Record Change
        insert into bn_ddl_change_hist (Timestamp_cri, hostname, ip, osuser, 
                                        action, object_type, object_name, source) 
             values (systimestamp, sys_context('USERENV', 'HOST'), sys_context('USERENV', 'IP_ADDRESS'), sys_context('USERENV', 'OS_USER'),
                     ora_sysevent, ORA_DICT_OBJ_TYPE, ORA_DICT_OBJ_name, stmt
             )
        ;

      end if;

    end;

    procedure remove_surplus_versions is 
    begin

      delete from bn_ddl_change_hist 
            where rowid in (with dataset as (
                              Select sum(1) over (partition by osuser, object_type, object_name order by timestamp_cri desc) ord
                                   , rowid row_id, BN.*
                                from bn_ddl_change_hist BN
                            )
                            Select row_id from dataset D 
                             where D.ord > 5
      )
      ;

    end;


  begin
    -- AQUI -- 
    record_ddl_change;
    remove_surplus_versions;

  end; 


EXCEPTION

  WHEN OTHERS THEN

       raise_application_error(-20000, SQLERRM);

END;
/