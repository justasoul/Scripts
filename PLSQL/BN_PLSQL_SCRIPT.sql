-- Start of DDL Script for Package OWNER_V1.bn_plsql_script
-- Generated 21/03/2016 16:49:12 from OWNER_V1@vm_xe

CREATE OR REPLACE 
PACKAGE BN_PLSQL_SCRIPT as
-- TODO:
--   -> Handle_cursor: prever o caso de o dataset ter colunas com o mesmo nome (join de duas tabelas)
--                     Criar um único type para apresentar todos os dados relativos às colunas do dataset.
--   -> Criar procedures para imprimir os vários types sob a forma de um varchar2/clob
--
--   -> Criar procedure para extrair o DDL dos vários tipos de objetos
--   -> Criar procedure para encapsular a chamada a um cursor (isopen...close)
--   -> Exception handling (who_am_i, dbms_utility.format_error_backtrace)
--   -> Ver: http://tkyte.blogspot.pt/2006/01/i-like-online-communities.html


-- NOTAS:
--   -> Devolver um CLOB de um execute immediate
--        lv_statement := 'declare ' || chr(10) ||
--                        '  lclob_res clob; ' || chr(10) ||
--                        'begin' || chr(10) ||
--                        '  Select faq into lclob_res from TAR34_FAQS where rownum = 1; ' || chr(10) ||
--                        '  :out := lclob_res; ' || chr(10) ||
--                        'end;'
--                        ;
--
--        execute immediate lv_statement
--                using out l_clobres
--        ;


  -- TYPES --
  ------------------------------------------------------------------------------
  -- subtype t_max_sql_varchar2 is varchar2(4000);


  /*
  subtype t_max_sql_varchar2 is varchar2(4000);

  type t_default_record is record (
    col0001 anydata ,col0002 anydata ,col0003 anydata ,col0004 anydata ,col0005 anydata ,col0006 anydata ,col0007 anydata ,col0008 anydata ,col0009 anydata ,col0010 anydata ,col0011 anydata ,col0012 anydata ,col0013 anydata ,col0014 anydata ,col0015 anydata ,col0016 anydata ,col0017 anydata ,col0018 anydata ,col0019 anydata ,col0020 anydata ,col0021 anydata ,col0022 anydata ,col0023 anydata ,col0024 anydata ,col0025 anydata ,col0026 anydata ,col0027 anydata ,col0028 anydata ,col0029 anydata ,col0030 anydata ,col0031 anydata ,col0032 anydata ,col0033 anydata ,col0034 anydata ,col0035 anydata ,col0036 anydata ,col0037 anydata ,col0038 anydata ,col0039 anydata ,col0040 anydata ,col0041 anydata ,col0042 anydata ,col0043 anydata ,col0044 anydata ,col0045 anydata ,col0046 anydata ,col0047 anydata ,col0048 anydata ,col0049 anydata ,col0050 anydata ,col0051 anydata ,col0052 anydata ,col0053 anydata ,col0054 anydata ,col0055 anydata ,col0056 anydata ,col0057 anydata ,col0058 anydata ,col0059 anydata ,col0060 anydata ,col0061 anydata ,col0062 anydata ,col0063 anydata ,col0064 anydata ,col0065 anydata ,col0066 anydata ,col0067 anydata ,col0068 anydata ,col0069 anydata ,col0070 anydata ,col0071 anydata ,col0072 anydata ,col0073 anydata ,col0074 anydata ,col0075 anydata ,col0076 anydata ,col0077 anydata ,col0078 anydata ,col0079 anydata ,col0080 anydata ,col0081 anydata ,col0082 anydata ,col0083 anydata ,col0084 anydata ,col0085 anydata ,col0086 anydata ,col0087 anydata ,col0088 anydata ,col0089 anydata ,col0090 anydata ,col0091 anydata ,col0092 anydata ,col0093 anydata ,col0094 anydata ,col0095 anydata ,col0096 anydata ,col0097 anydata ,col0098 anydata ,col0099 anydata ,col0100 anydata
  );
  type tt_default_record is table of t_default_record;

  type t_default_record_print is record (
      col0001 t_max_sql_varchar2 ,col0002 t_max_sql_varchar2 ,col0003 t_max_sql_varchar2 ,col0004 t_max_sql_varchar2 ,col0005 t_max_sql_varchar2 ,col0006 t_max_sql_varchar2 ,col0007 t_max_sql_varchar2 ,col0008 t_max_sql_varchar2 ,col0009 t_max_sql_varchar2 ,col0010 t_max_sql_varchar2 ,col0011 t_max_sql_varchar2 ,col0012 t_max_sql_varchar2 ,col0013 t_max_sql_varchar2 ,col0014 t_max_sql_varchar2 ,col0015 t_max_sql_varchar2 ,col0016 t_max_sql_varchar2 ,col0017 t_max_sql_varchar2 ,col0018 t_max_sql_varchar2 ,col0019 t_max_sql_varchar2 ,col0020 t_max_sql_varchar2 ,col0021 t_max_sql_varchar2 ,col0022 t_max_sql_varchar2 ,col0023 t_max_sql_varchar2 ,col0024 t_max_sql_varchar2 ,col0025 t_max_sql_varchar2 ,col0026 t_max_sql_varchar2 ,col0027 t_max_sql_varchar2 ,col0028 t_max_sql_varchar2 ,col0029 t_max_sql_varchar2 ,col0030 t_max_sql_varchar2 ,col0031 t_max_sql_varchar2 ,col0032 t_max_sql_varchar2 ,col0033 t_max_sql_varchar2 ,col0034 t_max_sql_varchar2 ,col0035 t_max_sql_varchar2 ,col0036 t_max_sql_varchar2 ,col0037 t_max_sql_varchar2 ,col0038 t_max_sql_varchar2 ,col0039 t_max_sql_varchar2 ,col0040 t_max_sql_varchar2 ,col0041 t_max_sql_varchar2 ,col0042 t_max_sql_varchar2 ,col0043 t_max_sql_varchar2 ,col0044 t_max_sql_varchar2 ,col0045 t_max_sql_varchar2 ,col0046 t_max_sql_varchar2 ,col0047 t_max_sql_varchar2 ,col0048 t_max_sql_varchar2 ,col0049 t_max_sql_varchar2 ,col0050 t_max_sql_varchar2 ,col0051 t_max_sql_varchar2 ,col0052 t_max_sql_varchar2 ,col0053 t_max_sql_varchar2 ,col0054 t_max_sql_varchar2 ,col0055 t_max_sql_varchar2 ,col0056 t_max_sql_varchar2 ,col0057 t_max_sql_varchar2 ,col0058 t_max_sql_varchar2 ,col0059 t_max_sql_varchar2 ,col0060 t_max_sql_varchar2 ,col0061 t_max_sql_varchar2 ,col0062 t_max_sql_varchar2 ,col0063 t_max_sql_varchar2 ,col0064 t_max_sql_varchar2 ,col0065 t_max_sql_varchar2 ,col0066 t_max_sql_varchar2 ,col0067 t_max_sql_varchar2 ,col0068 t_max_sql_varchar2 ,col0069 t_max_sql_varchar2 ,col0070 t_max_sql_varchar2 ,col0071 t_max_sql_varchar2 ,col0072 t_max_sql_varchar2 ,col0073 t_max_sql_varchar2 ,col0074 t_max_sql_varchar2 ,col0075 t_max_sql_varchar2 ,col0076 t_max_sql_varchar2 ,col0077 t_max_sql_varchar2 ,col0078 t_max_sql_varchar2 ,col0079 t_max_sql_varchar2 ,col0080 t_max_sql_varchar2 ,col0081 t_max_sql_varchar2 ,col0082 t_max_sql_varchar2 ,col0083 t_max_sql_varchar2 ,col0084 t_max_sql_varchar2 ,col0085 t_max_sql_varchar2 ,col0086 t_max_sql_varchar2 ,col0087 t_max_sql_varchar2 ,col0088 t_max_sql_varchar2 ,col0089 t_max_sql_varchar2 ,col0090 t_max_sql_varchar2 ,col0091 t_max_sql_varchar2 ,col0092 t_max_sql_varchar2 ,col0093 t_max_sql_varchar2 ,col0094 t_max_sql_varchar2 ,col0095 t_max_sql_varchar2 ,col0096 t_max_sql_varchar2 ,col0097 t_max_sql_varchar2 ,col0098 t_max_sql_varchar2 ,col0099 t_max_sql_varchar2 ,col0100 t_max_sql_varchar2
    , default_record t_default_record
  );
  type tt_default_record_print is table of t_default_record_print;
  */

  type t_varchar2_v100   is varray(999999) of varchar2(100);
  type tt_varchar2_v100  is table of t_varchar2_v100;
  type t_varchar2_v500   is varray(999999) of varchar2(500);
  type tt_varchar2_v500  is table of  t_varchar2_v500;
  type t_varchar2_v4000  is varray(999999) of varchar2(4000);
  type tt_varchar2_v4000 is table of t_varchar2_v4000;


  type t_varchar2_4000_array  is table of varchar2(4000);
  type t_varchar2_32000_array is table of varchar2(32000);

  type tt_user_objects        is table of user_objects%ROWTYPE;

  ------------------------------------------------------------------------------

  -- GLOBALS --
  ------------------------------------------------------------------------------
  gt_curr_bn_t_default_record  BN_T_DEFAULT_RECORD;
  gt_curr_varchar2_4000_array  T_VARCHAR2_4000_ARRAY;
  ------------------------------------------------------------------------------

  procedure run_as_pragma_autonom_trans (pclob_what_to_run clob, pn_commit pls_integer default 1);

  -- ESPECIFICOS BPIOnline --
  -----------------------------------------------------------------------------------------
  function varchar2_v100_to_clob(parr_valor VARCHAR2_V100)
		return clob;

  function clob_to_varchar2_v100 (pclob_values CLOB)
    return varchar2_v100;

  -- BN_LOGGING --
  ------------------------------------------------------------------------------

  PROCEDURE ADD_LOG_ENTRY      (p_msg VARCHAR2);
  PROCEDURE ADD_LOG_ENTRY_CLOB (p_msg CLOB);
  PROCEDURE ADD_LOG_ENTRY_BLOB (p_msg BLOB);
  PROCEDURE TRUNCATE_LOG;

  ------------------------------------------------------------------------------

  -- CSV --
  ------------------------------------------------------------------------------
  FUNCTION csv_get_exp_dados (
    pv_query       IN VARCHAR2,
    pv_separador   IN VARCHAR2 DEFAULT ';',
    pv_colunas_pretendidas IN VARCHAR2 DEFAULT NULL
  ) RETURN CLOB;

  FUNCTION csv_get_exp_dados (
    pref_cursor            IN SYS_REFCURSOR,
    pv_separador           IN VARCHAR2 DEFAULT ';',
    pv_colunas_pretendidas IN VARCHAR2 DEFAULT NULL
  ) RETURN CLOB;
  ------------------------------------------------------------------------------

  function handle_cursor(
      pc_cursor        in out SYS_REFCURSOR
  ) return bn_t_handled_cursor
  ;

  -- DBMS_OUTPUT --
  ------------------------------------------------------------------------------

  procedure dbms_output_from_clob (pv_clob IN CLOB);
  procedure dbms_output_from_query(
      pv_query               IN VARCHAR2
    , pv_separador           IN VARCHAR2 DEFAULT ';'
    , pv_colunas_pretendidas IN VARCHAR2 DEFAULT NULL
  );

  ------------------------------------------------------------------------------

  -- UTILS --
  ------------------------------------------------------------------------------
  procedure t_varchar2_4000_array_add_rec  (pt_varchar2_4000_array in out T_VARCHAR2_4000_ARRAY, pv_line VARCHAR2);
  procedure t_varchar2_32000_array_add_rec (pt_varchar2_32000_array in out T_VARCHAR2_32000_ARRAY, pv_line VARCHAR2);

  function t_varchar2_4000_array_print(pt_t_varchar2_4000_array T_VARCHAR2_4000_ARRAY)
    return clob;
  function t_varchar2_32000_array_print(pt_t_varchar2_32000_array T_VARCHAR2_32000_ARRAY)
    return clob;

  function split(pv_message VARCHAR2, pv_separator varchar2 default ',')
    return t_varchar2_4000_array pipelined;
  function split(pclob_message CLOB, pv_separator varchar2 default ',')
    return t_varchar2_4000_array pipelined;

  function is_number (pv_string varchar2)
    return number;

  function safe_to_number (pv_string varchar2, pn_value_if_not_number number default NULL)
    return number;

  function safe_clob_to_char(pclob_message CLOB)
    return varchar2;

  function remove_last_n_char(pclob_message CLOB, pn_number_of_char NUMBER)
    return CLOB;

  procedure loop_over_and_do (prfc_loop in out sys_refcursor, pv_statement varchar2);

  ------------------------------------------------------------------------------

  function sql_emmet (pv_query varchar2, pv_token_separator varchar2 default '#', pn_nr_rows_limit number default 10, pv_show_header varchar2 default 'S'  )
    return bn_tt_default_record pipelined;

  function get_tt_default_record (
      pv_query        IN   varchar2
    -- , pt_handled_cursor OUT  t_handled_cursor
  )
    return bn_tt_default_record pipelined;

  function print_tt_default_record (pbn_tt_default_record bn_tt_default_record)
    return bn_tt_default_record_print pipelined;

  function get_sys_ref_cursor_func (pv_package_name varchar2, pv_object_name varchar2)
    return CLOB;

  function who_called_me 
    return varchar2;

  FUNCTION get_html_report (p_query IN VARCHAR2, pv_template varchar2 default 'XSLT_TRANSFORM_BASICO2' )  
    RETURN  CLOB;

  function GET_WHO_AM_I 
    return varchar2;

