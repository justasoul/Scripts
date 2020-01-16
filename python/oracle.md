# Ligação a Oracle
  
## Simples ligação a uma bd
  
````python
import cx_Oracle

def get_oracle_connection():
    # make connection to the database
    dsn = cx_Oracle.makedsn("localhost", "1521", "XE")
    con = cx_Oracle.connect(user="BN", password="BN", dsn=dsn)
    return con


def query_example():
    try:
        con = get_oracle_connection()
        cur = con.cursor()
        cur.execute('''select * 
                         from BN_BLA    
                    ''')

        for row in cur:
            print (row[0])

    except Exception as e:
        print (e)
    finally:
        cur.close()
        con.close()
````
 
