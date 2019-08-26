
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

with dataset as (
Select 

dbms_xmlgen.getxml( 
q'[
with data_model as (

Select DM.type, DM.name 
     , dbms_metadata.get_ddl(
         object_type=> trim(upper(DM.type)), name=> trim(upper(DM.name))
          -- , schema=> ?, version=> ?, model=> ?, transform=> ?
       ) ddl
 
  from (  Select 'TABLE' type, table_name name from user_tables
          union all 
          Select 'VIEW'  type, view_name name from user_views
       ) DM 

)
, code as (

  Select object_type type, object_name name 

       , dbms_metadata.get_ddl(
           object_type=> object_type , name=> object_name
         ) ddl 
    
    from user_objects 
   where object_type in (
            'PACKAGE', /* 'PACKAGE BODY',*/ 'FUNCTION', 'PROCEDURE' 
           , 'TYPE' /*, 'TYPE BODY'*/
         )
     and object_name not like 'SYS_PLSQL%'  

) 

, code_and_data_model as (
  Select * from data_model 
  union all 
  Select * from code 
)

Select * from code_and_data_model
]' 
) ddl

from dual 
)

Select xmltransform(
          xmltype(ddl)
        , xmltype(

        q'[
        <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <xsl:template match="/">
        <catalog>
            <xsl:for-each select="/ROWSET/ROW">

               <xsl:variable name="type" select="TYPE" />
               <xsl:variable name="name" select="NAME" />
               <xsl:variable name="ddl" select="DDL" />


               <xsl:element name="{$type}">

                 <xsl:element name="{$name}">
                   <xsl:value-of select="DDL"/>
                 </xsl:element>
               
               </xsl:element>

            </xsl:for-each>
        </catalog>
        </xsl:template>
        </xsl:stylesheet>
        ]'
        )

    ).getClobVAl() bla 

 from dataset 
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
