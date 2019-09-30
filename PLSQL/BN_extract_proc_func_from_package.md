## Utiliza um bocado força bruta
 
Basicamente encontra os inícios dos procs/functions e assume que um dado proc/func existe é a próxima criação de um proc_func...
  
  ````sql 
  with inicio_proc_func as (

  Select -- NAME || '.' || regexp_replace(upper(text), '(.*)(FUNCTION|PROCEDURE)(\s)([\S|^\(]*)(.*)', '\4') bla  
         NAME || '.' || trim(regexp_replace(upper(text), '(\s*)(FUNCTION|PROCEDURE)(\s*)(.*)(\(.*)', '\4')) proc_func 
         , lead(line) over (partition by name order by line asc) lead_line
         , US.*
    from user_source US 
   where name  in ('PCK_NEGOTIATION', 'PCK_ACCOUNT') 
     and type = 'PACKAGE BODY' 
     and regexp_like (upper(text), '\s*(FUNCTION|PROCEDURE)')

)

, content_per_proc_func as (
  Select proc_func
       , (Select fclob_clobagg (US_CONTENT.text)  
            from user_source US_CONTENT
           where US_CONTENT.name  = IPF.name 
             and US_CONTENT.type  = IPF.type  
             and case when IPF.lead_line is null and US_content.line >= IPF.line then 1
                      when IPF.lead_line is not null and  US_CONTENT.line between IPF.line and (IPF.lead_line - 1) then 1
                      else 0 
                 end = 1    
         ) content  
    from inicio_proc_func IPF
)

Select * 
 from content_per_proc_func
  ```` 
