/**  
 * A simple Scala application that demonstrates basic syntax and structure.  
 */  
object HelloWorld {
  /**  
   * The main method serves as the entry point for the application.  
   * It prints a greeting to the console.  
   */  
  def main(args: Array[String]): Unit = {
    println(hello())
  }

  /**  
   * Returns a greeting string.  
   * @return A "Hello, World!" greeting  
   */ 
  def hello(): String = "Hello, World!"
}