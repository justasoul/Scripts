drop view BN_BASE_VW;
drop table BN_BASE;
drop table BN_BASE_COW;


create table BN_BASE (
    col1 varchar2 (100) -- assumir que isto é PK
  , col2 varchar2 (100)
)
;

create table bn_base_COW(
    col1 varchar2 (100)
  , col2 varchar2 (100)

  , status varchar2(10)
 
  , constraint bn_chk_status check ( status in ('INS', 'DEL', 'UPD', 'UPD-COW', 'DEL', 'DEL-COW') )  

)
;

create or replace view bn_base_vw  as 
  Select col1, col2 from bn_base where (col1) not in (Select COW.col1 from bn_base_cow COW )
  union all 
  Select COW.col1, COW.col2 from bn_base_COW COW
   where COW.col1 not in (Select COW1.col1 
                            from bn_base_cow COW1  
                           where status like 'DEL%'
                         )
;

Create or replace trigger bn_trg_bn_base_vw_ioi 
  instead of insert on bn_base_vw 
declare
  ln_cnt NUMBER;
begin

  Select count(1)
    into ln_cnt 
    from bn_base_cow
   where col1 = :NEW.col1
  ; 

  if ln_cnt > 0 then  -- Se a linha já existir na tabela de COW
    update bn_base_COW 
       set col2   = :NEW.col2
         , status = 'INS'  
     where col1 = :NEW.col1
    ; 
  else  
    insert into bn_base_COW (col1, col2, status) values (:new.col1, :new.col2, 'INS');
  end if; 

end bn_trg_bn_base_vw_ioi;

Create or replace trigger bn_trg_bn_base_vw_iou 
  instead of update on bn_base_vw 
declare
  ln_cnt NUMBER;
begin

  Select count(1)
    into ln_cnt 
    from bn_base_cow
   where col1 = :NEW.col1
  ; 

  if ln_cnt > 0 then  -- Se a linha já existir na tabela de COW
    update bn_base_cow
       set col2   = :NEW.col2 
         , status = 'UPD-COW'
     where col1 = :NEW.col1
    ; 
  else 
    -- Se a linha AINDA NÃO EXISTIR na tabela de COW
     insert into bn_base_COW (col1, col2, status) values (:new.col1, :new.col2, 'UPD');
  end if; 
 
end bn_trg_bn_base_vw_iou;

Create or replace trigger bn_trg_bn_base_vw_iod 
  instead of delete on bn_base_vw 
declare
  ln_cnt NUMBER;
begin

  Select count(1)
    into ln_cnt 
    from bn_base_cow
   where col1 = :OLD.col1
  ; 

  if ln_cnt > 0 then  -- Se a linha já existir na tabela de COW
    update bn_base_cow
       set status = 'DEL-COW'
     where col1 = :OLD.col1
    ; 
  else 
    -- Se a linha AINDA NÃO EXISTIR na tabela de COW
     insert into bn_base_COW (col1, col2, status) values (:OLD.col1, null, 'DEL');
  end if; 
 
end bn_trg_bn_base_vw_iod;


