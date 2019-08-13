

Create or replace procedure bn_clone_object (pv_object_name VARCHAR2, pv_clone_name VARCHAR2 default NULL ) is 
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


end bn_clone_object;


begin


  bn_clone_object ('BN_OPTIMIZE_EVENT_0610'); -- PACKAGE 
  bn_clone_object ('BN_ADD_LOG_ENTRY_CLOB');  -- PROCEDURE
  bn_clone_object ('BN_LOG');                 -- TABLE 
  bn_clone_object ('BN_BLOB_TO_CLOB');        -- FUNCTION     
  bn_clone_object ('BN_VW_TEMP');             -- VIEW

end; 

/* 
drop package BN_OPTIMIZE_EVENT_0610_TMP;
drop procedure BN_ADD_LOG_ENTRY_CLOB_tmp;
drop table BN_LOG_TMP;
drop function BN_BLOB_TO_CLOB_TMP;
drop view BN_VW_TEMP_TMP;
*/