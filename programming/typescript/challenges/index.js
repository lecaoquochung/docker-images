"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Challenges = require("@lehungio/typescript");
var helloAll = Challenges.greet('All'); // Output: "Hello, World!"
console.log('Greeting result:', helloAll);
/**
 * Challenge 1: Hello, World!
 * Demonstrates different ways to use the greet functionality
 */
var greetMessage = Challenges.greet('Typescript'); // Output: "Hello, World!"
console.log(greetMessage);
try {
    var helloWorld = new Challenges.HelloWorld();
    helloWorld.greet(); // Output: "Hello, World!"
}
catch (error) {
    console.error('Failed to create or use HelloWorld instance:', error);
}
/**
 * Challenge 25: Word Count
 * Demonstrates the word counting functionality
 */
var count = Challenges.wordCount('Hello, World!'); // Output: 2
console.log('Word count result:', count);
/**
 * Challenge 26: Difference of Squares
 * Demonstrates the difference of squares functionality
 */
var squares = new Challenges.Squares(5);
console.log('Square of sum:', squares.squareOfSum);
console.log('Sum of squares:', squares.sumOfSquares);
console.log('Difference:', squares.difference);
/**
 * Challenge 27: Gigasecond
 * Demonstrates the gigasecond functionality
*/
var gigasecond = new Challenges.Gigasecond(new Date('2013-01-07'));
var target = new Date('2025-02-28');
var seconds = Challenges.Gigasecond.secondsToDate(target);
var days = Challenges.Gigasecond.secondsToDays(seconds); // Returns number of days from now until Dec 31, 2024
console.log('Days from now until Feb 28, 2025:', days);
var start = new Date('2013-01-07');
var gs = new Challenges.Gigasecond(start);
var target2 = new Date('2025-02-28');
var seconds2 = gs.secondsBetweenDates(target2); // Returns seconds between Jan 1 and Feb 1
console.log('Seconds between 2013-01-07 and 2025-02-28:', seconds2);
console.log('Days between 2013-01-07 and 2025-02-28:', Challenges.Gigasecond.secondsToDays(seconds2));
