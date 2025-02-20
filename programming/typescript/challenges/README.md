# Init

1. Open your terminal and run the following command to install TypeScript globally:
```
npm install -g typescript
```

2. Verify the installation by checking the TypeScript version:    
```bash
  tsc --version
```

If the command is still not found, you may need to ensure that npm's global bin directory is in your PATH. You can add it to your PATH by adding the following line to your `~/.zshrc` file:


```sh
export PATH="$PATH:$(npm bin -g)"
```

source ~/.zshrc

# Run
1. Compile the TypeScript file to JavaScript: Open the terminal and navigate to the directory containing your index.ts file. Then run the TypeScript compiler (tsc):
```
tsc index.ts
```

2. Run the compiled JavaScript file: Use Node.js to execute the compiled JavaScript file:
```
node index.js
```



