* Dependencies
  * [StackOverflow - how-to-find-dependencies-inside-an-oracle-package ](https://stackoverflow.com/questions/39246751/how-to-find-dependencies-inside-an-oracle-package)
  
````sql
select *
from (
  select name, type, connect_by_root(name) as root_name,
    connect_by_root(type) as root_type, connect_by_isleaf as isleaf
  from user_identifiers
  start with object_type = 'PACKAGE BODY'
  and object_name = 'PCK_TRADER_MANAGER'
  and type in ('FUNCTION', 'PROCEDURE')
  and usage = 'DEFINITION'
  connect by object_type = prior object_type
  and object_name = prior object_name
  and usage_context_id = prior usage_id
)
where type in ('FUNCTION', 'PROCEDURE')
  and name <> root_name 
  and name not in ('SYSTIMESTAMP', 'UPPER', 'SQLERRM', 'RAISE_APPLICATION_ERROR')
;
````
