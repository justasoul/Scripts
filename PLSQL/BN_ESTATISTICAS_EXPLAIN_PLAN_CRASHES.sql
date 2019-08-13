-- VER: http://www.oracle-base.com/articles/10g/active-session-history.php      --
-- VER: http://www.bobbydurrettdba.com/2012/04/18/dba_hist_active_sess_history/ --
-- VER: http://tech.e2sn.com/oracle/troubleshooting/how-to-read-errorstack-output
----------------------------------------------------------------------------------

Select * from V$ACTIVE_SESSION_HISTORY
;

-- To allow for historical access to the ASH data, one in ten samples are persisted to disk and made available 
-- using the DBA_HIST_ACTIVE_SESS_HISTORY view. So this is a sample of a sample. Using this view is similar to 
-- using the V$ACTIVE_SESSION_HISTORY view, but remember the sample time is now 10 seconds, so use (count*10) 
-- to measure time, rather than just the count.
Select distinct DH_ASH.sql_plan_hash_value
       -- DH_ASH.sql_child_number,
       -- DH_ASH.sql_plan_hash_value
  from dba_hist_active_sess_history DH_ASH
 where DH_ASH.sql_id = '0qum6a1ujm6yh' 
;  

with fact_ash as (
  Select DH_ASH.*
    from dba_hist_active_sess_history DH_ASH
   where DH_ASH.sql_id = '0qum6a1ujm6yh'
)
, dist_plans as (
Select distinct sql_plan_hash_value
  from fact_ash
)
, explain_plans as (
  Select DP.sql_plan_hash_value,
         ( Select regexp_replace(
                    wm_concat(plan_table_output || chr(10) )
                    , ',(.*)', '\1'
                  )
             from table (
                    DBMS_XPLAN.DISPLAY_AWR(
                      sql_id          => '0qum6a1ujm6yh',
                      plan_hash_value => DP.sql_plan_hash_value, 
                      db_id           => null,  
                      format          => 'TYPICAL' -- 'ALL' 
                    )
                  ) 
         
         ) explain_plan
          
    from dist_plans DP
)
Select EP.explain_plan,
       FA.* 
  from fact_ash      FA,
       explain_plans EP 
 where FA.sql_plan_hash_value = EP.sql_plan_hash_value (+) 
;


-- Queries com o custo aumentado em mais de X%
Select DHASH.sql_id, sql_plan_hash_value, max(DHASH.sql_exec_start), DHASH. 
select DHASH.* 
  from dba_hist_active_sess_history DHASH
-- where 
 group by DHASH.sql_id, sql_plan_hash_value
;


with plans as (
  Select DHASH.sql_id, DHASH.sql_plan_hash_value, trunc(DHASH.sql_exec_start) 
    from dba_hist_active_sess_history DHASH
  -- where DHASH
   group by DHASH.sql_id, DHASH.sql_plan_hash_value, trunc(DHASH.sql_exec_start)
)
, explain_plans as (
Select P.*, 
       ( Select regexp_replace(
                    wm_concat(plan_table_output || chr(10) )
                    , ',(.*)', '\1'
                  )
             from table (
                    DBMS_XPLAN.DISPLAY_AWR(
                      sql_id          => P.sql_id,
                      plan_hash_value => P.sql_plan_hash_value, 
                      db_id           => null,  
                      format          => 'TYPICAL' -- 'ALL' 
                    )
                  ) 
         
         ) explain_plan
  from (Select distinct sql_id, sql_plan_hash_value
          from plans   
       ) p  
)
Select ep.explain_plan,
       /*  ---------------------------------------------------------------------------------------------------
           | Id  | Operation                      | Name             | Rows  | Bytes | Cost (%CPU)| Time     |
           ---------------------------------------------------------------------------------------------------
           |   0 | SELECT STATEMENT               |                  |       |       |     7 (100)|          |
       
        */
       REGEXP_REPLACE( 
         regexp_substr(ep.explain_plan, '\|   0 \|.*'),
         '(\|   0 \|.+?\|.+?\|.+?\|.+?\|)(.+?)(\(\d\).+?\|)',
         '\4'
       ) custo,
       P.* 
  from plans         P,
       explain_plans EP
 where P.sql_id              =  EP.sql_id (+)
   and P.sql_plan_hash_value = EP.sql_plan_hash_value (+)     
      
