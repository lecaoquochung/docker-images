import * as Challenges from '@lehungio/typescript';

const helloAll = Challenges.greet('All'); // Output: "Hello, World!"
console.log('Greeting result:', helloAll);

/**
 * Challenge 1: Hello, World!
 * Demonstrates different ways to use the greet functionality
 */
const greetMessage = Challenges.greet('Typescript'); // Output: "Hello, World!"
console.log(greetMessage);

const helloWorld = new Challenges.HelloWorld();
helloWorld.greet(); // Output: "Hello, World!"

/**
 * Challenge 25: Word Count
 * Demonstrates the word counting functionality
 */
const count = Challenges.wordCount('Hello, World!'); // Output: 2
console.log('Word count result:', count);