// Or import the entire module
import * as Challenges from '@lehungio/typescript';
let helloAll = Challenges.greet('All'); // Output: "Hello, World!"
console.log(helloAll);

//Challenge 1: Hello, World!
import { greet } from '@lehungio/typescript';
let greetMessage = greet('Typescript'); // Output: "Hello, World!"
console.log(greetMessage);
const helloWorld = new Challenges.HelloWorld();
helloWorld.greet(); // Output: "Hello, World!"

//Challenge 25: Word Count
import { wordCount } from '@lehungio/typescript';
const count = wordCount('Hello, World!'); // Output: 2
console.log(count);