"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Or import the entire module
var Challenges = require("@lehungio/typescript");
var helloAll = Challenges.greet('All'); // Output: "Hello, World!"
console.log(helloAll);
var typescript_1 = require("@lehungio/typescript");
var greetMessage = (0, typescript_1.greet)('Typescript'); // Output: "Hello, World!"
console.log(greetMessage);
var helloWorld = new Challenges.HelloWorld();
helloWorld.greet(); // Output: "Hello, World!"
