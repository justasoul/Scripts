/*
VER: http://www.dba-oracle.com/security/user_defined_context.htm
*/


create or replace package bn_test_context_pck as 

end bn_test_context_pck;

create or replace package body bn_test_context_pck as 

end bn_test_context_pck;  


create context bn_test_context using bn_test_context_pck;
;

Select * from dictionary where table_name like '%SYST%PRIVS%' 

