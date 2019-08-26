
Permite obter um xml com o DDL dos vários objectos de um schema.

Para depois navegar no ficheiro podemos utilizar por exemplo o [Foxe](http://www.firstobject.com/dn_editor.htm).
  
Depois de aberto no Foxe podemos obter o ddl de um elemento através de clickar com botão direito e depois a opção "Element Data". Com isto obteremos o valor sem as entidades xml (```&quot;```... ).

```sql

begin

    DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
    DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
    DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SEGMENT_ATTRIBUTES', false);
    DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'STORAGE', false);
end;


Select 

dbms_xmlgen.getxml(

q'[
with data_model as (

Select DM.type generic_type, DM.type, name 
     , dbms_metadata.get_ddl(
         object_type=> trim(upper(DM.type)), name=> trim(upper(DM.name))
          -- , schema=> ?, version=> ?, model=> ?, transform=> ?
       ) line_text
     , 1 line
 
  from (  Select 'TABLE' type, table_name name from user_tables
          union all 
          Select 'VIEW'  type, view_name name from user_views
       ) DM 

)
, code as (
  Select regexp_replace(type, '((^\s)*)(\s.*)', '\1') generic_type, US.type, US.name, to_clob( case when line = 1 then 'Create or replace ' else '' end || US.text ) line_text, line  
    from user_source US  
   where type in (
          'PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE', 
          'TYPE', 'TYPE BODY'
         )
) 

, code_and_data_model as (
  Select * from data_model 
  union all 
  Select * from code 
)

Select generic_type
     , name
     , DBMS_XMLGEN.CONVERT(EXTRACT(xmltype('<?xml version="1.0"?><document>'||XMLAGG(XMLTYPE('<V>'|| DBMS_XMLGEN.CONVERT(

         C.line_text 

       )|| '</V>') order by C.name, C.type, C.line asc ).getclobval()||'</document>'), '/document/V/text()') .getclobval(),1) DDL 
 
 from code_and_data_model C
group by C.generic_type, C.name
]'


) ddl 

from dual 
;
```
## TODO
  
Tentar criar um XSLT para transformar o XML devolvido acima em algo como:
  
```xml
<catalog>

  <data_model>
    <table> 
       <table_name1>ddl for this table </table_name1>
       <table_name2>ddl for this table </table_name2>
       (...)
    </table>
    <view></view>
  </data_model>

  <code>
   <procedure></procedure>
   <function></function> 
   <package></package>  
  </code>  

</catalog>
```
