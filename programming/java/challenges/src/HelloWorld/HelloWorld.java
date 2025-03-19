package HelloWorld;

public class HelloWorld {
  public String sayHello() {
    return "Hello, World!";
  }

  public static void main(String[] args) {
    HelloWorld hw = new HelloWorld();
    System.out.println(hw.sayHello());
  }
}
