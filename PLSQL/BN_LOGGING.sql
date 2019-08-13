/* 

  UNDO 
  
  
Drop table bn_log
;
Drop sequence bn_seq_log
;
drop procedure bn_add_log_entry
;
drop procedure BN_ADD_LOG_ENTRY_CLOB
;
drop procedure BN_ADD_LOG_ENTRY_BLOB
;

*/
Create table bn_log(msg varchar2(4000), msg_clob clob, msg_blob blob, n_seq number, data date, times timestamp)
;
CREATE SEQUENCE bn_seq_log
;

CREATE OR REPLACE PROCEDURE BN_ADD_LOG_ENTRY (p_msg varchar) authid current_user
IS PRAGMA AUTONOMOUS_TRANSACTION;
  lclob_msg_clob CLOB;
  lv_msg varchar2(4000);
begin

  if length(p_msg) > 4000 then
    lclob_msg_clob := to_clob(p_msg);
    -- lv_msg := p_msg;
  else
    lv_msg := p_msg;  
  end if;  

  insert into bn_log (n_seq, msg, msg_clob, msg_blob, data, times) values (bn_seq_log.nextval, lv_msg, lclob_msg_clob, null, sysdate, systimestamp);
  
  Commit;
end;

CREATE OR REPLACE PROCEDURE BN_ADD_LOG_ENTRY_CLOB (p_msg CLOB) authid current_user
IS PRAGMA AUTONOMOUS_TRANSACTION;
  lv_msg varchar2(4000);
begin

  insert into bn_log (n_seq, msg, msg_clob, msg_blob, data, times) values (bn_seq_log.nextval, dbms_lob.substr(p_msg, 1, 4000), p_msg, null, sysdate, systimestamp);
  
  Commit;
end;

CREATE OR REPLACE PROCEDURE BN_ADD_LOG_ENTRY_BLOB (p_msg BLOB) authid current_user
IS PRAGMA AUTONOMOUS_TRANSACTION;
  lv_msg varchar2(4000);
begin

  insert into bn_log (n_seq, msg, msg_clob, msg_blob, data, times) values (bn_seq_log.nextval, null, null, p_msg, sysdate, systimestamp);
  
  Commit;
end;


/* 

-> Para extrair os segundos (com componente sequencial) de um timestamp (para depois poder fazer "sum" por exemplo):

to_number( (extract(minute from times) * 60) + (extract(second from times)) )


-> Para saber a linha em que nos encontramos e o package 

bn_add_log_entry('BN ' || $$PLSQL_UNIT || ' LN: ' || $$PLSQL_LINE  );

-> Para determinar a "duração" de cada linha de log

with dataset as (
  Select lead(n_seq) over (order by n_seq asc) next_n_seq,
         bn.* 
    from bn_log bn    
)
Select (bn.data - d.data)*24*60 dif_minutos, d.* 
  from dataset d,
       bn_log  bn
 where d.next_n_seq = bn.n_seq  

*/
