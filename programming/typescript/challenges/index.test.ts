import * as Challenges from '@lehungio/typescript';
import { greet, wordCount } from '@lehungio/typescript';

describe('Challenges output', () => {
  test('greet function should return correct greeting', () => {
    const helloAll = Challenges.greet('All');
    expect(helloAll).toBe('Hello, All!');

    const greetMessage = greet('Typescript');
    expect(greetMessage).toBe('Hello, Typescript!');
  });

  test('HelloWorld class should greet correctly', () => {
    const helloWorld = new Challenges.HelloWorld();
    const spy = jest.spyOn(console, 'log');
    helloWorld.greet();
    expect(spy).toHaveBeenCalledWith('Hello, World!');
    spy.mockRestore();
  });

  test('wordCount function should return correct word count', () => {
    const count = wordCount('Hello, World!');
    const expectedCount = new Map([['hello', 1], ['world', 1]]);
    expect(count).toEqual(expectedCount);
  });

  test('differenceOfSquares function should return correct difference of squares', () => {
    const squares = new Challenges.Squares(5);
    expect(squares.squareOfSum).toBe(225);
    expect(squares.sumOfSquares).toBe(55);
    expect(squares.difference).toBe(170);
  });

});

describe('Challenge #27 - Gigasecond output test', () => {
  test('Gigasecond function should return correct gigasecond date', () => {
    const gigasecond = new Challenges.Gigasecond(new Date('2013-01-07'));
    expect(gigasecond.date().toISOString()).toBe("2044-09-15T01:46:40.000Z");
  });
});

describe('Challenge #28 - Reverse String output test', () => {
  test('reverse function should return correct reversed string', () => {
    const reversed = Challenges.reverse('hello');
    expect(reversed).toBe('olleh');
  });

  test('reverse function should return correct reversed string', () => {
    const reversed = Challenges.reverse('aloha');
    expect(reversed).toBe('ahola');
  });
});
