
package demo

class DisplayProvider {

    // assert contacts.isEmpty()
    String stuff () {
      def myList = ["Bruno","Miguel", "Nunes"]
      String concat_output   
      
      concat_output  = ""
      myList.each { element -> 
          concat_output = concat_output + " " + element
        println element
      }
      
      return concat_output     
    }
    
    
    def text = "Hello from Groovy!" + stuff() 

    
    
}

