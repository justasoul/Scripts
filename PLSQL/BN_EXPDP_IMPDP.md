

# EXPDP + IMPDP

* Será necessário ter acesso a um objecto directory a nível do schema que estamos a utilizar para fazer o EXPDP ou IMPDP
* O directório no filesystem deverá ter permissoes "g+s" para que os ficheiros criados não ficam associados ao user "oracle" permitindo assim a sua posterior cópia
  * Se nos tivermos esquecido disto, é sempre possível fazer o delete do ficheiro apartir do SQLNavigator (por exemplo) utilizando:
	```sql
	  begin 
	    utl_file.FREMOVE(location=> 'BPIONLINE_EXPIMP_DIR', filename=> 'schema_DDL_DEV_v2.dmp');
	  end;	
	```

  * Notas de objectos de BD a utilizar para acompanhar um IMPDP/EXPDP que esteja a correr:	
	```
		Select * from dba_datapump_jobs
		-- JOB_NAME: SYS_EXPORT_SCHEMA_04
		;

		Select * from dba_datapump_sessions
		;

		Select * from schema.SYS_EXPORT_SCHEMA_04
		;
	```

## Exemplos de EXPDP

### DDL apenas:
```bash
   #!/usr/bin/ksh
   ORAENV_ASK=NO
   . oraenv > ~/OutputORAEnvResult.log
   export NLS_LANG=AMERICAN_AMERICA.WE8MSWIN1252

   expdp user/password@ONLD                  \
   	     DIRECTORY=BPIONLINE_EXPIMP_DIR   \
   	     DUMPFILE=schema_DDL_DEV_v2.dmp    \
   	     LOGFILE=expschema_DDL_DEV_v2.log  \
   	     REUSE_DUMPFILES=Y                \
   	     CONTENT=metadata_only\
   	     FULL=n

```

### Dados (tabelas) apenas:
```bash
	#!/usr/bin/ksh

	ORAENV_ASK=NO
	. oraenv > ~/OutputORAEnvResult.log
	export NLS_LANG=AMERICAN_AMERICA.WE8MSWIN1252

	TABLES="schema.dual,schema.dual"

	expdp user/password@ONLD                 \
		  DIRECTORY=BPIONLINE_EXPIMP_DIR      \
		  DUMPFILE=schema_DATA_DEV_v2.dmp    \
		  LOGFILE=expschema_DATA_DEV_v2.log  \
		  REUSE_DUMPFILES=Y                   \
		  CONTENT=DATA_ONLY                   \
		  FULL=n                              \
		  COMPRESSION=all  \
		  tables=${TABLES} 
```  

## Exemplos IMPDP:

### DDL apenas:
  
Para além disto é sempre possível limitar a importação a apenas alguns tipos de objectos utilizando adicionando o argumento ** include="SEQUENCE" **
  
```bash

ORAENV_ASK=NO
. oraenv > ~/OutputORAEnvResult.log
export NLS_LANG=AMERICAN_AMERICA.WE8MSWIN1252

impdp user_orig/pass@ONLD                 \
      DIRECTORY=BPIONLINE_EXPIMP_DIR       \
      DUMPFILE=schema_DATA_DEV_v2.dmp    \
      LOGFILE=impschema_DATA_DEV_v2.log  \
      CONTENT=metadata_only                \
	  remap_schema=user_orig:user_fim   

```

### Dados apenas:
```bash
ORAENV_ASK=NO
. oraenv > ~/OutputORAEnvResult.log
export NLS_LANG=AMERICAN_AMERICA.WE8MSWIN1252

TABLES="schema.TABELA1,schema.TABELA2"


impdp bpitrader/bpion@ONLD                 \
      DIRECTORY=BPIONLINE_EXPIMP_DIR       \
      DUMPFILE=schema_DATA_DEV_v2.dmp    \
      LOGFILE=impschema_DATA_DEV_v2.log  \
	  TABLE_EXISTS_ACTION=TRUNCATE         \
	  CONTENT=data_only                    \
	  TRANSFORM=OID:n                      \
	  remap_schema=schema:bpitrader      \
	  tables=${TABLES}
``` 






