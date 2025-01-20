const { Given, When, Then, AfterAll } = require('@cucumber/cucumber');
const { Browser, Builder, By, Capabilities, Key, until } = require('selenium-webdriver');
const Chrome = require('selenium-webdriver/chrome');
const { suite } = require('selenium-webdriver/testing');
const { expect } = require('chai');
require("chromedriver");

const fs = require('fs');
const path = require('path');

// TODO EvidenceComponent.js
async function takeScreenshot(driver, fileName) {
    try {
        const screenshot = await driver.takeScreenshot();
        const screenshotPath = path.resolve(process.cwd(), `coverage/${fileName}`);
        fs.writeFileSync(screenshotPath, screenshot, 'base64');
        console.log(`Screenshot saved at ${screenshotPath}`);
    } catch (error) {
        console.log('Error taking screenshot:', error);
    }
}

// driver setup
// const capabilities = Capabilities.chrome();
// capabilities.set('chromeOptions', { "w3c": false, args: ["--headless"] }); // Enable headless mode
// const driver = new Builder().withCapabilities(capabilities).build();

// selenium new headless mode
// https://www.selenium.dev/blog/2023/headless-is-going-away/
// https://www.selenium.dev/documentation/webdriver/browsers/chrome/
// let driver = await env
//     .builder()
//     .setChromeOptions(options.addArguments('--headless=new'))
//     .build();
let options = new Chrome.Options();
// options.addArguments('headless'); // Run Chrome in headless mode
options.addArguments('--headless=new'); // Run Chrome in new headless mode
// options.addArguments('disable-gpu'); // Disable GPU rendering (for headless mode)
// options.addArguments('no-sandbox'); // Required in some environments like Docker
// options.addArguments('disable-dev-shm-usage'); // Avoid memory issues in Docker
// options.addArguments('disable-extensions'); // Disable extensions
// options.addArguments('start-maximized'); // Start maximized for consistent dimensions
// options.addArguments('--enable-logging', '--v=1');

// const driver = new Builder()
//     .forBrowser('chrome')
//     .setChromeOptions(options)
//     .build();

Given('I am on the Google search page', { timeout: 30000 }, async function () {
    try {
        // await driver.manage().setTimeouts({ implicit: 3000 });
        // await driver.get('https://www.google.com');
        await this.seleniumDriver.manage().setTimeouts({ implicit: 3000 });
        await this.seleniumDriver.get('https://www.google.com');
    } catch (error) {
        console.log(error);
    }
});

// https://www.selenium.dev/selenium/docs/api/javascript/index.html
When('I search for {string}', { timeout: 30000 }, async function (searchTerm) {
    // Wait for the textarea element to be visible (explicit wait)
    const element = await this.seleniumDriver.wait(
        until.elementLocated(By.css('textarea')), // Wait until the element is located
        10000 // Wait up to 10 seconds
    );
    // Type into the textarea and submit the form
    await element.sendKeys(searchTerm);
    await element.submit();

    // Wait for the page to fully load by checking the document's ready state
    await this.seleniumDriver.wait(async () => {
    const readyState = await this.seleniumDriver.executeScript('return document.readyState');
    return readyState === 'complete';
    }, 15000); // Wait up to 15 seconds for the page to load

    // Optionally wait for a specific element on the results page
    try {
        await this.seleniumDriver.wait(until.elementLocated(By.id('main')), 10000);
    } catch (error) {
        console.log('Element with ID "main" not found:', error);
        await takeScreenshot(this.seleniumDriver, 'error_title_check.png');
    }
});

Then('the page title should start with {string}', {timeout: 60 * 1000}, async function (searchTerm) {
    const title = await this.seleniumDriver.getTitle();
    const isTitleStartWithCheese = title.toLowerCase().lastIndexOf(`${searchTerm}`, 0) === 0;
    console.log('Title should include search term: ' + searchTerm);
    console.log('Title: ' + title)
    expect(isTitleStartWithCheese).to.equal(true);
});