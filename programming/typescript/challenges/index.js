"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Or import the entire module
var Challenges = require("@lehungio/typescript");
var helloAll = Challenges.greet('All'); // Output: "Hello, World!"
+console.log('Greeting result:', helloAll);
/**
* Challenge 1: Hello, World!
* Demonstrates different ways to use the greet functionality
*/
var typescript_1 = require("@lehungio/typescript");
var greetMessage = (0, typescript_1.greet)('Typescript'); // Output: "Hello, World!"
console.log(greetMessage);
var helloWorld = new Challenges.HelloWorld();
helloWorld.greet(); // Output: "Hello, World!"
/**
* Challenge 25: Word Count
* Demonstrates the word counting functionality
*/
var typescript_2 = require("@lehungio/typescript");
var count = (0, typescript_2.wordCount)('Hello, World!'); // Output: 2
console.log('Word count result:', count);
