declare 
  procedure bn_set_sequence_current_value (pv_sequence_name VARCHAR2, pn_sequence_value NUMBER) is 

    lv_sequence_name VARCHAR2(100) := upper(pv_sequence_name);
    ln_seq_value     NUMBER        := pn_sequence_value; 
    ln_curr_seq      NUMBER;

    le_below_minvalue EXCEPTION;
    pragma exception_init(le_below_minvalue, -8004);
  begin

    Select last_number
      into ln_curr_seq 
      from user_sequences US 
     where US.sequence_name = lv_sequence_name
    ; 

    ln_curr_seq := ((-1 * ln_curr_seq) + 2);  
    dbms_output.put_line('=> ' || ln_curr_seq);

    execute immediate 'ALTER SEQUENCE ' || lv_sequence_name ||  ' INCREMENT BY ' || ln_curr_seq;
    
    begin
    execute immediate 'SELECT ' || lv_sequence_name ||  '.NEXTVAL FROM dual'
       into ln_curr_seq 
    ;
    dbms_output.put_line('=> depois: ' || ln_curr_seq);
    exception 
      when le_below_minvalue then 
        dbms_output.put_line('erro');
        null;
    end; 
   
    execute immediate 'ALTER SEQUENCE ' || lv_sequence_name ||  ' INCREMENT BY ' || (ln_seq_value -2);
    execute immediate 'SELECT ' || lv_sequence_name ||  '.NEXTVAL FROM dual'
       into ln_curr_seq 
    ;
    dbms_output.put_line('=> depois2: ' || ln_curr_seq);
    execute immediate 'ALTER SEQUENCE ' || lv_sequence_name ||  ' INCREMENT BY 1 ';
    
  end bn_set_sequence_current_value;

begin
  bn_set_sequence_current_value ('SEQ_TTM11_SUB_MENU', 248); 

  /*
  Select last_number     
    from user_sequences US 
   where US.sequence_name = 'SEQ_TTM11_SUB_MENU'
  ;
  */
end; 

