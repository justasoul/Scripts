-- Este query devolve o conjunto de instruções a correr para incrementar uma sequencia num dado valor

with sequencias as (

  Select * from user_sequences 
   where sequence_name in ('SEQ_NUM_RESGATE','SEQ_NUM_REFORCO', 'SEQ_NUM_SUBSCRICAO') 

)
Select -- O proximo passo da sequence deverá aumentar no valor pretendido
       'Alter sequence ' || sequence_name || ' increment by ' || :incrementar_em || ';' || chr(10) || 
	   -- Avançar a sequence 
       'Select ' || sequence_name || '.nextval from dual; ' || chr(10) || 
	   -- Repor o passo "original" desta sequence 
       'Alter sequence ' || sequence_name || ' increment by '  || increment_by || '; ' || chr(10) || chr(10) incrementar_sequencia
  from sequencias
;