end BN_PLSQL_SCRIPT;
/


CREATE OR REPLACE 
PACKAGE BODY BN_PLSQL_SCRIPT as

  gtt_sandbox_patterns t_varchar2_4000_array;
  gclob_plsql_script_sandbox  CLOB;

  procedure run_as_pragma_autonom_trans (pclob_what_to_run clob, pn_commit pls_integer default 1) is

    pragma autonomous_transaction;   
  begin 

    execute immediate pclob_what_to_run;

    if pn_commit = 1 then
      commit; 
    end if; 

  end run_as_pragma_autonom_trans;   

  -- ESPECIFICOS BPIOnline --
  -----------------------------------------------------------------------------------------
  function varchar2_v100_to_clob(parr_valor VARCHAR2_V100)
    return clob is
    lclob_res CLOB;
  begin

    Select -- to_clob('varchar2_v100 (') || wm_concat('''' || column_value || '''') || ')'

           replace(
             wm_concat(column_value)
             , to_clob(','), to_clob(';'|| chr(10))
           )
      into lclob_res
      from table(parr_valor)
    ;

    return lclob_res;

  end varchar2_v100_to_clob;

  function clob_to_varchar2_v100 (pclob_values CLOB)
    return varchar2_v100 is
    larr_res VARCHAR2_V100;
  begin

    Select col1
      bulk collect into larr_res
      from table(
             clob_utils.GetTable(
                 pclob_data          => pclob_values
               , pv_separator         => ';'
               , pn_ignore_first_line => 0
               , pv_fixed_col_sizes   => null
             )
           )
    ;

    return larr_res;

  end clob_to_varchar2_v100;


  -- BASES --
  -----------------------------------------------------------------------------------------
  function split_base(pclob_message CLOB, pv_separator varchar2 default ',')
    return t_varchar2_4000_array is

     lt_res         t_varchar2_4000_array;
     lclob_message  CLOB;
     lv_separator   varchar2(100);

     procedure add_line (pv_line varchar2) is
     begin

       t_varchar2_4000_array_add_rec (
           pt_varchar2_4000_array => lt_res -- in out T_VARCHAR2_4000_ARRAY,
         , pv_line                => pv_line
       );

     end add_line;

     PROCEDURE dump_clob (clob IN OUT NOCOPY CLOB) IS
     -- VER: http://jeffkemponoracle.com/2014/09/17/split-clob-into-lines/
       offset NUMBER := 1;
       amount NUMBER := 32767;
       len    NUMBER := DBMS_LOB.getLength(clob);
       buf    VARCHAR2(32767);

       PROCEDURE dump_str (buf IN VARCHAR2) IS
         arr APEX_APPLICATION_GLOBAL.VC_ARR2;
       BEGIN
         arr := APEX_UTIL.string_to_table(buf, lv_separator);
         FOR i IN 1..arr.COUNT LOOP
           IF i < arr.COUNT THEN
             add_line (pv_line => arr(i));
           ELSE
             add_line (pv_line => arr(i));
           END IF;
         END LOOP;
       END dump_str;

     BEGIN
       WHILE offset < len LOOP
         DBMS_LOB.read(clob, amount, offset, buf);
         offset := offset + amount;
         dump_str(buf);
       END LOOP;

       --BN :: DBMS_OUTPUT.new_line;
     END dump_clob;

  begin

    lv_separator  := pv_separator;
    lclob_message := pclob_message;
    lt_res        := new t_varchar2_4000_array();

    dump_clob(clob => lclob_message);

    return lt_res;

  end split_base;



  -- BN_LOGGING --
  ------------------------------------------------------------------------------
  PROCEDURE ADD_LOG_ENTRY (p_msg VARCHAR2)
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
  end ADD_LOG_ENTRY;

  PROCEDURE ADD_LOG_ENTRY_CLOB (p_msg CLOB)
  IS PRAGMA AUTONOMOUS_TRANSACTION;
    lv_msg varchar2(4000);
  begin

    insert into bn_log (n_seq, msg, msg_clob, msg_blob, data, times) values (bn_seq_log.nextval, dbms_lob.substr(p_msg, 1, 4000), p_msg, null, sysdate, systimestamp);

    Commit;
  end ADD_LOG_ENTRY_CLOB;

  PROCEDURE ADD_LOG_ENTRY_BLOB (p_msg BLOB)
  IS PRAGMA AUTONOMOUS_TRANSACTION;
    lv_msg varchar2(4000);
  begin

    insert into bn_log (n_seq, msg, msg_clob, msg_blob, data, times) values (bn_seq_log.nextval, null, null, p_msg, sysdate, systimestamp);

    Commit;
  end ADD_LOG_ENTRY_BLOB;

  PROCEDURE TRUNCATE_LOG
  IS PRAGMA AUTONOMOUS_TRANSACTION;
  begin

    execute immediate 'truncate table bn_log';

  end TRUNCATE_LOG;

  ------------------------------------------------------------------------------


  -- CSV --
  ------------------------------------------------------------------------------

  FUNCTION csv_get_exp_dados_base (
      pn_thecursor           IN   INTEGER
    , pv_separador           IN   VARCHAR2 DEFAULT ';'
    , pv_separador_linhas    IN   VARCHAR2 DEFAULT chr(10)
    , pv_colunas_pretendidas IN   VARCHAR2 DEFAULT NULL
    , pv_show_header         IN   VARCHAR2 DEFAULT 'S'
    , pt_handled_cursor      OUT  bn_t_handled_cursor
  ) RETURN CLOB
  IS

    lt_handled_cursor  bn_t_handled_cursor := bn_t_handled_cursor;
    ln_cursor_number   NUMBER;
    lrc_refcursor      sys_refcursor;

    lc_return          CLOB;

    -- l_thecursor        INTEGER DEFAULT DBMS_SQL.open_cursor;
    l_columnvalue      VARCHAR2 (4000);
    l_status           INTEGER;
    l_colcnt           NUMBER DEFAULT 0;
    l_desctbl          DBMS_SQL.desc_tab;
    e_invalid_cursor   EXCEPTION;
    PRAGMA EXCEPTION_INIT (e_invalid_cursor, -1001); -- ORA-01001: cursor inv¿lido
  BEGIN

    ln_cursor_number  := pn_thecursor;
    BEGIN
      dbms_output.put_line( dbms_sql.execute(ln_cursor_number));
    EXCEPTION
      WHEN e_invalid_cursor THEN
        -- ORA-01001: cursor invalido, caso tenha sido utilizado um SYS_REFCURSOR
        NULL;
    END;
    lrc_refcursor     := dbms_sql.to_refcursor(ln_cursor_number);
    lt_handled_cursor := handle_cursor(pc_cursor => lrc_refcursor);

    -- inicializa¿¿o do CLOB
    DBMS_LOB.createtemporary (
      lc_return,
      TRUE,
      DBMS_LOB.session -- DBMS_LOB.call
    );

    if upper(pv_show_header) = 'S' then
      -- Adicionar Cabeçalho
      FOR i IN 1 .. lt_handled_cursor.column_count LOOP

        if (pv_colunas_pretendidas is null)        or
           (instr(pv_colunas_pretendidas, (i || ',') ) > 0 )
        then
          DBMS_LOB.append (lc_return, lt_handled_cursor.dbms_sql_column_info(i).col_name || pv_separador);
        else
          null;
        end if;

      END LOOP;

      -- fim de linha
      DBMS_LOB.append (lc_return, pv_separador_linhas);

    end if;



    /*
    -- Obter os dados [Linhas]  --
    BEGIN
      l_status := DBMS_SQL.execute (lt_handled_cursor.cursor_number);
    EXCEPTION
      WHEN e_invalid_cursor
      THEN -- ORA-01001: cursor inv¿lido, caso tenha sido utilizado um SYS_REFCURSOR
        NULL;
    END;
    */

   /*
    -- Definir as colunas ?? --
    FOR i IN 1 .. 255
    LOOP
      BEGIN
        DBMS_SQL.define_column (lt_handled_cursor.cursor_number,
                                i,
                                l_columnvalue,
                                2000);
        l_colcnt := i;
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
    */

    LOOP
      EXIT WHEN (DBMS_SQL.fetch_rows (lt_handled_cursor.cursor_number) <= 0);

      -- Percorrer as v¿rias colunas
      FOR i IN 1 .. lt_handled_cursor.column_count
      LOOP

        if (pv_colunas_pretendidas is null)        or
           (instr(pv_colunas_pretendidas, (i || ',') ) > 0 )
        then

          DBMS_SQL.COLUMN_VALUE (lt_handled_cursor.cursor_number, i, l_columnvalue);
          DBMS_LOB.append (
            lc_return,
            REPLACE (l_columnvalue, pv_separador_linhas, '') || pv_separador
          );
        else
          null;
        end if;

      END LOOP;

      -- fim de linha
      DBMS_LOB.append (lc_return, pv_separador_linhas);
    END LOOP;

    DBMS_SQL.close_cursor (lt_handled_cursor.cursor_number);

    if lrc_refcursor%isopen then
      close lrc_refcursor;
    end if;

    pt_handled_cursor := lt_handled_cursor;

    RETURN lc_return;
  EXCEPTION
    WHEN OTHERS THEN
      if lrc_refcursor%isopen then
        close lrc_refcursor;
      end if;

      dbms_output.put_line('[EXCEPT] :: ' || dbms_utility.format_error_backtrace);

      RAISE;
  -- return null;
  END csv_get_exp_dados_base;


  FUNCTION csv_get_exp_dados (
    pv_query       IN VARCHAR2,
    pv_separador   IN VARCHAR2 DEFAULT ';',
    pv_colunas_pretendidas IN VARCHAR2 DEFAULT NULL
  ) RETURN CLOB
  IS
    l_thecursor        INTEGER DEFAULT DBMS_SQL.open_cursor;
    lt_handled_cursor  bn_t_handled_cursor := bn_t_handled_cursor();
  BEGIN

    DBMS_SQL.parse (l_thecursor, pv_query, 1);

    RETURN csv_get_exp_dados_base (
               pn_thecursor           => l_thecursor
             , pv_separador           => pv_separador
             , pv_colunas_pretendidas => pv_colunas_pretendidas
             , pt_handled_cursor      => lt_handled_cursor
           );
  END csv_get_exp_dados;

  FUNCTION csv_get_exp_dados (
    pref_cursor            IN SYS_REFCURSOR,
    pv_separador           IN VARCHAR2 DEFAULT ';',
    pv_colunas_pretendidas IN VARCHAR2 DEFAULT NULL
  ) RETURN CLOB
  IS
    lc_dbms_sql       NUMBER;
    lclob_csv         CLOB;
    lref_cursor       SYS_REFCURSOR;

    lt_handled_cursor BN_T_HANDLED_CURSOR := BN_T_HANDLED_CURSOR();

  BEGIN
    lref_cursor := pref_cursor;
    lc_dbms_sql := DBMS_SQL.to_cursor_number (lref_cursor);

    lclob_csv := csv_get_exp_dados_base (
                     pn_thecursor           => lc_dbms_sql
                   , pv_separador           => pv_separador
                   , pv_colunas_pretendidas => PV_COLUNAS_PRETENDIDAS
                   , pt_handled_cursor      => lt_handled_cursor
                 );

    IF lref_cursor%ISOPEN
    THEN
      CLOSE lref_cursor;
    END IF;

    RETURN lclob_csv;
  EXCEPTION
    WHEN OTHERS
    THEN
      IF lref_cursor%ISOPEN
      THEN
        CLOSE lref_cursor;
      END IF;
      dbms_output.put_line('[EXCEPT :: csv_get_exp_dados] :: ' || dbms_utility.format_error_backtrace);
      RAISE;
  END csv_get_exp_dados;

  ------------------------------------------------------------------------------


  -- DBMS_OUTPUT --
  ------------------------------------------------------------------------------

  procedure dbms_output_from_clob (pv_clob IN CLOB) is
  -- VER: http://jeffkemponoracle.com/2014/09/17/split-clob-into-lines/
    lv_clob CLOB;
    lt_res  T_VARCHAR2_4000_ARRAY;
  begin
    lv_clob := pv_clob;

    lt_res := split_base(
                  pclob_message => pv_clob
                , pv_separator  => chr(10)
              );

    for i in 1..lt_res.count loop
      dbms_output.put_line(lt_res(i));
    end loop;

  end dbms_output_from_clob;

  procedure dbms_output_from_query(
      pv_query               IN VARCHAR2
    , pv_separador           IN VARCHAR2 DEFAULT ';'
    , pv_colunas_pretendidas IN VARCHAR2 DEFAULT NULL
  ) is
  begin

    dbms_output_from_clob(
      csv_get_exp_dados(
          pv_query               => pv_query
        , pv_separador           => pv_separador
        , pv_colunas_pretendidas => pv_colunas_pretendidas
      )
    );

  end dbms_output_from_query;

  ------------------------------------------------------------------------------


  procedure sandbox (pv_operacao varchar2, pv_param varchar2 default NULL, pclob_payload CLOB default NULL) is
    lv_operacao varchar2(500) := upper(pv_operacao);
  begin

    case lv_operacao
      when 'INITIALIZE' then
        begin
          gclob_plsql_script_sandbox := to_clob(
                                          'Create or replace package bn_plsql_script_sandbox as '      || chr(10) ||
                                          ' [SPEC_FIM] '                                               || chr(10) ||
                                          'end bn_plsql_script_sandbox; '                              -- || chr(10) ||
                                          -- Nao posso correr duas instruções no mesmo execute immediate??!!
                                          -- '  '                                                         || chr(10) ||
                                          -- 'Create or replace package body bn_plsql_script_sandbox as ' || chr(10) ||
                                          -- ' [BODY_FIM] '                                               || chr(10) ||
                                          -- 'end bn_plsql_script_sandbox; '                              || chr(10) ||
                                          -- '/ '                                                         || chr(10) ||
                                          -- '  '
                                        );
        end;
      when 'ADD' then
        begin
          gclob_plsql_script_sandbox := replace(
                                            gclob_plsql_script_sandbox
                                          , pv_param
                                          , to_clob(chr(10)) ||
                                               pclob_payload ||
                                             to_clob(chr(10) || pv_param)
                                        );
        end;
      when 'FINALIZE' then
        begin
          for i in 1..gtt_sandbox_patterns.count loop
            gclob_plsql_script_sandbox := replace (gclob_plsql_script_sandbox, to_clob(gtt_sandbox_patterns(i)), to_clob(''));
          end loop;
        end;


      else
        raise_application_error(-200001, 'Opera??o "' || lv_operacao || '" n?o prevista! ');
    end case;

  end sandbox;

  procedure execute_immediate (pclob_statement CLOB) is
  begin
    execute immediate pclob_statement;
  end execute_immediate;

  function get_dbms_sql_type (pn_col_type binary_integer, pn_charset_form binary_integer, pn_precision binary_integer, pn_scale binary_integer, pn_max_length binary_integer)
    return varchar2 is
    lv_res VARCHAR2(300);
  begin

     Select decode(types.type_cod,
                   1, decode(pn_charset_form, 2, 'NVARCHAR2', 'VARCHAR2') || '(' || pn_max_length || ')',
                   2, decode(pn_scale, null, decode(pn_precision, null, 'NUMBER', 'FLOAT'), 'NUMBER'),
                   8, 'LONG',
                   9, decode(pn_charset_form, 2, 'NCHAR VARYING', 'VARCHAR'),
                   11, 'ROWID', -- ??
                   12, 'DATE',
                   23, 'RAW',
                   24, 'LONG RAW',
                   -- 58, nvl2(ac.synobj#, (select o.name from obj$ o where o.obj#=ac.synobj#), ot.name),
                   69, 'ROWID',
                   96, decode(pn_charset_form, 2, 'NCHAR', 'CHAR'),
                   100, 'BINARY_FLOAT',
                   101, 'BINARY_DOUBLE',
                   105, 'MLSLABEL',
                   106, 'MLSLABEL',
                   -- 111, nvl2(ac.synobj#, (select o.name from obj$ o where o.obj#=ac.synobj#), ot.name),
                   112, decode(pn_charset_form, 2, 'NCLOB', 'CLOB'),
                   113, 'BLOB',
                   114, 'BFILE',
                   115, 'CFILE',
                   -- 121, nvl2(ac.synobj#, (select o.name from obj$ o where o.obj#=ac.synobj#), ot.name),
                   -- 122, nvl2(ac.synobj#, (select o.name from obj$ o where o.obj#=ac.synobj#), ot.name),
                   -- 123, nvl2(ac.synobj#, (select o.name from obj$ o where o.obj#=ac.synobj#), ot.name),

                   178, 'TIME(' ||pn_scale|| ')',
                   179, 'TIME(' ||pn_scale|| ')' || ' WITH TIME ZONE',
                   180, 'TIMESTAMP(' ||pn_scale|| ')',
                   181, 'TIMESTAMP(' ||pn_scale|| ')' || ' WITH TIME ZONE',
                   231, 'TIMESTAMP(' ||pn_scale|| ')' || ' WITH LOCAL TIME ZONE',
                   182, 'INTERVAL YEAR(' ||pn_precision||') TO MONTH',
                   183, 'INTERVAL DAY(' ||pn_precision||') TO SECOND(' || pn_scale || ')',
                   208, 'UROWID',
                   -- 'UNDEFINED'
                   types.type_desc
                ) descricao
    into lv_res
    from (  select   trim(chr(10) from trim(regexp_replace(ALLS.text, r.regex, '\5', 1, 1, 'i'))) type_cod
                   , trim(chr(10) from trim(regexp_replace(ALLS.text, r.regex, '\3', 1, 1, 'i')))  type_desc
              from all_source ALLS,
                   (Select '(typecode_)(.*?)(.*?)(PLS_INTEGER :=)(.*?)(;)(.*?)($)' regex from dual) R
             where ALLS.owner = 'SYS'
               and ALLS.name  = 'DBMS_TYPES'
               and ALLS.type  = 'PACKAGE'
               and ALLS.text  like '%TYPECODE%'
         ) types
   where types.type_cod = pn_col_type
   ;

   return lv_res;
  exception
    when others then
      dbms_output.put_line('BN.get_dbms_sql_type [EXCEPT]: pn_col_type: ' || pn_col_type || ' :: ' || sqlerrm || ' - ' || dbms_utility.format_error_backtrace);
      raise;
  end get_dbms_sql_type;

  function handle_cursor(
  --
  -- Permite obter uma descricao das varias colunas que representam um sys_refcursor que
  -- seja devolvido por essas funções, bem como alguns varchar que permitem gerar código relativo a esse cursor
  --
      pc_cursor        in out SYS_REFCURSOR

  ) return bn_t_handled_cursor is

    -- ln_cursor_number NUMBER;
    ln_colcnt        NUMBER;

    lv_columnValue             varchar2(4000);

    lv_column_name_list        varchar2(32000);
    lv_column_decl_variables   varchar2(32000);
    lv_column_decl_type        varchar2(32000);

    ld_date                    date;

    lt_res           BN_T_HANDLED_CURSOR := BN_T_HANDLED_CURSOR();

    lt_desc_tab3     DBMS_SQL.desc_tab3;

  begin

    -- Converter o cursor num cursor de DBMS_SQL
    lt_res.cursor_number := dbms_sql.to_cursor_number(pc_cursor);

    -- Obter uma descri??o das v?rias colunas
    dbms_sql.describe_columns3(
        c       => lt_res.cursor_number
      , col_cnt => ln_colcnt
      , desc_t  => lt_desc_tab3
    );
    lt_res.column_count          := ln_colcnt;
    lt_res.dbms_sql_column_info  := bn_tt_column_info();
    lv_column_name_list          := '';
    lv_column_decl_variables     := '';
    for i in 1..lt_desc_tab3.count loop

      lt_res.dbms_sql_column_info.extend;
      lt_res.dbms_sql_column_info(i) := bn_t_column_info();
      lt_res.dbms_sql_column_info(i).col_type             :=  lt_desc_tab3(i).col_type;
      lt_res.dbms_sql_column_info(i).col_max_len          :=  lt_desc_tab3(i).col_max_len;
      lt_res.dbms_sql_column_info(i).col_name             :=  lt_desc_tab3(i).col_name;
      lt_res.dbms_sql_column_info(i).col_name_len         :=  lt_desc_tab3(i).col_name_len;
      lt_res.dbms_sql_column_info(i).col_schema_name      :=  lt_desc_tab3(i).col_schema_name;
      lt_res.dbms_sql_column_info(i).col_schema_name_len  :=  lt_desc_tab3(i).col_schema_name_len;
      lt_res.dbms_sql_column_info(i).col_precision        :=  lt_desc_tab3(i).col_precision;
      lt_res.dbms_sql_column_info(i).col_scale            :=  lt_desc_tab3(i).col_scale;
      lt_res.dbms_sql_column_info(i).col_charsetid        :=  lt_desc_tab3(i).col_charsetid;
      lt_res.dbms_sql_column_info(i).col_charsetform      :=  lt_desc_tab3(i).col_charsetform;
      lt_res.dbms_sql_column_info(i).col_null_ok          :=  case when lt_desc_tab3(i).col_null_ok then 'S' else 'N' end;
      lt_res.dbms_sql_column_info(i).col_type_name        :=  lt_desc_tab3(i).col_type_name;
      lt_res.dbms_sql_column_info(i).col_type_name_len    :=  lt_desc_tab3(i).col_type_name_len;

      lv_column_name_list := lv_column_name_list || ' ' || lt_res.dbms_sql_column_info(i).col_name || ',';

      lv_column_decl_variables := lv_column_decl_variables ||
                                  'lvar_' || lt_res.dbms_sql_column_info(i).col_name || '  ' ||
                                  get_dbms_sql_type (
                                      pn_col_type     => lt_res.dbms_sql_column_info(i).col_type
                                    , pn_charset_form => lt_res.dbms_sql_column_info(i).col_charsetform
                                    , pn_precision    => lt_res.dbms_sql_column_info(i).col_precision
                                    , pn_scale        => lt_res.dbms_sql_column_info(i).col_scale
                                    , pn_max_length   => lt_res.dbms_sql_column_info(i).col_max_len
                                  ) ||
                                  ';' || chr(10)
                                  ;

      lv_column_decl_type      := lv_column_decl_type || '  ' || chr(10) ||
                                  lt_res.dbms_sql_column_info(i).col_name  || '  ' ||
                                  get_dbms_sql_type (
                                      pn_col_type     => lt_res.dbms_sql_column_info(i).col_type
                                    , pn_charset_form => lt_res.dbms_sql_column_info(i).col_charsetform
                                    , pn_precision    => lt_res.dbms_sql_column_info(i).col_precision
                                    , pn_scale        => lt_res.dbms_sql_column_info(i).col_scale
                                    , pn_max_length   => lt_res.dbms_sql_column_info(i).col_max_len
                                  ) ||
                                  ','
                                  ;

    end loop;
    -- Retirar a última virgula
    lt_res.column_name_list := substr(lv_column_name_list, 1, (length(lv_column_name_list) - 1));

    lt_res.column_decl_variables := lv_column_decl_variables;
    lt_res.column_decl_type      := 'type t_cursor_record_type is record ( ' || chr(10) ||
                                    substr(lv_column_decl_type, 1, (length(lv_column_decl_type) - 1)) || chr(10) ||
                                    ');' || chr(10) ||
                                    'type tt_cursor_record_type is table of t_cursor_record_type;' || chr(10)
                                    ;

    -- Caso se tenha indicado que se pretende visualizar as colunas encontradas...
    -- if pn_print = 1 then
    --   for i in 1 .. pn_colcnt
    --   loop
    --     dbms_output.put_line( pt_desctbl(i).col_name );
    --   end loop;
    -- end if;

    -- define all columns to be cast to varchar2's, we
    -- are just printing them out
    for i in 1 .. ln_colcnt loop
      -- Criar uma collection para conseguir determinar o indice da coluna com base no seu nome.
      -- Utilizado pelas v?rias chamadas ?s fun??es para determinar que valor devem obter
      -- do sys_refcursor que estas tenham devolvido.
      -- lt_column_index_by_name(upper(lt_res.dbms_sql_column_info(i).col_name)) := to_char(i);

      -- if ( lt_res.dbms_sql_column_info(i).col_type in ( 12, 178, 179, 180, 181, 231 ) ) then
      --   dbms_sql.define_column (lt_res.cursor_number, i, ld_date );
      -- else
        dbms_sql.define_column (lt_res.cursor_number, i, lv_columnValue, 4000);
      -- end if;
    end loop;

   -- lt_res.column_index_by_name := lt_column_index_by_name;

    return lt_res;

  end handle_cursor;

  function get_cursor_row_type_decl (pt_handled_cursor bn_t_handled_cursor)
    return clob  is
    lclob_res CLOB;
  begin

    lclob_res := to_clob('type sys_refcursor_' || trunc(dbms_random.value(low=> 1, high=> 1000)) || ' is record ( ');

    for i in 1..pt_handled_cursor.dbms_sql_column_info.count loop
      lclob_res := lclob_res ||
                   to_clob(
                     case when i > 1 then '  ,' else '  ' end ||
                     pt_handled_cursor.dbms_sql_column_info(i).col_name || '  ' ||
                     get_dbms_sql_type (
                         pn_col_type     => pt_handled_cursor.dbms_sql_column_info(i).col_type
                       , pn_charset_form => pt_handled_cursor.dbms_sql_column_info(i).col_charsetform
                       , pn_precision    => pt_handled_cursor.dbms_sql_column_info(i).col_precision
                       , pn_scale        => pt_handled_cursor.dbms_sql_column_info(i).col_scale
                       , pn_max_length   => pt_handled_cursor.dbms_sql_column_info(i).col_max_len
                     )
                   );

    end loop;
    lclob_res := lclob_res || to_clob(');');

    return lclob_res;

  end get_cursor_row_type_decl;

  -- UTILS --
  ------------------------------------------------------------------------------
  procedure t_varchar2_4000_array_add_rec (pt_varchar2_4000_array in out T_VARCHAR2_4000_ARRAY, pv_line VARCHAR2) is
    ln_res NUMBER;
  begin

    begin
      ln_res := pt_varchar2_4000_array.count;
    exception
      when COLLECTION_IS_NULL then
        pt_varchar2_4000_array := T_VARCHAR2_4000_ARRAY();

    end;

    pt_varchar2_4000_array.extend;
    pt_varchar2_4000_array(pt_varchar2_4000_array.count) := pv_line;

  end t_varchar2_4000_array_add_rec;

  procedure t_varchar2_32000_array_add_rec (pt_varchar2_32000_array in out T_VARCHAR2_32000_ARRAY, pv_line VARCHAR2) is
    ln_res NUMBER;
  begin

    begin
      ln_res := pt_varchar2_32000_array.count;
    exception
      when COLLECTION_IS_NULL then
        pt_varchar2_32000_array := T_VARCHAR2_32000_ARRAY();

    end;

    pt_varchar2_32000_array.extend;
    pt_varchar2_32000_array(pt_varchar2_32000_array.count) := pv_line;

  end t_varchar2_32000_array_add_rec;

  function t_varchar2_4000_array_print(pt_t_varchar2_4000_array T_VARCHAR2_4000_ARRAY)
    return clob is

    lclob_res CLOB;
  begin

    lclob_res := to_clob('');

    for i in 1..pt_t_varchar2_4000_array.count loop

      lclob_res := lclob_res || pt_t_varchar2_4000_array(i) || to_clob(chr(10));

    end loop;

    return lclob_res;

  end t_varchar2_4000_array_print;

  function t_varchar2_32000_array_print(pt_t_varchar2_32000_array T_VARCHAR2_32000_ARRAY)
    return clob is

    lclob_res CLOB;
  begin

    lclob_res := to_clob('');

    for i in 1..pt_t_varchar2_32000_array.count loop

      lclob_res := lclob_res || pt_t_varchar2_32000_array(i) || to_clob(chr(10));

    end loop;

    return lclob_res;

  end t_varchar2_32000_array_print;

  function split(pv_message varchar2, pv_separator varchar2 default ',')
    return t_varchar2_4000_array pipelined is

    lt_res T_VARCHAR2_4000_ARRAY;

  begin
    lt_res := split_base(
                  pclob_message => to_clob(pv_message)
                , pv_separator  => pv_separator
              );

    for i in 1..lt_res.count loop

      pipe row (lt_res(i));

    end loop;

    return;

  end split;

  function split(pclob_message CLOB, pv_separator varchar2 default ',')
    return t_varchar2_4000_array pipelined is

    lt_res T_VARCHAR2_4000_ARRAY;

  begin
    lt_res := split_base(
                  pclob_message => pclob_message
                , pv_separator  => pv_separator
              );

    for i in 1..lt_res.count loop

      pipe row (lt_res(i));

    end loop;

    return;

  end split;

  function is_number (pv_string varchar2)
    return number is
    ln_res number;
  begin
    ln_res := to_number(pv_string);
    return 1;
  exception
    when VALUE_ERROR then
      return 0;
  end is_number;

  function safe_to_number (pv_string varchar2, pn_value_if_not_number number default NULL)
    return number is
  begin
    if is_number(pv_string => pv_string) = 1 then
      return to_number(pv_string);
    else
      return nvl(pn_value_if_not_number, NULL);
    end if;
  end safe_to_number;

  function safe_clob_to_char(pclob_message CLOB)
    return varchar2 is

    lv_res varchar2(4000);

  begin

    lv_res := dbms_lob.substr(
                lob_loc => pclob_message,
                amount  => 4000,
                offset  => 1
              );

    return lv_res;

  end safe_clob_to_char;

  function remove_last_n_char(pclob_message CLOB, pn_number_of_char NUMBER)
    return CLOB is

   ln_length NUMBER;
  begin

   ln_length := dbms_lob.getlength(lob_loc=> pclob_message);

   return substr(
              pclob_message
            , 1
            , (ln_length + ((-1 * pn_number_of_char)) )
          );

  end remove_last_n_char;

  procedure loop_over_and_do (prfc_loop in out sys_refcursor, pv_statement varchar2) is

    lt_handled_cursor    BN_T_HANDLED_CURSOR := BN_T_HANDLED_CURSOR();
    lclob_rowtype_decl   CLOB;
    lv_rowtype_decl_name VARCHAR2(100);

    ln_dbms_sql_cursor_number NUMBER;

    lclob_statement        CLOB;

    lclob_exec_immed_statement  CLOB;

    procedure handle_pv_statement is
    begin
      lclob_statement := to_clob('');
      -- [COL::BAR]
      lclob_statement := lclob_statement ||
                         to_clob(
                           regexp_replace(
                             pv_statement,
                             '(\[COL::)(([^]]*))(\])',
                             'lrt_record.\2'
                           )
                         );

    end handle_pv_statement;


    procedure add_to_exec_immed_statement(pv_snippet CLOB) is
    begin
      lclob_exec_immed_statement := nvl(lclob_exec_immed_statement, to_clob('')) ||
                                    to_clob(pv_snippet || chr(10));

    end add_to_exec_immed_statement;

  begin

    handle_pv_statement;

    lt_handled_cursor := handle_cursor(pc_cursor  => prfc_loop);

    add_to_exec_immed_statement('DECLARE ');
    -- Criar um type que representa o dataset deste cursor
    add_to_exec_immed_statement(lt_handled_cursor.column_decl_type);
    add_to_exec_immed_statement(
      '  ln_dbms_sql_cursor_number NUMBER := ' || lt_handled_cursor.cursor_number || '; ' || chr(10) ||
      '  lrefc sys_refcursor := DBMS_sql.to_refcursor(ln_dbms_sql_cursor_number);' || chr(10) ||
      '  lrt_record t_cursor_record_type;' || chr(10) ||
      'BEGIN' || chr(10) ||
      '  loop fetch lrefc into lrt_record;' || chr(10) ||
      '    exit when lrefc%NOTFOUND; '
    );
    -- O que fazer durante o loop --
    --------------------------------
    add_to_exec_immed_statement(lclob_statement);
    --------------------------------
    add_to_exec_immed_statement('  end loop;' || chr(10) ||
                                'END;'
    );
     ----

    execute immediate lclob_exec_immed_statement;

  end loop_over_and_do;

  ------------------------------------------------------------------------------

  function get_tt_default_record (
      pv_query        IN   varchar2
    -- , pt_handled_cursor OUT  t_handled_cursor
  )
    return bn_tt_default_record pipelined is

   ln_thecursor       NUMBER;

   lt_handled_cursor  bn_t_handled_cursor := BN_T_HANDLED_CURSOR();
   ln_cursor_number   NUMBER;
   lrc_refcursor      sys_refcursor;

   la_column_value    ANYDATA;
   lt_curr_record     bn_t_default_record;

   e_invalid_cursor   EXCEPTION;
   PRAGMA EXCEPTION_INIT (e_invalid_cursor, -1001); -- ORA-01001: cursor inv¿lido

   ltt_res bn_tt_default_record;

    function bn_handle_cursor(
    --
    -- Permite obter uma descricao das varias colunas que representam um sys_refcursor que
    -- seja devolvido por essas funções, bem como alguns varchar que permitem gerar código relativo a esse cursor
    --
        pc_cursor        in out SYS_REFCURSOR

    ) return bn_t_handled_cursor is

      -- ln_cursor_number NUMBER;
      ln_colcnt        NUMBER;

      la_column_value  ANYDATA;

      lv_columnValue             varchar2(4000);

      lv_column_name_list        varchar2(32000);
      lv_column_decl_variables   varchar2(32000);
      lv_column_decl_type        varchar2(32000);

      ld_date                    date;

      lt_res           bn_t_handled_cursor := BN_T_HANDLED_CURSOR();

      lt_desc_tab3     DBMS_SQL.desc_tab3;

    begin

      -- Converter o cursor num cursor de DBMS_SQL
      lt_res.cursor_number := dbms_sql.to_cursor_number(pc_cursor);

      -- Obter uma descri??o das v?rias colunas
      dbms_sql.describe_columns3(
          c       => lt_res.cursor_number
        , col_cnt => ln_colcnt
        , desc_t  => lt_desc_tab3
      );
      lt_res.column_count          := ln_colcnt;
      lt_res.dbms_sql_column_info  := bn_tt_column_info();
      lv_column_name_list          := '';
      lv_column_decl_variables     := '';
      for i in 1..lt_desc_tab3.count loop

        lt_res.dbms_sql_column_info.extend;
        lt_res.dbms_sql_column_info(i) := bn_t_column_info();
        lt_res.dbms_sql_column_info(i).col_type             :=  lt_desc_tab3(i).col_type;
        lt_res.dbms_sql_column_info(i).col_max_len          :=  lt_desc_tab3(i).col_max_len;
        lt_res.dbms_sql_column_info(i).col_name             :=  lt_desc_tab3(i).col_name;
        lt_res.dbms_sql_column_info(i).col_name_len         :=  lt_desc_tab3(i).col_name_len;
        lt_res.dbms_sql_column_info(i).col_schema_name      :=  lt_desc_tab3(i).col_schema_name;
        lt_res.dbms_sql_column_info(i).col_schema_name_len  :=  lt_desc_tab3(i).col_schema_name_len;
        lt_res.dbms_sql_column_info(i).col_precision        :=  lt_desc_tab3(i).col_precision;
        lt_res.dbms_sql_column_info(i).col_scale            :=  lt_desc_tab3(i).col_scale;
        lt_res.dbms_sql_column_info(i).col_charsetid        :=  lt_desc_tab3(i).col_charsetid;
        lt_res.dbms_sql_column_info(i).col_charsetform      :=  lt_desc_tab3(i).col_charsetform;
        lt_res.dbms_sql_column_info(i).col_null_ok          :=  case when lt_desc_tab3(i).col_null_ok then 'S' else 'N' end;
        lt_res.dbms_sql_column_info(i).col_type_name        :=  lt_desc_tab3(i).col_type_name;
        lt_res.dbms_sql_column_info(i).col_type_name_len    :=  lt_desc_tab3(i).col_type_name_len;

        lv_column_name_list := lv_column_name_list || ' ' || lt_res.dbms_sql_column_info(i).col_name || ',';

        lv_column_decl_variables := lv_column_decl_variables ||
                                    'lvar_' || lt_res.dbms_sql_column_info(i).col_name || '  ' ||
                                    get_dbms_sql_type (
                                        pn_col_type     => lt_res.dbms_sql_column_info(i).col_type
                                      , pn_charset_form => lt_res.dbms_sql_column_info(i).col_charsetform
                                      , pn_precision    => lt_res.dbms_sql_column_info(i).col_precision
                                      , pn_scale        => lt_res.dbms_sql_column_info(i).col_scale
                                      , pn_max_length   => lt_res.dbms_sql_column_info(i).col_max_len
                                    ) ||
                                    ';' || chr(10)
                                    ;

        lv_column_decl_type      := lv_column_decl_type || '  ' || chr(10) ||
                                    lt_res.dbms_sql_column_info(i).col_name  || '  ' ||
                                    get_dbms_sql_type (
                                        pn_col_type     => lt_res.dbms_sql_column_info(i).col_type
                                      , pn_charset_form => lt_res.dbms_sql_column_info(i).col_charsetform
                                      , pn_precision    => lt_res.dbms_sql_column_info(i).col_precision
                                      , pn_scale        => lt_res.dbms_sql_column_info(i).col_scale
                                      , pn_max_length   => lt_res.dbms_sql_column_info(i).col_max_len
                                    ) ||
                                    ','
                                    ;

      end loop;
      -- Retirar a última virgula
      lt_res.column_name_list := substr(lv_column_name_list, 1, (length(lv_column_name_list) - 1));

      lt_res.column_decl_variables := lv_column_decl_variables;
      lt_res.column_decl_type      := 'type t_cursor_record_type is record ( ' || chr(10) ||
                                      substr(lv_column_decl_type, 1, (length(lv_column_decl_type) - 1)) || chr(10) ||
                                      ');' || chr(10) ||
                                      'type tt_cursor_record_type is table of t_cursor_record_type;' || chr(10)
                                      ;

      -- Caso se tenha indicado que se pretende visualizar as colunas encontradas...
      -- if pn_print = 1 then
      --   for i in 1 .. pn_colcnt
      --   loop
      --     dbms_output.put_line( pt_desctbl(i).col_name );
      --   end loop;
      -- end if;

      -- define all columns to be cast to varchar2's, we
      -- are just printing them out
      for i in 1 .. ln_colcnt loop
        -- Criar uma collection para conseguir determinar o indice da coluna com base no seu nome.
        -- Utilizado pelas v?rias chamadas ?s fun??es para determinar que valor devem obter
        -- do sys_refcursor que estas tenham devolvido.
        --lt_column_index_by_name(upper(lt_res.dbms_sql_column_info(i).col_name)) := to_char(i);

        -- if ( lt_res.dbms_sql_column_info(i).col_type in ( 12, 178, 179, 180, 181, 231 ) ) then
        --   dbms_sql.define_column (lt_res.cursor_number, i, ld_date );
        -- else

        -- dbms_sql.define_column (lt_res.cursor_number, i, lv_columnValue, 4000);
        -- dbms_output.put_line('TEMP.bn_handle_cursor :: [' || i || '] #' || lt_desc_tab3(i).col_type_name || '# ' || lt_res.dbms_sql_column_info(i).col_type_name);
        case when lt_res.dbms_sql_column_info(i).col_type in (1, 9, 96) -- ('VARCHAR2', 'VARCHAR', 'CHAR')
                  then declare
                         lv_varchar2 VARCHAR2(4000);
                       begin
                         dbms_sql.define_column (lt_res.cursor_number, i, lv_varchar2, 4000);
                       end;
             when lt_res.dbms_sql_column_info(i).col_type in (2) -- ('NUMBER', 'PLS_INTEGER')
                  then declare
                         ln_number NUMBER;
                       begin
                         dbms_sql.define_column (lt_res.cursor_number, i, ln_number);
                       end;
             when lt_res.dbms_sql_column_info(i).col_type in (112) -- ('CLOB')
                  then declare
                         lclob_clob CLOB;
                       begin
                         dbms_sql.define_column (lt_res.cursor_number, i, lclob_clob);
                       end;
             else
                  declare
                    lv_varchar2 VARCHAR2(4000);
                  begin
                    dbms_sql.define_column (lt_res.cursor_number, i, lv_varchar2, 4000);
                  end;
        end case;

        -- end if;
      end loop;

      --lt_res.column_index_by_name := lt_column_index_by_name;

      return lt_res;

    end bn_handle_cursor;

    procedure to_any_data_column(pn_column_index in number, pa_anydata_column in out ANYDATA) is
    begin

      case when lt_handled_cursor.dbms_sql_column_info(pn_column_index).col_type in (1, 9, 96) --  ('VARCHAR2', 'VARCHAR', 'CHAR')
                then declare
                       lv_varchar2 VARCHAR2(4000);
                     begin
                       DBMS_SQL.COLUMN_VALUE (lt_handled_cursor.cursor_number, pn_column_index, lv_varchar2);
                       pa_anydata_column := sys.anydata.convertvarchar2(lv_varchar2);
                     end;
           when lt_handled_cursor.dbms_sql_column_info(pn_column_index).col_type in (2) -- ('NUMBER', 'PLS_INTEGER')
                then declare
                       ln_number NUMBER;
                     begin
                       DBMS_SQL.COLUMN_VALUE (lt_handled_cursor.cursor_number, pn_column_index, ln_number);
                       pa_anydata_column := sys.anydata.convertnumber(ln_number);
                     end;
           when lt_handled_cursor.dbms_sql_column_info(pn_column_index).col_type in (112) -- ('CLOB')
                then declare
                       lclob_clob CLOB;
                     begin
                       DBMS_SQL.COLUMN_VALUE (lt_handled_cursor.cursor_number, pn_column_index, lclob_clob);
                       pa_anydata_column := sys.anydata.convertClob(lclob_clob);
                     end;
             else
                  declare
                    lv_varchar2 VARCHAR2(4000);
                  begin
                    DBMS_SQL.COLUMN_VALUE (lt_handled_cursor.cursor_number, pn_column_index, lv_varchar2);
                    pa_anydata_column := sys.anydata.convertvarchar2(lv_varchar2);
                  end;
      end case;


    exception
      when SUBSCRIPT_BEYOND_COUNT then
        declare
          lv_varchar2 VARCHAR2(4000);
        begin
          pa_anydata_column := null;
        end;
    end to_any_data_column;

  begin

    ln_thecursor := DBMS_SQL.open_cursor;
    DBMS_SQL.parse (ln_thecursor, pv_query, 1);

    ln_cursor_number  := ln_thecursor;
    BEGIN
      dbms_output.put_line( dbms_sql.execute(ln_cursor_number));
    EXCEPTION
      WHEN e_invalid_cursor THEN
        -- ORA-01001: cursor invalido, caso tenha sido utilizado um SYS_REFCURSOR
        NULL;
    END;

    lrc_refcursor     := dbms_sql.to_refcursor(ln_cursor_number);
    lt_handled_cursor := bn_handle_cursor(pc_cursor => lrc_refcursor);

    -- HEADER --

    -- Percorrer o DATASET
    LOOP
    EXIT WHEN (DBMS_SQL.fetch_rows (lt_handled_cursor.cursor_number) <= 0);
      lt_curr_record  := bn_t_default_record();

      -- Para Cada coluna
      -- FOR i IN 1 .. lt_handled_cursor.column_count
      -- LOOP

      begin
        to_any_data_column(pn_column_index => 1,   pa_anydata_column => lt_curr_record.col0001);
        to_any_data_column(pn_column_index => 2,   pa_anydata_column => lt_curr_record.col0002);
        to_any_data_column(pn_column_index => 3,   pa_anydata_column => lt_curr_record.col0003);
        to_any_data_column(pn_column_index => 4,   pa_anydata_column => lt_curr_record.col0004);
        to_any_data_column(pn_column_index => 5,   pa_anydata_column => lt_curr_record.col0005);
        to_any_data_column(pn_column_index => 6,   pa_anydata_column => lt_curr_record.col0006);
        to_any_data_column(pn_column_index => 7,   pa_anydata_column => lt_curr_record.col0007);
        to_any_data_column(pn_column_index => 8,   pa_anydata_column => lt_curr_record.col0008);
        to_any_data_column(pn_column_index => 9,   pa_anydata_column => lt_curr_record.col0009);
        to_any_data_column(pn_column_index => 10,  pa_anydata_column => lt_curr_record.col0010);
        to_any_data_column(pn_column_index => 11,  pa_anydata_column => lt_curr_record.col0011);
        to_any_data_column(pn_column_index => 12,  pa_anydata_column => lt_curr_record.col0012);
        to_any_data_column(pn_column_index => 13,  pa_anydata_column => lt_curr_record.col0013);
        to_any_data_column(pn_column_index => 14,  pa_anydata_column => lt_curr_record.col0014);
        to_any_data_column(pn_column_index => 15,  pa_anydata_column => lt_curr_record.col0015);
        to_any_data_column(pn_column_index => 16,  pa_anydata_column => lt_curr_record.col0016);
        to_any_data_column(pn_column_index => 17,  pa_anydata_column => lt_curr_record.col0017);
        to_any_data_column(pn_column_index => 18,  pa_anydata_column => lt_curr_record.col0018);
        to_any_data_column(pn_column_index => 19,  pa_anydata_column => lt_curr_record.col0019);
        to_any_data_column(pn_column_index => 20,  pa_anydata_column => lt_curr_record.col0020);
        to_any_data_column(pn_column_index => 21,  pa_anydata_column => lt_curr_record.col0021);
        to_any_data_column(pn_column_index => 22,  pa_anydata_column => lt_curr_record.col0022);
        to_any_data_column(pn_column_index => 23,  pa_anydata_column => lt_curr_record.col0023);
        to_any_data_column(pn_column_index => 24,  pa_anydata_column => lt_curr_record.col0024);
        to_any_data_column(pn_column_index => 25,  pa_anydata_column => lt_curr_record.col0025);
        to_any_data_column(pn_column_index => 26,  pa_anydata_column => lt_curr_record.col0026);
        to_any_data_column(pn_column_index => 27,  pa_anydata_column => lt_curr_record.col0027);
        to_any_data_column(pn_column_index => 28,  pa_anydata_column => lt_curr_record.col0028);
        to_any_data_column(pn_column_index => 29,  pa_anydata_column => lt_curr_record.col0029);
        to_any_data_column(pn_column_index => 30,  pa_anydata_column => lt_curr_record.col0030);
        to_any_data_column(pn_column_index => 31,  pa_anydata_column => lt_curr_record.col0031);
        to_any_data_column(pn_column_index => 32,  pa_anydata_column => lt_curr_record.col0032);
        to_any_data_column(pn_column_index => 33,  pa_anydata_column => lt_curr_record.col0033);
        to_any_data_column(pn_column_index => 34,  pa_anydata_column => lt_curr_record.col0034);
        to_any_data_column(pn_column_index => 35,  pa_anydata_column => lt_curr_record.col0035);
        to_any_data_column(pn_column_index => 36,  pa_anydata_column => lt_curr_record.col0036);
        to_any_data_column(pn_column_index => 37,  pa_anydata_column => lt_curr_record.col0037);
        to_any_data_column(pn_column_index => 38,  pa_anydata_column => lt_curr_record.col0038);
        to_any_data_column(pn_column_index => 39,  pa_anydata_column => lt_curr_record.col0039);
        to_any_data_column(pn_column_index => 40,  pa_anydata_column => lt_curr_record.col0040);
        to_any_data_column(pn_column_index => 41,  pa_anydata_column => lt_curr_record.col0041);
        to_any_data_column(pn_column_index => 42,  pa_anydata_column => lt_curr_record.col0042);
        to_any_data_column(pn_column_index => 43,  pa_anydata_column => lt_curr_record.col0043);
        to_any_data_column(pn_column_index => 44,  pa_anydata_column => lt_curr_record.col0044);
        to_any_data_column(pn_column_index => 45,  pa_anydata_column => lt_curr_record.col0045);
        to_any_data_column(pn_column_index => 46,  pa_anydata_column => lt_curr_record.col0046);
        to_any_data_column(pn_column_index => 47,  pa_anydata_column => lt_curr_record.col0047);
        to_any_data_column(pn_column_index => 48,  pa_anydata_column => lt_curr_record.col0048);
        to_any_data_column(pn_column_index => 49,  pa_anydata_column => lt_curr_record.col0049);
        to_any_data_column(pn_column_index => 50,  pa_anydata_column => lt_curr_record.col0050);
        to_any_data_column(pn_column_index => 51,  pa_anydata_column => lt_curr_record.col0051);
        to_any_data_column(pn_column_index => 52,  pa_anydata_column => lt_curr_record.col0052);
        to_any_data_column(pn_column_index => 53,  pa_anydata_column => lt_curr_record.col0053);
        to_any_data_column(pn_column_index => 54,  pa_anydata_column => lt_curr_record.col0054);
        to_any_data_column(pn_column_index => 55,  pa_anydata_column => lt_curr_record.col0055);
        to_any_data_column(pn_column_index => 56,  pa_anydata_column => lt_curr_record.col0056);
        to_any_data_column(pn_column_index => 57,  pa_anydata_column => lt_curr_record.col0057);
        to_any_data_column(pn_column_index => 58,  pa_anydata_column => lt_curr_record.col0058);
        to_any_data_column(pn_column_index => 59,  pa_anydata_column => lt_curr_record.col0059);
        to_any_data_column(pn_column_index => 60,  pa_anydata_column => lt_curr_record.col0060);
        to_any_data_column(pn_column_index => 61,  pa_anydata_column => lt_curr_record.col0061);
        to_any_data_column(pn_column_index => 62,  pa_anydata_column => lt_curr_record.col0062);
        to_any_data_column(pn_column_index => 63,  pa_anydata_column => lt_curr_record.col0063);
        to_any_data_column(pn_column_index => 64,  pa_anydata_column => lt_curr_record.col0064);
        to_any_data_column(pn_column_index => 65,  pa_anydata_column => lt_curr_record.col0065);
        to_any_data_column(pn_column_index => 66,  pa_anydata_column => lt_curr_record.col0066);
        to_any_data_column(pn_column_index => 67,  pa_anydata_column => lt_curr_record.col0067);
        to_any_data_column(pn_column_index => 68,  pa_anydata_column => lt_curr_record.col0068);
        to_any_data_column(pn_column_index => 69,  pa_anydata_column => lt_curr_record.col0069);
        to_any_data_column(pn_column_index => 70,  pa_anydata_column => lt_curr_record.col0070);
        to_any_data_column(pn_column_index => 71,  pa_anydata_column => lt_curr_record.col0071);
        to_any_data_column(pn_column_index => 72,  pa_anydata_column => lt_curr_record.col0072);
        to_any_data_column(pn_column_index => 73,  pa_anydata_column => lt_curr_record.col0073);
        to_any_data_column(pn_column_index => 74,  pa_anydata_column => lt_curr_record.col0074);
        to_any_data_column(pn_column_index => 75,  pa_anydata_column => lt_curr_record.col0075);
        to_any_data_column(pn_column_index => 76,  pa_anydata_column => lt_curr_record.col0076);
        to_any_data_column(pn_column_index => 77,  pa_anydata_column => lt_curr_record.col0077);
        to_any_data_column(pn_column_index => 78,  pa_anydata_column => lt_curr_record.col0078);
        to_any_data_column(pn_column_index => 79,  pa_anydata_column => lt_curr_record.col0079);
        to_any_data_column(pn_column_index => 80,  pa_anydata_column => lt_curr_record.col0080);
        to_any_data_column(pn_column_index => 81,  pa_anydata_column => lt_curr_record.col0081);
        to_any_data_column(pn_column_index => 82,  pa_anydata_column => lt_curr_record.col0082);
        to_any_data_column(pn_column_index => 83,  pa_anydata_column => lt_curr_record.col0083);
        to_any_data_column(pn_column_index => 84,  pa_anydata_column => lt_curr_record.col0084);
        to_any_data_column(pn_column_index => 85,  pa_anydata_column => lt_curr_record.col0085);
        to_any_data_column(pn_column_index => 86,  pa_anydata_column => lt_curr_record.col0086);
        to_any_data_column(pn_column_index => 87,  pa_anydata_column => lt_curr_record.col0087);
        to_any_data_column(pn_column_index => 88,  pa_anydata_column => lt_curr_record.col0088);
        to_any_data_column(pn_column_index => 89,  pa_anydata_column => lt_curr_record.col0089);
        to_any_data_column(pn_column_index => 90,  pa_anydata_column => lt_curr_record.col0090);
        to_any_data_column(pn_column_index => 91,  pa_anydata_column => lt_curr_record.col0091);
        to_any_data_column(pn_column_index => 92,  pa_anydata_column => lt_curr_record.col0092);
        to_any_data_column(pn_column_index => 93,  pa_anydata_column => lt_curr_record.col0093);
        to_any_data_column(pn_column_index => 94,  pa_anydata_column => lt_curr_record.col0094);
        to_any_data_column(pn_column_index => 95,  pa_anydata_column => lt_curr_record.col0095);
        to_any_data_column(pn_column_index => 96,  pa_anydata_column => lt_curr_record.col0096);
        to_any_data_column(pn_column_index => 97,  pa_anydata_column => lt_curr_record.col0097);
        to_any_data_column(pn_column_index => 98,  pa_anydata_column => lt_curr_record.col0098);
        to_any_data_column(pn_column_index => 99,  pa_anydata_column => lt_curr_record.col0099);
        to_any_data_column(pn_column_index => 100, pa_anydata_column => lt_curr_record.col0100);

        lt_curr_record.curr_handled_cursor := lt_handled_cursor;

      end;


      -- end loop;

      pipe row (lt_curr_record);

    end loop;

    DBMS_SQL.close_cursor (lt_handled_cursor.cursor_number);

    if lrc_refcursor%isopen then
      close lrc_refcursor;
    end if;

    RETURN; -- ltt_res;

  EXCEPTION
    WHEN OTHERS THEN
      if lrc_refcursor%isopen then
        close lrc_refcursor;
      end if;

      dbms_output.put_line('[EXCEPT] :: ' || dbms_utility.format_error_backtrace);

      RAISE;
  -- return null;
  end get_tt_default_record;

  function print_tt_default_record (pbn_tt_default_record bn_tt_default_record)
    return bn_tt_default_record_print pipelined
  is

  begin
    for i in 1..pbn_tt_default_record.count loop

      pipe row (pbn_tt_default_record(i).get_print);

    end loop;
  exception
    when NO_DATA_NEEDED then
     dbms_output.put_line('TEMP_PRINT: NO_DATA_NEEDED' );
    when others then
      dbms_output.put_line('TEMP_PRINT :: EXCEPT: ' || sqlerrm || ' - ' || dbms_utility.format_error_backtrace);
      raise;
  end print_tt_default_record;

  function sql_emmet (pv_query varchar2, pv_token_separator varchar2 default '#', pn_nr_rows_limit number default 10, pv_show_header varchar2 default 'S' )
    return bn_tt_default_record pipelined is

    l_thecursor               INTEGER;
    lt_handled_cursor         BN_T_HANDLED_CURSOR := BN_T_HANDLED_CURSOR();
    lclob_res                 CLOB;
    lt_res                    bn_tt_default_record;
    lt_varchar2_4000_array    T_VARCHAR2_4000_ARRAY;

    lv_query                  VARCHAR2(32000);
    lclob_query_final         CLOB :=  to_clob(
                                         'Select [SELECT_CLAUSE] '                      || chr(10) ||
                                         '  from [FROM_CLAUSE]'                         || chr(10) ||
                                         ' where 1 = 1 '                                || chr(10) ||
                                         '   and rownum < ' || pn_nr_rows_limit || ' '  || chr(10) ||
                                         '       [WHERE_CLAUSE]'
                                       );

    lv_separador_csv          VARCHAR2(10) := '$%&/()=';
    lv_separador_csv_linhas   VARCHAR2(10) := '/()=??(';

    procedure get_query_final is
      type t_token is record (
          full_token      VARCHAR2(4000)
        , left_hand_side  VARCHAR2(4000)
        , right_hand_side VARCHAR2(4000)
      );

      lv_table_name USER_TABLES.TABLE_NAME%TYPE;


      lt_curr_token  t_token;
      lt_tokens      T_VARCHAR2_4000_ARRAY;

      procedure handle_passthrough is
      begin
        lclob_query_final := to_clob(lt_curr_token.right_hand_side);
      end handle_passthrough;


      procedure handle_select_clause is
        lv_select_clause VARCHAR2(32000);
      begin

        lv_select_clause := '';

        case lt_curr_token.left_hand_side
          when 'S' then
            begin
              lv_select_clause := lv_select_clause || ' ' || lt_curr_token.right_hand_side;
            end;
        end case;

        lclob_query_final := replace(lclob_query_final, to_clob('[SELECT_CLAUSE]'), to_clob(lv_select_clause));

      end handle_select_clause;

      procedure handle_from_clause is
      begin
        begin
          with dataset as (
            Select table_name
              from all_tables
            union all
            Select view_name table_name
              from all_views
          )
          Select distinct table_name
            into lv_table_name
            from dataset
           where table_name like lt_curr_token.right_hand_side || '%'
          ;

        exception
          when TOO_MANY_ROWS then
            begin
              with dataset as (
                Select table_name
                  from all_tables
                union all
                Select view_name table_name
                  from all_views
              )
              Select distinct table_name
                into lv_table_name
                from dataset
               where table_name like lt_curr_token.right_hand_side || '%'
                 and table_name not like lt_curr_token.right_hand_side || '%_HIST'
                 and table_name not like lt_curr_token.right_hand_side || '%_OLD'
              ;
            exception
              when TOO_MANY_ROWS then
                begin
                  with dataset as (
                    Select table_name
                      from all_tables
                    union all
                    Select view_name table_name
                      from all_views
                  )
                  Select distinct table_name
                    into lv_table_name
                    from dataset
                   where table_name = lt_curr_token.right_hand_side
                  ;
                exception
                  when TOO_MANY_ROWS or NO_DATA_FOUND then
                    raise_application_error(-20001, 'O token "' || lt_curr_token.full_token || '" não representa unívocamente uma tabela/view!');
                end;
            end;
        end;

        lclob_query_final := replace(lclob_query_final, to_clob('[FROM_CLAUSE]'), to_clob(lv_table_name));

      end handle_from_clause;

      procedure handle_where_clause is
        lt_where_values  T_VARCHAR2_4000_ARRAY;
        lv_where_clause  VARCHAR2(32000) := '';
        lv_column_name   USER_CONS_COLUMNS.COLUMN_NAME%TYPE;
        ln_tem_pk        NUMBER;
      begin

        case lt_curr_token.left_hand_side
          when 'W' then
            begin
              lv_where_clause := lv_where_clause || ' and ' || lt_curr_token.right_hand_side;
            end;
          when 'WPK' then
            begin
              lt_where_values := split_base(
                                    pclob_message => to_clob(lt_curr_token.right_hand_side),
                                    pv_separator  => ','
                                  );

              for i in 1..lt_where_values.count loop
                begin
                  ln_tem_pk := 0;

                  Select count(1)
                    into ln_tem_pk
                    from user_constraints UC
                   where UC.table_name      = lv_table_name
                     and UC.constraint_type = 'P'
                  ;
                  if ln_tem_pk = 1 then
                    begin
                      lv_column_name := '';

                      Select column_name
                        into lv_column_name
                        from user_cons_columns UCC
                       where UCC.constraint_name = (Select UC.constraint_name
                                                      from user_constraints UC
                                                     where UC.table_name      = lv_table_name
                                                       and UC.constraint_type = 'P'
                                                   )
                         and UCC.position = i
                      ;

                      lv_where_clause := lv_where_clause || ' and ' || lv_column_name || ' = ''' || lt_where_values(i) || ''' ' ;

                    exception
                      when no_data_found then
                        raise_application_error(-20001, 'Foram declaradas mais colunas do que as prevista pela PK da tabela!');
                    end;
                  end if;
                end;
              end loop;
            end;
        end case;

        lclob_query_final := replace(lclob_query_final, to_clob('[WHERE_CLAUSE]'), to_clob( chr(10) || lv_where_clause));

      end handle_where_clause;
      -- 's:tor02 w:19258350'
    begin

      lv_query          := trim(pv_query);

      if pv_token_separator = ':' then
        raise_application_error(-20001, 'O "pv_token_separator" não pode ser ":" !');
      end if;

      -- Tokenize the received query
      lt_tokens := bn_plsql_script.split_base(
                       pclob_message => to_clob(lv_query)
                     , pv_separator  => pv_token_separator
                   );

      dbms_output_from_clob(
        t_varchar2_4000_array_print(lt_tokens)
      );

      for i in 1..lt_tokens.count loop
        lt_curr_token            := NULL;
        lt_curr_token.full_token := lt_tokens(i);

        -- Validações/ Expandir query
        if instr(lt_curr_token.full_token, ':') = 0 then
          raise_application_error(-20001, 'O token "' || lt_curr_token.full_token || '" não apresenta o caracter ":" ');
        end if;

        lt_curr_token.left_hand_side  := upper(regexp_replace(lt_curr_token.full_token, '([^:]*):([^:]*)', '\1'));

        lt_curr_token.right_hand_side := regexp_replace(lt_curr_token.full_token, '([^:]*):([^:]*)', '\2');
        lt_curr_token.right_hand_side := case when lt_curr_token.left_hand_side <> 'PASSTHROUGH' then upper(lt_curr_token.right_hand_side)
                                              else lt_curr_token.right_hand_side
                                          end
                                         ;

        -- ToDo: !! validar a sequencia de tokens !!

        case when lt_curr_token.left_hand_side in ('PASSTHROUGH') then handle_passthrough;
             when lt_curr_token.left_hand_side in ('S')           then handle_select_clause;
             when lt_curr_token.left_hand_side in ('F')           then handle_from_clause;
             when lt_curr_token.left_hand_side in ('W', 'WPK')    then handle_where_clause;
             else raise_application_error(-20001, 'O LHS: "' || lt_curr_token.left_hand_side || '" do token: "' || lt_curr_token.full_token || '" não está previsto!');
        end case;

        --
      end loop;

      -- clear patterns
      lclob_query_final := replace(lclob_query_final, to_clob('[SELECT_CLAUSE]'), to_clob(' * '));
      lclob_query_final := replace(lclob_query_final, to_clob('[FROM_CLAUSE]'), to_clob(''));
      lclob_query_final := replace(lclob_query_final, to_clob('[WHERE_CLAUSE]'), to_clob(''));
    exception
      when others then
        dbms_output.put_line('bn_plsql_script.sql_emmet.get_query_final: ' || sqlerrm || ' - ' || dbms_utility.format_error_backtrace);
        raise;
    end get_query_final;

    procedure get_column_values(pclob_record CLOB, ptt_recordset IN OUT bn_tt_default_record) is
      lt_valores_colunas        T_VARCHAR2_4000_ARRAY;
      lv_execute_immediate_stat VARCHAR2(32000);
    begin
      lt_valores_colunas := bn_plsql_script.split_base(
                                pclob_message => pclob_record
                              , pv_separator  => lv_separador_csv
                            );

      if lt_valores_colunas.count > 0 then
        ptt_recordset.extend;
        gt_curr_varchar2_4000_array := NULL;
        gt_curr_varchar2_4000_array := lt_valores_colunas;

        lv_execute_immediate_stat := '';
        for i in 1..lt_valores_colunas.count loop
          lv_execute_immediate_stat := lv_execute_immediate_stat ||
                                       '  bn_plsql_script.gt_curr_bn_t_default_record.col' || lpad(i, 4, '0') || ' := bn_plsql_script.gt_curr_varchar2_4000_array(' || i || '); ' || chr(10);
        end loop;

        lv_execute_immediate_stat := 'begin '                                               || chr(10) ||
                                     '  bn_plsql_script.gt_curr_bn_t_default_record := NULL; ' || chr(10) ||
                                     lv_execute_immediate_stat                              || chr(10) ||
                                     'end; '
        ;

        execute immediate lv_execute_immediate_stat;
        ptt_recordset(ptt_recordset.count) := gt_curr_bn_t_default_record;

      end if;

    end get_column_values;


  begin

    -- obter query final
    get_query_final;

    dbms_output_from_clob(to_clob('BN - QUERY_FINAL: ') || lclob_query_final);

    -- get_tt_default_record (
    --    pv_query        IN   varchar2
    --  -- , pt_handled_cursor OUT  t_handled_cursor
    -- )

    -- Apartida, o "CSV_GET_EXP_DADOS_BASE"  já deve ter fechado o cursor

  end sql_emmet;

  FUNCTION GetTable(
    pclob_data              CLOB,
    pv_separator            VARCHAR2 default ',',
    pn_ignore_first_line    NUMBER   default 0,
    pv_fixed_col_sizes      VARCHAR2 default null
    -- pv_fixed_regex          VARCHAR2 default NULL,
    -- pv_fixed_regex_replace  VARCHAR2 default NULL

  )
   RETURN bn_tt_default_record_print  PIPELINED
  IS
  --  Esta função permite, com base num clob que representa um CSV ou ficheiro
  --  com campos de tamanho fixo, apresentar estes dados como se de uma tabela
  --  se tratasse.
  --  Neste momento está limitado a apresentar até 40 colunas, mas não é complicado aumentar caso seja necessário.
  --
  --
  --  BMN, 10/03/2014
  --
  --  PARAM pclob_data              CLOB com os dados a apresentar.
  --  PARAM pv_separator            Separador a utilizar para identificar as colunas.
  --  PARAM pn_ignore_first_line    Indicar se se pretende ou não ignorar a primeira
  --                                linha do <p_clob_data>. Útil nos casos de CSV's
  --                                em que a primeira linha apresenta os nomes das colunas
  --                                1 - Ignora a primeira linha, 0 - Não ignora a primeira linha
  --  PARAM pv_fixed_regex          No caso dos ficheiro de tamnho fixo, apresentar a regex que permita
  --                                identificar cada coluna. Em conjunto com o parâmetro <pv_fixed_regex_replace>
  --                                permitirá "transformar" cada linha num linha "CSV". Ex:
  --
  --                                  '(.{8})(.{10})(.{8})(.{6})(.{16})(.{19})(.{4})(.{19})(.{19})(.{1})(.{8})(.{12})(.{12})(.{8})(.{8})(.{4})(.{4})(.{19})(.{20})(.{19})(.{19})(.{19})(.{19})(.{19})(.{19})(.{19})'
  --
  --  PARAM pv_fixed_regex_replace  Ver comentário do parâmetro <pv_fixed_regex>. Ex:
  --
  --                                  '\1,\2,\3,\4,\5,\6,\7,\8,\9,\10,\11,\12,\13,\14,\15,\16,\17,\18,\19,\20,\21,\22,\23,\24,\25,\26'
  --
  --
  --  USAGE / EXEMPLO:
  --
  --          Select *
  --            from table(
  --                   clob_utils.getcsvtable(
  --                     pclob_data              =>  lclob_um_clob,
  --                     pn_ignore_first_line    =>  0,
  --                     pv_fixed_regex          =>  NULL,
  --                     pv_fixed_regex_replace  =>  NULL
  --                   )
  --                 )
  --          ;
  --
  --
  --          Select *
  --            from table(
  --                   bn_temp_csv_to_schema.getcsvtable(
  --                     pclob_data              =>  (Select col1 from bn_temp where descr = 'DELIMITED'),
  --                     pn_ignore_first_line    =>  0,
  --                     pv_fixed_regex          =>  NULL,
  --                     pv_fixed_regex_replace  =>  NULL
  --                   )
  --                 )
  --          --  where col1 like '"Volkswagen%'
  --          --order by col1 asc
  --          ;
  --
  --          Select *
  --            from table(
  --                   bn_temp_csv_to_schema.getcsvtable(
  --                     pclob_data              =>  (Select col1 from bn_temp where descr = 'FIXED_WIDTH'),
  --                     pn_ignore_first_line    =>  0,
  --                     pv_fixed_regex          =>  '(.{8})(.{10})(.{8})(.{6})(.{16})(.{19})(.{4})(.{19})(.{19})(.{1})(.{8})(.{12})(.{12})(.{8})(.{8})(.{4})(.{4})(.{19})(.{20})(.{19})(.{19})(.{19})(.{19})(.{19})(.{19})(.{19})',
  --                     pv_fixed_regex_replace  =>  '\1,\2,\3,\4,\5,\6,\7,\8,\9,\10,\11,\12,\13,\14,\15,\16,\17,\18,\19,\20,\21,\22,\23,\24,\25,\26'
  --                   )
  --                 )
  --          ;
  --

     lclob_data CLOB;

     lt_linhas_clob          T_VARCHAR2_4000_ARRAY;
     ltt_clob_as_anydata     BN_TT_DEFAULT_RECORD;
     lt_curr_default_record  BN_T_DEFAULT_RECORD;
  BEGIN

    LCLOB_DATA := pclob_data;

    /* BN :: COMENTADO APENAS PARA COMPILAR ::
    lt_linhas_clob := split_base(pclob_message => , pv_separator => chr(10))

    ltt_clob_as_anydata := BN_TT_DEFAULT_RECORD();
    for i in 1..lt_linhas_clob.count loop
      -- Para cada linha do clob;
      lt_curr_default_record := BN_T_DEFAULT_RECORD();
      lt_curr_default_record.col0001 := sys.anydata.getvarchar2(lt_linhas_clob(i));

      BN_TT_DEFAULT_RECORD.extend;
      BN_TT_DEFAULT_RECORD(BN_TT_DEFAULT_RECORD.count) := lt_curr_default_record;
    end loop;

    -- RES: bn_tt_default_record_print

    for i in 1..ltt_clob_as_anydata.count loop

      pipe row (pbn_tt_default_record(i).get_print);

    end loop;
    */
    NULL;

  exception
    when NO_DATA_NEEDED then
     dbms_output.put_line('GetTable: NO_DATA_NEEDED' );
    when others then
      dbms_output.put_line('GetTable :: EXCEPT: ' || sqlerrm || ' - ' || dbms_utility.format_error_backtrace);
      raise;

  END GetTable;


  function get_sys_ref_cursor_func (pv_package_name varchar2, pv_object_name varchar2)
    return CLOB is

    lv_package_name varchar2(100);
    lv_object_name  varchar2(100);

    ln_is_a_function number;

    type t_templ_map_rec is record (pattern VARCHAR2(2000), mapping varchar2(32000));
    type ttb_t_templ_map_recs is table of t_templ_map_rec;

    lc_IN_PARAMETER_DECLARATION constant VARCHAR2(2000) := '#*IN_PARAMETER_DECLARATION*#';
    lc_WRAPPED_PROC_FUNCT_NAME  constant VARCHAR2(2000) := '#*WRAPPED_PROC_FUNCT_NAME*#';
    lc_PROC_FUNCT_NAME          constant VARCHAR2(2000) := '#*PROC_FUNCT_NAME*#';
    lc_IN_PARAMETER_ASSIGN      constant VARCHAR2(2000) := '#*IN_PARAMETER_ASSIGN*#';

    lt_pattern_mappings ttb_t_templ_map_recs;


    lclob_function_template CLOB := to_clob(
      '   Create or replace function bn_') || to_clob(lc_PROC_FUNCT_NAME) || to_clob('_refc (         ') || to_clob(lc_IN_PARAMETER_DECLARATION) || to_clob('      ) return CLOB is

        lc_cursor        SYS_REFCURSOR;

        lv_columnValue   VARCHAR2 (2000);
        ln_status        INTEGER;

        lc_dbms_sql      number;
        ln_col_cnt       number;
        lv_separador     varchar2(100) := '';'';
        lt_desc_Tbl       DBMS_SQL.desc_tab;
        lclob_return      CLOB;

      begin

        ' ) || to_clob(lc_WRAPPED_PROC_FUNCT_NAME) || to_clob(' (        ') || to_clob(lc_IN_PARAMETER_ASSIGN) || to_clob('        );

        lclob_return := BN_UTILS_CSV.get_exp_dados (
                pref_cursor  => lc_cursor,   -- IN sys_refcursor,                pv_separador => lv_separador                );

        return lclob_return;

      end bn_') || to_clob(lc_PROC_FUNCT_NAME) || to_clob('_refc;
      '
    )
    ;
  begin

    lv_package_name := pv_package_name; -- 'PCK_RENTABILITY';
    lv_object_name  := pv_object_name; -- 'SP_GETPORTFOLIORESUME';

   ----------------------------
   -- Definir os mapeamentos --
   ---------------------------------------------------------------------------------------------------
    lt_pattern_mappings := ttb_t_templ_map_recs();

    lt_pattern_mappings.extend;
    lt_pattern_mappings(lt_pattern_mappings.count).pattern := lc_IN_PARAMETER_DECLARATION;
    Select replace(wm_concat(argument_name || ' IN ' || data_type ), ',', ',' || chr(10))
      into lt_pattern_mappings(lt_pattern_mappings.count).mapping
      from user_arguments
     where nvl(package_name, '"$%') = nvl(lv_package_name, '"$%') -- 'PCK_RENTABILITY'
       and object_name  = lv_object_name  -- 'SP_GETPORTFOLIORESUME'
       and in_out       = 'IN'
    ;


    lt_pattern_mappings.extend;
    Select count(1)
      into ln_is_a_function
      from user_arguments
     where nvl(package_name, '"$%') = nvl(lv_package_name, '"$%') -- 'PCK_RENTABILITY'
       and object_name   = lv_object_name  -- 'SP_GETPORTFOLIORESUME'
       and in_out        = 'OUT'
       and argument_name is null -- tem "argumento" de saida (trata-se de uma fun¿¿o)
    ;
    lt_pattern_mappings(lt_pattern_mappings.count).pattern := lc_WRAPPED_PROC_FUNCT_NAME;
    lt_pattern_mappings(lt_pattern_mappings.count).mapping := case when ln_is_a_function > 0
                                                                     then 'lc_cursor := '
                                                                   else ''
                                                               end
                                                              ||
                                                              case when lv_package_name is not null
                                                                     then lv_package_name || '.'
                                                                   else ''
                                                               end  || lv_object_name;

    lt_pattern_mappings.extend;
    lt_pattern_mappings(lt_pattern_mappings.count).pattern := lc_PROC_FUNCT_NAME;
    lt_pattern_mappings(lt_pattern_mappings.count).mapping := case when lv_package_name is not null
                                                                   then lv_package_name || '_'
                                                                   else ''
                                                               end  || lv_object_name;

    lt_pattern_mappings.extend;
    lt_pattern_mappings(lt_pattern_mappings.count).pattern := lc_IN_PARAMETER_ASSIGN;
    Select replace(
             wm_concat(case when in_out = 'IN'  and argument_name is not null
                              then argument_name || ' => ' || argument_name
                            when in_out = 'OUT' and argument_name is not null
                              then argument_name || ' => lc_cursor'
                            else ''
                        end
             ),
             ',',
             ',' || chr(10)
           )
      into lt_pattern_mappings(lt_pattern_mappings.count).mapping
      from user_arguments
     where nvl(package_name, '"$%') = nvl(lv_package_name, '"$%')-- 'PCK_RENTABILITY'
       and object_name  = lv_object_name  -- 'SP_GETPORTFOLIORESUME'
    ;


    -- Aplicar os mapeamentos --
    ------------------------------------------------------------------------------
    for i in 1..lt_pattern_mappings.count loop
      lclob_function_template := replace(
                                   lclob_function_template,
                                   to_clob(lt_pattern_mappings(i).pattern),
                                   to_clob(lt_pattern_mappings(i).mapping)
                                 );
    end loop;

    return lclob_function_template;

  end get_sys_ref_cursor_func;

  function who_called_me 
    return varchar2 
  is  
     owner_name    VARCHAR2 (100);
     caller_name   VARCHAR2 (100);
     line_number   NUMBER;
     caller_type   VARCHAR2 (100);
  BEGIN
     OWA_UTIL.WHO_CALLED_ME (owner_name,caller_name,line_number,caller_type);
     return caller_type
            || ' '
            || owner_name
            || '.'
            || caller_name
            || ' called MY_PROC from line number '
            || line_number
           ;
  END who_called_me;

  function get_hmtl_report_template (pv_template varchar2) 
    return clob 
  is
    lv_template VARCHAR2(500);
    lclob_res   CLOB;
  begin

    lv_template := upper(pv_template);

    lclob_res := case when lv_template = 'XSLT_TRANSFORM_BASICO' then to_clob('<?xml version="1.0" encoding="ISO-8859-1"?>
                                                                    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                                                                    <xsl:output method="html"/>
                                                                    <xsl:template match="/">
                                                                    <html>
                                                                      <body>

                                                                    <style type="text/css">
                                                                    .tftable {font-size:12px;color:#333333;width:100%;border-width: 1px;border-color: #ebab3a;border-collapse: collapse;}
                                                                    .tftable th {font-size:12px;background-color:#e6983b;border-width: 1px;padding: 8px;border-style: solid;border-color: #ebab3a;text-align:left;}
                                                                    .tftable tr {background-color:#f0c169;}
                                                                    .tftable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #ebab3a;}
                                                                    .tftable tr:hover {background-color:#ffffff;}
                                                                    </style>

                                                                       <table class="tftable" border="1">
                                                                         <tr bgcolor="cyan">

                                                                          <xsl:for-each select="/ROWSET/ROW[1]/*">
                                                                           <th><xsl:value-of select="name()"/></th>
                                                                          </xsl:for-each>

                                                                         </tr>

                                                                         <xsl:for-each select="/ROWSET/*">
                                                                          <tr>
                                                                           <xsl:for-each select="./*">
                                                                            <td><xsl:value-of select="text()"/> </td>
                                                                           </xsl:for-each>
                                                                          </tr>
                                                                         </xsl:for-each>


                                                                       </table>
                                                                       </body>
                                                                      </html>
                                                                      </xsl:template>
                                                                    </xsl:stylesheet>') 
 
                when lv_template = 'XSLT_TRANSFORM_TABLE_ONLY' then to_clob('<?xml version="1.0" encoding="ISO-8859-1"?>
                                                                    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                                                                    <xsl:output method="html"/>
                                                                    <xsl:template match="/">

                                                                       <table class="tftable" border="1">
                                                                         <tr bgcolor="cyan">

                                                                          <xsl:for-each select="/ROWSET/ROW[1]/*">
                                                                           <th><xsl:value-of select="name()"/></th>
                                                                          </xsl:for-each>

                                                                         </tr>

                                                                         <xsl:for-each select="/ROWSET/*">
                                                                          <tr>
                                                                           <xsl:for-each select="./*">
                                                                            <td><xsl:value-of select="text()"/> </td>
                                                                           </xsl:for-each>
                                                                          </tr>
                                                                         </xsl:for-each>


                                                                       </table>
                                                                      </xsl:template>
                                                                    </xsl:stylesheet>')

                when lv_template = 'OUTRO' then to_clob('<?xml version="1.0" encoding="ISO-8859-1"?>
                                                          <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                                                          <xsl:output method="html"/>
                                                          <xsl:template match="/">

                                                             <table id="example" class="display" cellspacing="0" width="100%">
                                                               <thead> 
                                                               <tr>
                                                                
                                                                <xsl:for-each select="/ROWSET/ROW[1]/*">
                                                                 <th><xsl:value-of select="name()"/></th>
                                                                </xsl:for-each>

                                                               </tr>
                                                               </thead>

                                                               <tfoot> 
                                                               <tr>
                                                                
                                                                <xsl:for-each select="/ROWSET/ROW[1]/*">
                                                                 <th><xsl:value-of select="name()"/></th>
                                                                </xsl:for-each>

                                                               </tr>
                                                               </tfoot>
                                                           
                                                               <tbody>

                                                               <xsl:for-each select="/ROWSET/*">
                                                                <tr>
                                                                 <xsl:for-each select="./*">
                                                                  <td><xsl:value-of select="text()"/> </td>
                                                                 </xsl:for-each>
                                                                </tr>
                                                               </xsl:for-each>

                                                               </tbody> 

                                                             </table>
                                                            </xsl:template>
                                                          </xsl:stylesheet>')

                when lv_template = 'XSLT_TRANSFORM_BASICO2' then to_clob(q'[<?xml version="1.0" encoding="ISO-8859-1"?>
                                                                    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                                                                    <xsl:output method="html"/>
                                                                    <xsl:template match="/">
                                                                    <html>
                                                                      <head>
                                                                        <link rel='stylesheet prefetch' href='https////cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.0/bootstrap-table.min.css'></link>
                                                                        <link rel='stylesheet prefetch' href='https://cdn.datatables.net/1.10.9/css/jquery.dataTables.min.css'></link>
                                                                        <link rel='stylesheet prefetch' href='https://cdn.datatables.net/colreorder/1.3.2/css/colReorder.dataTables.min.css'></link>
                                                                        <link href="jquery-ui.css" rel="stylesheet"></link>

                                                                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
                                                                        <script src='https://cdn.datatables.net/1.10.9/js/jquery.dataTables.min.js'></script>

                                                                        <script src="https://cdn.datatables.net/colreorder/1.3.2/js/dataTables.colReorder.min.js" ></script>

                                                                        <script>
                                                                              $(document).ready(function () {
                                                                            $('#example').DataTable({
                                                                                colReorder: true
                                                                              , bJQueryUI: true
                                                                              , iDisplayLength: 50
                                                                            });
                                                                        });
                                                                        </script>
                                                                      </head>

                                                                      <body>

                                                                       <table id="example" class="display" cellspacing="0" width="100%">
                                                                         <thead> 
                                                                         <tr>
                                                                          
                                                                          <xsl:for-each select="/ROWSET/ROW[1]/*">
                                                                           <th><xsl:value-of select="name()"/></th>
                                                                          </xsl:for-each>

                                                                         </tr>
                                                                         </thead>

                                                                         <tfoot> 
                                                                         <tr>
                                                                          
                                                                          <xsl:for-each select="/ROWSET/ROW[1]/*">
                                                                           <th><xsl:value-of select="name()"/></th>
                                                                          </xsl:for-each>

                                                                         </tr>
                                                                         </tfoot>
                                                                     
                                                                         <tbody>

                                                                         <xsl:for-each select="/ROWSET/*">
                                                                          <tr>
                                                                           <xsl:for-each select="./*">
                                                                            <td><xsl:value-of select="text()"/> </td>
                                                                           </xsl:for-each>
                                                                          </tr>
                                                                         </xsl:for-each>

                                                                         </tbody> 

                                                                       </table>

                                                                       </body>
                                                                      </html>
                                                                      </xsl:template>
                                                                    </xsl:stylesheet>]') 
    end; 

   return lclob_res;

  end get_hmtl_report_template;    

  FUNCTION get_html_report (p_query IN VARCHAR2, pv_template varchar2 default 'XSLT_TRANSFORM_BASICO2' ) 
    RETURN  CLOB 
  IS
  -- VER: http://www.codeproject.com/Articles/194916/Enhancing-HTML-tables-using-a-JQuery-DataTables-pl
  -- VER: https://datatables.net/download/release
    ctxh            dbms_xmlgen.ctxhandle;

    xslt_template XMLTYPE;

    lclob_template CLOB; 

    lclob_res   CLOB; 
  BEGIN

    ctxh:= dbms_xmlgen.newcontext(p_query);

    lclob_template := get_hmtl_report_template (pv_template => pv_template );

    xslt_template := XMLTYPE.createXML(lclob_template);
           
    dbms_xmlgen.setnullhandling(ctxh, dbms_xmlgen.empty_tag);
       
    dbms_xmlgen.setxslt(ctxh, xslt_template);
       
    lclob_res := dbms_xmlgen.getxml(ctxh);
       
    dbms_xmlgen.closecontext(ctxh);  
     
    RETURN lclob_res;

  exception 

    when others then
      dbms_xmlgen.closecontext(ctxh); 
      dbms_output.put_line('=> ' || sqlerrm || ' :: ' || dbms_utility.format_error_backtrace ); 
      raise;

  END get_html_report;


  function GET_WHO_AM_I 
    return varchar2 is 

    lv_res  varchar2(1000) := '';
    lv_curr varchar2(1000) := '';

    FUNCTION FN_WHO_AM_I__by_level ( p_lvl  NUMBER DEFAULT 0) RETURN VARCHAR2
    IS
    --
    -- VER: https://community.oracle.com/thread/1051771?start=0&tstart=0
    -- 
    /***********************************************************************************************
    FN_WHO_AM_I returns the full ORACLE name of your object including schema and package names
    --
    FN_WHO_AM_I(0) - returns the name of your object
    FN_WHO_AM_I(1) - returns the name of calling object
    FN_WHO_AM_I(2) - returns the name of object, who called calling object
    etc., etc., etc.... Up to to he highest level
    -------------------------------------------------------------------------------------------------
    Copyrigth GARBUYA 2010
    *************************************************************************************************/
    TYPE str_varr_t   IS VARRAY(2) OF CHAR(1);
    TYPE str_table_t  IS TABLE OF VARCHAR2(256);
    TYPE num_table_t  IS TABLE OF NUMBER;
    v_stack           VARCHAR2(2048) DEFAULT UPPER(dbms_utility.format_call_stack);
    v_tmp_1           VARCHAR2(1024);
    v_tmp_2           VARCHAR2(1024);
    v_pkg_name        VARCHAR2(32);
    v_obj_type        VARCHAR2(32);
    v_owner           VARCHAR2(32);
    v_idx             NUMBER := 0;
    v_pos1            NUMBER := 0;
    v_pos2            NUMBER := 0;
    v_line_nbr        NUMBER := 0;
    v_blk_cnt         NUMBER := 0;
    v_str_len         NUMBER := 0;
    v_bgn_cnt         NUMBER := 0;
    v_end_cnt         NUMBER := 0;
    it_is_comment     BOOLEAN := FALSE;
    it_is_literal     BOOLEAN := FALSE;
    v_literal_arr     str_varr_t := str_varr_t ('''', '"');
    v_blk_bgn_tbl     str_table_t := str_table_t (' IF '   , ' LOOP '   , ' CASE ', ' BEGIN ');
    v_tbl             str_table_t := str_table_t();
    v_blk_bgn_len_tbl num_table_t := num_table_t();


    BEGIN
       -- dbms_output.put_line('BN :: ' || v_stack  );    

       v_stack := SUBSTR(v_stack,INSTR(v_stack,CHR(10),INSTR(v_stack,upper($$plsql_unit)))+1)||'ORACLE'; -- skip myself

       FOR v_pos2 in 1 .. p_lvl LOOP  -- advance to the input level
          v_pos1 := INSTR(v_stack, CHR(10));
          v_stack := SUBSTR(v_stack, INSTR(v_stack, CHR(10)) + 1);
       END LOOP;

       v_pos1 := INSTR(v_stack, CHR(10));
       IF v_pos1 = 0 THEN
          RETURN (v_stack);
       END IF;

       v_stack := SUBSTR(v_stack, 1, v_pos1 - 1);  -- get only current level
       v_stack := TRIM(SUBSTR(v_stack, instr(v_stack, ' ')));  -- cut object handle
       v_line_nbr := TO_NUMBER(SUBSTR(v_stack, 1, instr(v_stack, ' ') - 1));  -- get line number

       v_stack := TRIM(SUBSTR(v_stack, instr(v_stack, ' ')));  -- cut line number
       v_pos1 := INSTR(v_stack, ' BODY');
       IF v_pos1  = 0 THEN
          RETURN (v_stack);
       END IF;

       v_pos1 := INSTR(v_stack, ' ', v_pos1 + 2);  -- find end of object type
       v_obj_type := SUBSTR(v_stack, 1, v_pos1 - 1);  -- get object type
       v_stack := TRIM(SUBSTR(v_stack, v_pos1 + 1));  -- get package name
       v_pos1 := INSTR(v_stack, '.');
       v_owner := SUBSTR(v_stack, 1, v_pos1 - 1);  -- get owner
       v_pkg_name  := SUBSTR(v_stack, v_pos1 + 1);  -- get package name
       v_blk_cnt := 0;
       it_is_literal := FALSE;
       --
       FOR v_idx in v_blk_bgn_tbl.FIRST .. v_blk_bgn_tbl.LAST
       LOOP
          v_blk_bgn_len_tbl.EXTEND(1);
          v_blk_bgn_len_tbl (v_blk_bgn_len_tbl.last) := LENGTH(v_blk_bgn_tbl(v_idx));
       END LOOP;
       --
       FOR src
       IN ( SELECT ' '||REPLACE(TRANSLATE(UPPER(text), ';('||CHR(10), '   '),'''''',' ') ||' ' text
            FROM all_source
            where owner = v_owner
            and name    = v_pkg_name
            and type    = v_obj_type
            and line    < v_line_nbr
            ORDER  BY line
          )
       LOOP
          v_stack := src.text;
          IF it_is_comment THEN
             v_pos1 :=  INSTR (v_stack, '*/');
             IF v_pos1 > 0 THEN
                v_stack := SUBSTR (v_stack, v_pos1 + 2);
                it_is_comment := FALSE;
             ELSE
                v_stack := ' ';
             END IF;
          END IF;
          --
          IF v_stack != ' ' THEN
          --
             v_pos1 := INSTR (v_stack, '/*');
             WHILE v_pos1 > 0 LOOP
                v_tmp_1 := SUBSTR (v_stack, 1, v_pos1 - 1);
                v_pos2 := INSTR (v_stack, '*/');
                IF v_pos2 > 0 THEN
                   v_tmp_2 := SUBSTR (v_stack, v_pos2 + 2);
                   v_stack := v_tmp_1||v_tmp_2;
                ELSE
                   v_stack := v_tmp_1;
                   it_is_comment := TRUE;
                END IF;
                v_pos1 := INSTR (v_stack, '/*');
             END LOOP;
             --
             IF v_stack != ' ' THEN
                v_pos1 := INSTR (v_stack, '--');
                IF v_pos1 > 0 THEN
                   v_stack := SUBSTR (v_stack, 1, v_pos1 - 1);
                END IF;
                --
                IF v_stack != ' ' THEN
                   FOR v_idx in v_literal_arr.FIRST .. v_literal_arr.LAST
                   LOOP
                      v_pos1 := INSTR (v_stack, v_literal_arr (v_idx) );
                      WHILE v_pos1 > 0  LOOP
                         v_pos2 := INSTR (v_stack, v_literal_arr (v_idx), v_pos1 + 1);
                         IF v_pos2 > 0 THEN
                            v_tmp_1 := SUBSTR (v_stack, 1, v_pos1 - 1);
                            v_tmp_2 := SUBSTR (v_stack, v_pos2 + 1);
                            v_stack := v_tmp_1||v_tmp_2;
                         ELSE
                            IF it_is_literal THEN
                               v_stack := SUBSTR (v_stack, v_pos1 + 1);
                               it_is_literal := FALSE;
                            ELSE
                               v_stack := SUBSTR (v_stack, 1, v_pos1 - 1);
                               it_is_literal := TRUE;
                            END IF;
                         END IF;
                         v_pos1 := INSTR (v_stack, v_literal_arr (v_idx) );
                      END LOOP;
                   END LOOP;
                   --
                   IF v_stack != ' ' THEN
                      WHILE INSTR (v_stack, '  ') > 0
                      LOOP
                         v_stack := REPLACE(v_stack, '  ', ' ');
                      END LOOP;
                      v_stack := REPLACE(v_stack, ' END IF ', ' END ');
                      v_stack := REPLACE(v_stack, ' END LOOP ', ' END ');
                      --
                      IF v_stack != ' ' THEN
                         v_stack := ' '||v_stack;
                         v_pos1 := INSTR(v_stack, ' FUNCTION ') + INSTR(v_stack, ' PROCEDURE ');
                         IF v_pos1 > 0 THEN
                            v_obj_type := TRIM(SUBSTR(v_stack, v_pos1 + 1, 9));  -- get object type
                            v_stack := TRIM(SUBSTR(v_stack, v_pos1 + 10))||'  ';  -- cut object type
                            v_stack := SUBSTR(v_stack, 1,  INSTR(v_stack, ' ') - 1 );  -- get object name
                            v_tbl.EXTEND(1);
                            v_tbl (v_tbl.last) := v_obj_type||' '||v_owner||'.'||v_pkg_name||'.'||v_stack;
                         END IF;
                      --
                         v_pos1 := 0;
                         v_pos2 := 0;
                         v_tmp_1 := v_stack;
                         v_tmp_2 := v_stack;
                         FOR v_idx in v_blk_bgn_tbl.FIRST .. v_blk_bgn_tbl.LAST
                         LOOP
                            v_str_len := NVL(LENGTH(v_tmp_1),0);
                            v_tmp_1 := REPLACE(v_tmp_1,v_blk_bgn_tbl(v_idx), NULL);
                            v_bgn_cnt := NVL(LENGTH(v_tmp_1), 0);
                            v_pos1 := v_pos1 + (v_str_len - v_bgn_cnt)/v_blk_bgn_len_tbl(v_idx);
                            v_str_len := NVL(LENGTH(v_tmp_2),0);
                            v_tmp_2 := REPLACE(v_tmp_2,' END ', NULL);
                            v_end_cnt := NVL(LENGTH(v_tmp_2), 0);
                            v_pos2 := v_pos2 + (v_str_len - v_end_cnt)/5; --- 5 is the length(' END ') 
                         END LOOP;
                         IF v_pos1 > v_pos2 THEN
                            v_blk_cnt := v_blk_cnt + 1;
                         ELSIF v_pos1 < v_pos2 THEN
                            v_blk_cnt := v_blk_cnt - 1;
                            IF v_blk_cnt = 0 AND v_tbl.COUNT > 0 THEN
                               v_tbl.DELETE(v_tbl.last);
                            END IF;
                         END IF;
                      END IF;
                   END IF;
                END IF;
             END IF;
          END IF;
       END LOOP;

       RETURN CASE v_tbl.COUNT WHEN 0 THEN 'UNKNOWN' ELSE v_tbl(v_tbl.LAST) END;

    END FN_WHO_AM_I__by_level;  

  begin 

    for i in 1..20 loop

       lv_curr := FN_WHO_AM_I__by_level(i);

       if lv_curr <> 'ANONYMOUS BLOCK' and lv_curr <> 'ORACLE' then

         lv_res := regexp_replace(lv_curr, '(.*)(\.)(.*)$', '\3')
                   || '.' || lv_res 
                   ;              

       end if;

    end loop;
    
    return substr(lv_res, 1, length(lv_res) - 1);
    
  end GET_WHO_AM_I;


  -- Inicializacao do package --
  ------------------------------------------------------------------------------
  begin

    t_varchar2_4000_array_add_rec (pt_varchar2_4000_array => gtt_sandbox_patterns, pv_line => '[SPEC_FIM]');
    t_varchar2_4000_array_add_rec (pt_varchar2_4000_array => gtt_sandbox_patterns, pv_line => '[BODY_FIM]');


end BN_PLSQL_SCRIPT;
/


-- End of DDL Script for Package OWNER_V1.bn_plsql_script

