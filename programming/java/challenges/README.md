# Get Started
Step:
- javac compiles the code with the JUnit library included in the classpath.
- java -jar launches the JUnit platform console to execute the test.
- JUnit will pick up and execute the test methods annotated with @Test.

## Compile the Code
```
javac -d bin -cp ".;lib/*" src/HelloWorld/HelloWorld.java src/HelloWorld/HelloWorldTest.java
javac -d bin -cp ".;lib/*" src/SortNumber/SortNumber.java src/SortNumber/SortNumberTest.java

```

## Run the Test
```
# prefered simple
java -cp "bin;lib/*;lib/junit-platform-console-standalone-1.10.2.jar" org.junit.platform.console.ConsoleLauncher --select-class HelloWorld.HelloWorldTest
java -cp "bin;lib/*;lib/junit-platform-console-standalone-1.10.2.jar" org.junit.platform.console.ConsoleLauncher --select-class SortNumber.HelloWorldTest

# or clear libs path 
java -jar lib/junit-platform-console-standalone-1.10.2.jar --class-path "bin;lib/junit-jupiter-api-5.10.2.jar;lib/junit-jupiter-engine-5.10.2.jar;lib/apiguardian-api-1.1.2.jar" --select-class HelloWorld.HelloWorldTest
```

# Reference
- https://junit.org/junit5/docs/current/user-guide/