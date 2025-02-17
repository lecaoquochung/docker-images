import * as Challenges from '@lehungio/typescript';
import { greet, wordCount } from '@lehungio/typescript';

describe('Challenges Module', () => {
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
});