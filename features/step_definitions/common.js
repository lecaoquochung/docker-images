const { Given, Then } = require('@cucumber/cucumber');
const path = require('path'); // Add this line to import the path module
const fs = require('fs'); // Add this line to import the fs module

Given('Pending', function () {
  // Write code here that turns the phrase above into concrete actions
  return 'pending';
});

Then('Verify screenshot {string}', { timeout: 30000 }, async function (namespace) {
  // selenium
  try {
      const screenshot = await this.seleniumDriver.takeScreenshot();
      const screenshotPath = path.resolve(process.cwd(), 'coverage/' + namespace + '.png');
      fs.writeFileSync(screenshotPath, screenshot, 'base64');
      console.log(`Screenshot saved at ${screenshotPath}`);
  } catch (error) {
      console.log('Error taking screenshot:', error);
  }
});