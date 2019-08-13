-- Start of DDL Script for Package ERP.UTILS_CSV
-- Generated 16-08-2013 15:16:02 from ERP@dev

CREATE OR REPLACE 
PACKAGE bn_utils_csv AUTHID CURRENT_USER 
/* Formatted on 21-04-2010 18:44:24 (QP5 v5.126) */
IS

  gc_exp_dados   CLOB;

   PROCEDURE exp_dados_cria (pv_query IN VARCHAR2,
                             pv_separador IN VARCHAR2 DEFAULT ';'
   );
   
   FUNCTION get_exp_dados (pv_query IN VARCHAR2,
                           pv_separador IN VARCHAR2 DEFAULT ';'
   )
     RETURN CLOB;
   
   FUNCTION get_exp_dados (pref_cursor IN sys_refcursor,
                           pv_separador IN VARCHAR2 DEFAULT ';'
   )
      RETURN CLOB;  

   FUNCTION get_exp_dados_chunk (p_pos IN NUMBER)
      RETURN VARCHAR2;
      
   function get_coluna(pv_linha varchar2, pn_nr_coluna number, pv_separador_colunas varchar2 default ',') 
     return varchar2;
END bn_utils_csv;
/

CREATE OR REPLACE 
PACKAGE BODY bn_utils_csv
/* Formatted on 21-04-2010 18:43:56 (QP5 v5.126) */
IS
   
   FUNCTION get_exp_dados_base (pn_theCursor in INTEGER,
                           pv_separador IN VARCHAR2 DEFAULT ';'
   )
      RETURN CLOB
   IS
      lc_return       CLOB;

      l_theCursor     INTEGER DEFAULT DBMS_SQL.open_cursor;
      l_columnValue   VARCHAR2 (2000);
      l_status        INTEGER;
      l_colCnt        NUMBER DEFAULT 0;
      l_descTbl       DBMS_SQL.desc_tab;
      e_invalid_cursor EXCEPTION;
      pragma exception_init(e_invalid_cursor, -1001);-- ORA-01001: cursor inválido
   BEGIN
      -- inicialização do CLOB
      DBMS_LOB.createtemporary (lc_return,
                                TRUE,
                                DBMS_LOB.session -- DBMS_LOB.call
                               );

      l_theCursor := pn_theCursor;

      -- Obter cabeçalho --
      DBMS_SQL.describe_columns (l_theCursor, l_colCnt, l_descTbl);
      
      FOR i IN 1 .. l_colCnt
      LOOP
        DBMS_LOB.append (lc_return, l_descTbl (i).col_name || pv_separador);
      END LOOP;
      -- fim de linha
      DBMS_LOB.append (lc_return, CHR (10));

      -- Definir as colunas ?? --
      FOR i IN 1 .. 255
      LOOP
         BEGIN
            DBMS_SQL.define_column (l_theCursor, i, l_columnValue, 2000);
            l_colCnt   := i;
         EXCEPTION
            WHEN OTHERS
            THEN
               IF (SQLCODE = -1007)
               THEN
                  EXIT;
               ELSE
                  RAISE;
               END IF;
         END;
      END LOOP;
      DBMS_SQL.define_column (l_theCursor, 1, l_columnValue, 2000);
      
      -- Obter os dados [Linhas]  --
      begin
        l_status   := DBMS_SQL.execute (l_theCursor);
      
      exception 
        when e_invalid_cursor then -- ORA-01001: cursor inválido, caso tenha sido utilizado um SYS_REFCURSOR
          NUll;        
      end;  
      
      LOOP
         EXIT WHEN (DBMS_SQL.fetch_rows (l_theCursor) <= 0);

         -- Percorrer as várias colunas
         FOR i IN 1 .. l_colCnt
         LOOP
            DBMS_SQL.COLUMN_VALUE (l_theCursor, i, l_columnValue);

            DBMS_LOB.append (lc_return,
                             REPLACE (l_columnValue, CHR (10), '')
                             || pv_separador
            );
         END LOOP;

         -- fim de linha
         DBMS_LOB.append (lc_return, CHR (10));
      END LOOP;
      
      DBMS_SQL.close_cursor (l_theCursor);
      
      RETURN lc_return;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise;
         -- return null;
   END get_exp_dados_base;

   FUNCTION get_exp_dados (pv_query IN VARCHAR2,
                           pv_separador IN VARCHAR2 DEFAULT ';'
   )
      RETURN CLOB IS
      
      l_theCursor     INTEGER DEFAULT DBMS_SQL.open_cursor;
      
   begin
     DBMS_SQL.parse (l_theCursor, pv_query, 1);
     
     return get_exp_dados_base (
              pn_theCursor => l_theCursor, -- in INTEGER ,
              pv_separador => pv_separador-- IN VARCHAR2 DEFAULT ';'
            );  
     
   end;   
   
   FUNCTION get_exp_dados (pref_cursor IN sys_refcursor,
                           pv_separador IN VARCHAR2 DEFAULT ';'
   )
      RETURN CLOB IS
      
      lc_dbms_sql  number;
      lclob_csv CLOB;
      lref_cursor sys_refcursor;
   begin
     
     
     
     lref_cursor := pref_cursor;
     lc_dbms_sql := DBMS_SQL.to_cursor_number(lref_cursor );
     
     lclob_csv := get_exp_dados_base (
                    pn_theCursor => lc_dbms_sql, -- in INTEGER ,
                    pv_separador => pv_separador-- IN VARCHAR2 DEFAULT ';'
                  );  
    
     if lref_cursor%isopen then
       close lref_cursor;
     end if;  
  
     return lclob_csv;          
  
   exception 
     when others then 
       if lref_cursor%isopen then 
         close lref_cursor;
       end if;
    
       raise;  
    
   end get_exp_dados;
   
   

   /**
    *
    *
    *
   **/
   PROCEDURE exp_dados_cria (pv_query IN VARCHAR2,
                             pv_separador IN VARCHAR2 DEFAULT ';'
   )
   IS
   BEGIN
      gc_exp_dados   := get_exp_dados (pv_query, pv_separador);
   END exp_dados_cria;

   FUNCTION get_exp_dados_chunk (p_pos IN NUMBER)
      RETURN VARCHAR2
   IS
      lv_result   VARCHAR2 (4000);
   BEGIN
      lv_result   := SUBSTR (gc_exp_dados, p_pos, 4000);
      RETURN lv_result;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_exp_dados_chunk;
   
   function get_coluna(pv_linha varchar2, pn_nr_coluna number, pv_separador_colunas varchar2 default ',') 
     return varchar2 is
   /* Função que devolve a coluna nº <pn_nr_coluna> de uma dada linha do ficheiro. 
    *
    *@Criacao 24.10.2011 Bruno.Nunes 
    *
    *@PARAM pv_linha              Linha do ficheiro cuja coluna pretendemos obter.
    *@PARAM pn_nr_coluna          Nº da coluna que pretendemos obter. 
    *@PARAM pv_separador_colunas  Caracter que permite distinguir as várias colunas.
   */
   
     lv_res varchar2(32000);
   
   begin
   
     lv_res := rtrim (
                 REGEXP_SUBSTR(pv_linha,'([^'||pv_separador_colunas||']*)('|| pv_separador_colunas||')?($)?', 1, pn_nr_coluna)
                 , pv_separador_colunas
               );
               
     if lv_res = '' then
       lv_res := NULL; 
     end if;           
                   
     return lv_res;
     
   end get_coluna;  
   
END bn_utils_csv;
/


-- End of DDL Script for Package ERP.UTILS_CSV

