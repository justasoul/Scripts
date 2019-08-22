

```
Select 

dbms_xmlgen.getxml(

q'[
with dataset as (
  Select regexp_replace(type, '((^\s)*)(\s.*)', '\1') generic_type, US.*, case when line = 1 then 'Create or replace ' else '' end || US.text line_text  
    from user_source US  
   where type in (
          -- 'PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE', 
          'TYPE', 'TYPE BODY'
         ) 
   -- where type in ('TYPE', 'TYPE BODY')

) 

Select generic_type
     , name
     , DBMS_XMLGEN.CONVERT(EXTRACT(xmltype('<?xml version="1.0"?><document>'||XMLAGG(XMLTYPE('<V>'|| DBMS_XMLGEN.CONVERT(

         D.line_text 

       )|| '</V>') order by name, type, line asc ).getclobval()||'</document>'), '/document/V/text()') .getclobval(),1) DDL 
 
 from dataset D
group by generic_type, name
]'


) ddl 

from dual 
;
```
