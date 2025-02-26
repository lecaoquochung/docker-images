import * as Challenges from '@lehungio/typescript';

const helloAll = Challenges.greet('All'); // Output: "Hello, World!"
console.log('Greeting result:', helloAll);

/**
 * Challenge 1: Hello, World!
 * Demonstrates different ways to use the greet functionality
 */
const greetMessage = Challenges.greet('Typescript'); // Output: "Hello, World!"
console.log(greetMessage);

try {
  const helloWorld = new Challenges.HelloWorld();
  helloWorld.greet(); // Output: "Hello, World!"
} catch (error) {
  console.error('Failed to create or use HelloWorld instance:', error);
}

/**
 * Challenge 25: Word Count
 * Demonstrates the word counting functionality
 */
const count = Challenges.wordCount('Hello, World!'); // Output: 2
console.log('Word count result:', count);

/**
 * Challenge 26: Difference of Squares
 * Demonstrates the difference of squares functionality
 */
const squares = new Challenges.Squares(5);
console.log('Square of sum:', squares.squareOfSum);
console.log('Sum of squares:', squares.sumOfSquares);
console.log('Difference:', squares.difference);

/**
 * Challenge 27: Gigasecond
 * Demonstrates the gigasecond functionality
*/ 
const gigasecond = new Challenges.Gigasecond(new Date('2013-01-07'));
console.log('Gigasecond date from 2013-01-07:', gigasecond.date());
const target = new Date('2025-02-28');
const seconds = Challenges.Gigasecond.secondsToDate(target);
const days = Challenges.Gigasecond.secondsToDays(seconds); // Returns number of days from now until Dec 31, 2024
console.log('Days from now until Feb 28, 2025:', days);

const start = new Date('2013-01-07');
const gs = new Challenges.Gigasecond(start);
const target2 = new Date('2025-02-28');
const seconds2 = gs.secondsBetweenDates(target2); // Returns seconds between Jan 1 and Feb 1
console.log('Seconds between 2013-01-07 and 2025-02-28:', seconds2);
console.log('Days between 2013-01-07 and 2025-02-28:', Challenges.Gigasecond.secondsToDays(seconds2));

/**
 * Challenge 28: Reverse String
 * Demonstrates the reverse string functionality
 */
const reverseStringInput = 'hello';
console.log(`Challenge 28 - Reverse String: reverse('${reverseStringInput}') => ${Challenges.reverse(reverseStringInput)}`);

/**
 * Challenge 29: Triangle
 * Demonstrates the triangle functionality
 */
console.log('Challenge 29 - Triangle Check');
const triangle = new Challenges.Triangle(3, 4, 5);
console.log(`Challenge 29 - Triangle: triangle.isEquilateral => ${triangle.isEquilateral}`);
console.log(`Challenge 29 - Triangle: triangle.isIsosceles => ${triangle.isIsosceles}`);
console.log(`Challenge 29 - Triangle: triangle.isScalene => ${triangle.isScalene}`);

/**
 * Challenge 30: Collatz Conjecture
 * Demonstrates the collatz conjecture functionality
 */
console.log('Challenge 30 - Collatz Conjecture');
const collatzConjectureInput = 16;
console.log(`Challenge 30 - Collatz Conjecture: steps(${collatzConjectureInput}) => ${Challenges.steps(collatzConjectureInput)}`); 
const collatzConjectureInput2 = 12;
console.log(`Challenge 30 - Collatz Conjecture: steps(${collatzConjectureInput2}) => ${Challenges.steps(collatzConjectureInput2)}`); 
const collatzConjectureInput3 = 1000000;
console.log(`Challenge 30 - Collatz Conjecture: steps(${collatzConjectureInput3}) => ${Challenges.steps(collatzConjectureInput3)}`); 
const collatzConjectureInput4 = 2025;
console.log(`Challenge 30 - Collatz Conjecture: steps(${collatzConjectureInput4}) => ${Challenges.steps(collatzConjectureInput4)}`); 