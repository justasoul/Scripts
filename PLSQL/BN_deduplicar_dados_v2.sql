/*
  Utilização
  -------------------------------------------

  -> 1) Correr o query abaixo, tendo o cuidado de validar se se estarão apenas a 
        considerar apenas as tabelas "interessantes" (ver ponto "#1").   

  -> 2) Com os querys devolvidos na coluna "TEM_DUPLICADOS" efectuar um query do tipo (tendo cuidado de remover o último "union"):

       with dataset as (
         <coluna "TEM_DUPLICADOS">
       )
       Select * 
         from dataset
       ;
     
     Isto permitirá identificar as tabelas que apresentarão registos duplicados.

  -> 3) Voltar a correr o query inicial, mas limitando as linhas apresentadas a apenas aquelas
        para as quais se determinou que apresentariam duplicados. 
        Utilizar os deletes da coluna "REMOVER_DUPLICADOS" para remover todos os registos 
        duplicados das tabelas identificadas. 
         
       

*/   

with colunas_tabela as (
  Select table_name,
         substr(lista_colunas, 1, length(lista_colunas) - 2) lista_colunas
    from (Select table_name, 
                 listagg(column_name || ', ') within group (order by column_id Asc) lista_colunas          
            from user_tab_columns 
           where  data_type not in ('CLOB', 'BLOB')
             -- #1 --
             and table_name not in ('PLAN_TABLE', 'SQLN_EXPLAIN_PLAN', 'TGR32_COTACOES_LOG', 'TGR31_COTACOES_LOG_DIA', 
                                    'TCL02_INT_ADESOES_MIGRACAO', 'SRS_CMVM_SIFOX', 'TGR29_USER_LOAD', 'TAB_CONT_LOGINS'
                                   )
             and table_name not like 'CMVM%'
             and table_name not like 'BN%'
             and table_name not like '%$%'
             and table_name not like 'SYS%'
             and table_name not like 'TMP%'
             and table_name not like 'UNO%'
             --------
          group by table_name
         ) 
) 
Select CT.TABLE_NAME,
       UT.num_rows,
       'Select ''' || CT.table_name || ''' table_name ' || chr(10) ||
       '  from ' || CT.table_name || chr(10) ||
       ' group by ' || CT.lista_colunas || ' HAVING count(1) > 1 union ' || chr(10) || 
       ' ' 
       tem_duplicados,

       'Delete from ' || CT.table_name || chr(10) || 
       ' where rowid not in (select min(rowid) ' || chr(10) || 
       '                       from ' || CT.table_name || ' ' || chr(10) ||
       '                      group by ' || CT.lista_colunas || chr(10) || 
       '                    )' || chr(10) || 
       ';' 
       remover_duplicados
     
  from colunas_tabela CT,
       user_tables    UT
 where CT.table_name = UT.table_name
   and CT.table_name 
       in 
      ('TCO02_COTACOES_HIST',
       'TFN03_RENTABILIDADE',
       'TOR01_ORDENS_HIST',
       'TPI02_MOVIMENTOS',
       'TPW03_DICIONARIO',
       'TTG14_AVISOS_USER'
      ) 