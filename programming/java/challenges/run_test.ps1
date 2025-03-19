# Define directories
$SRC_DIR = "src"
$BIN_DIR = "bin"
$LIB_DIR = "lib"

# Ensure the bin directory exists
if (!(Test-Path $BIN_DIR)) {
    New-Item -ItemType Directory -Path $BIN_DIR
}

# Step 1: Compile Java files
Write-Host "Compiling Java files..."
javac -d $BIN_DIR -cp "$LIB_DIR\*" "$SRC_DIR\HelloWorld\HelloWorld.java" "$SRC_DIR\HelloWorld\HelloWorldTest.java"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Compilation failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}
Write-Host "Compilation successful!" -ForegroundColor Green

# Step 2: Run JUnit tests
Write-Host "Running tests..."
java -cp "$BIN_DIR;$LIB_DIR\*" org.junit.platform.console.ConsoleLauncher --select-class HelloWorld.HelloWorldTest
if ($LASTEXITCODE -ne 0) {
    Write-Host "Tests failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}
Write-Host "Tests passed!" -ForegroundColor Green

# Optional: Clean up
# Write-Host "Cleaning up..."
# Remove-Item -Recurse -Force $BIN_DIR