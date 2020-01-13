declare 
  lv_schema_name varchar2(100) := 'BN';
  le_user_doesnt_exist EXCEPTION; 

  pragma exception_init(le_user_doesnt_exist, -1918); 
begin 

  -- Create user 
  begin
    execute immediate 'DROP USER ' || lv_schema_name || ' cascade ';
  exception 
    when le_user_doesnt_exist then
      dbms_output.put_line('WARN: O user já não existe!' ); 
  end; 

  execute immediate 'CREATE USER ' || lv_schema_name || ' IDENTIFIED BY ' || lv_schema_name;
 
  -- Grants 
  begin
    for i in (Select * from table (APEX_040000.VC4000ARRAY(
                  'session'
                , 'table'
                , 'view'
                , 'any trigger'
                , 'any procedure'
                , 'sequence'
                , 'synonym'
                , 'any type'
              ))
             )
    loop
      execute immediate 'GRANT create ' || i.column_value || ' TO ' || lv_schema_name;
    end loop;

    execute immediate 'grant all privileges to ' || lv_schema_name;                                   
	execute IMMEDIATE 'grant create session to ' || lv_schema_name;
	execute immediate 'ALTER USER ' || lv_schema_name || ' DEFAULT TABLESPACE USERS';

  end;  
END; 
