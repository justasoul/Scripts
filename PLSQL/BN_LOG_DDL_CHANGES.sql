/*
CREATE TABLE BN_SOURCE_HIST                    -- Create history table

  AS SELECT SYSDATE CHANGE_DATE, USER_SOURCE.*

  FROM   USER_SOURCE WHERE 1=2;

-- 
-- 
-- TEM COMPORTAMENTOS DIFERENTES CASO SEJA UM SCRIPT CORRIDO DE FICHEIRO OU GRAVADO APARTIR DO NAVIGATOR!
-- 
-- 
*/


drop table bn_ddl_change_hist
;
CREATE TABLE bn_ddl_change_hist
(
    Timestamp_cri TIMESTAMP         -- NOT NULL,
  , HOSTNAME      VARCHAR(100) -- NOT NULL,
  , IP            VARCHAR(100) -- NOT NULL,
  , OSUSER        VARCHAR(100) -- NOT NULL,
  , ACTION        VARCHAR(100) -- NOT NULL,
  , OBJECT_TYPE   VARCHAR(100) -- NOT NULL,
  , OBJECT_NAME   VARCHAR(100) -- NOT NULL,
  , SOURCE        CLOB         -- NOT NULL
)
tablespace tsb_data
;


CREATE OR REPLACE TRIGGER BN_change_hist        -- Store code in hist table

  AFTER CREATE or alter or drop ON schema          -- Change SCOTT to your schema name
 
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
                             where D.ord > 10
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