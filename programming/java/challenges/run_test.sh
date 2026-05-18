#!/bin/bash

# Define directories
SRC_DIR="src"
BIN_DIR="bin"
LIB_DIR="lib"

# Ensure the bin directory exists
mkdir -p "$BIN_DIR"

# Step 1: Compile Java files
echo "Compiling Java files..."
javac -d "$BIN_DIR" -cp "$LIB_DIR/*" "$SRC_DIR"/HelloWorld/HelloWorld.java "$SRC_DIR"/HelloWorld/HelloWorldTest.java
if [ $? -ne 0 ]; then
  echo "Compilation failed!"
  exit 1
fi
echo "Compilation successful!"

# Step 2: Run JUnit tests
echo "Running tests..."
java -cp "$BIN_DIR:$LIB_DIR/*" org.junit.platform.console.ConsoleLauncher --select-class HelloWorld.HelloWorldTest
if [ $? -ne 0 ]; then
  echo "Tests failed!"
  exit 1
fi
echo "Tests passed!"

# Optional: Clean up
# echo "Cleaning up..."
# rm -rf "$BIN_DIR"