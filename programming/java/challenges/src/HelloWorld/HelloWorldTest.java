package HelloWorld;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class HelloWorldTest {

    @Test
    void testSayHello() {
        HelloWorld hw = new HelloWorld();
        assertEquals("Hello, World!", hw.sayHello());
    }
}