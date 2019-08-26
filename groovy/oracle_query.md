## Para fazer uma simples ligação à BD e retornar dados
  
```groovy
package bn

import groovy.sql.Sql
 
db = Sql.newInstance(
            'jdbc:oracle:thin:@<__ipaddress__>:<__port__>:<__SID__>',
            'user', 'pass', 'oracle.jdbc.driver.OracleDriver')
 
      def sql = """
		Select * from dual 		

        """
        list = db.rows(sql)

		println list[0][0]    
		
println "END"
```
