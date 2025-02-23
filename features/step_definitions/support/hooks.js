const { BeforeAll, Before, Given, When, Then, After, AfterAll } = require('@cucumber/cucumber');
const { Builder, By, Capabilities, Key, until } = require('selenium-webdriver');
const ChromeSeleniumWebdriver = require('selenium-webdriver/chrome');
var {setDefaultTimeout} = require('@cucumber/cucumber');

// lib
const fs = require('fs');
const path = require('path');
const moment = require('moment');
const puppeteer = require('puppeteer');
const os = require('os');
const { chromium, firefox, webkit, devices } = require('playwright');
const { expect } = require('chai');
require("chromedriver");

// component
const rootDir = path.resolve(__dirname, '../../..');
const constant = require(path.join(rootDir, 'constant.js'));
const {installMouseHelper} = require(path.join(rootDir, 'src/puppeteer/component/install-mouse-helper.js'));
const EvidenceComponent = require(path.join(rootDir, 'src/component/EvidenceComponent.js'));
const evidenceAction = new EvidenceComponent();

// Read the package.json file
const pathToJson = './package.json';
const packageJson = JSON.parse(fs.readFileSync(pathToJson, 'utf-8'));

// timeout
const currentUnixTime = moment().valueOf();
const date = moment(currentUnixTime).format('YYYYMMDD');
setDefaultTimeout(constant.stepTimeout);

// TODO component
function getFormattedDate() {
  const date = new Date();
  const YYYY = date.getFullYear();
  const MM = String(date.getMonth() + 1).padStart(2, '0');
  const DD = String(date.getDate()).padStart(2, '0');
  const HH = String(date.getHours()).padStart(2, '0');
  const mm = String(date.getMinutes()).padStart(2, '0');
  const ss = String(date.getSeconds()).padStart(2, '0');
  return `${YYYY}${MM}${DD}_${HH}${mm}${ss}`;
}

BeforeAll(async function() {
  // Write code here that turns the phrase above into concrete actions
  // return 'pending';
  // Output Test Information
  // TOOL: puppeteer, playwright, robotframework, selenium etc
  // BROWSERS: chrome, firefox, safari, etc
  const operatingSystem = os.platform(); // 'darwin', 'win32', 'linux', etc.

  console.log('VERSION:', packageJson.version);
  console.log('ENV:', constant.env);
  console.log('OS:', operatingSystem);
  console.log('TOOL:', constant.tool);
  console.log('BROWSERS:', constant.browser);
  console.log('SCENARIO TIMEOUT:', constant.scenarioTimeout);
  console.log('STEP TIMEOUT:', constant.stepTimeout);
});

Before(
  {
    timeout: constant.stepTimeout,
    tags: " @api or \
      @e2e or \
      @puppetter or \
      @playwright or \
      @selenium or \
      @cucumber \
    "
  }, 
  async function(scenario) {
    try {
      setDefaultTimeout(constant.scenarioTimeout);
      this.version = packageJson.version;
      this.scenario = scenario.pickle.name;
      this.currentUnixTime = currentUnixTime;
      this.date = date;
      this.taskDuration = 0; // performance testing - calculate page load from the beginning when the browser is opened if tastDuration = 0

      if (await constant.tool === 'puppeteer') {
        this.browser = await puppeteer.launch({
          executablePath: constant.puppeteerExecutablePath,
          headless: constant.headlessPupeeteer, // Chrome new headless https://developer.chrome.com/articles/new-headless/
          args: constant.argsSandbox, 
          dumpio: constant.dumpio
        });
        
        this.page = await this.browser.newPage()
        this.browserVersion = await this.page.browser().version()
        await this.page.authenticate({username: constant.basicAuthUser, password: constant.basicAuthPassword});
        await this.page.setViewport({width: constant.defaultWidth, height: constant.defaultHeight});
        await installMouseHelper(this.page);

        // MEMO - handling console.log error
        // await this.page.on('error', (err) => { console.log('error: ', err)})
        // await this.page.on('pageerror', (err) => { console.log('pageerror: ', err) })
        // await this.page.on('console', msg => { for (let i = 0; i < msg.args.length; ++i)  console.log(`${i}: ${msg.args[i]}`) })

        // Network log
        // Enable request interception
        // await this.page.setRequestInterception(true); // Page loading is not completed when this is enabled
        this.networkLogs = [];
        
        // Listen for network responses
        this.page.on('response', (response) => {
          const request = response.request();
          const url = request.url();
          const method = request.method();
          const status = response.status();
          // const headers = response.headers();
          // const body = response.text();

          // Store the network log information
          this.networkLogs.push({
            url,
            method,
            status,
            // headers,
            // body,
          });
        });

      } else if (await constant.tool === 'playwright') {
        // playwright
        if (await constant.browser === 'safari') { 
          this.browser = await webkit.launch({
            headless: constant.headless,
            slowMo: constant.slowMo,
            devtools: constant.devtools,
            dumpio: constant.dumpio,
            args: constant.argsWebkit
          });
        } else if (await constant.browser === 'firefox') {
          this.browser = await firefox.launch({headless: constant.headless,slowMo: constant.slowMo,devtools: constant.devtools,dumpio: constant.dumpio,args: constant.args});
        } else {
          this.browser = await chromium.launch({headless: constant.headless,slowMo: constant.slowMo,devtools: constant.devtools,dumpio: constant.dumpio,args: constant.args});

          // browser version
          const session = await this.browser.newBrowserCDPSession();
          this.browserVersion = await session.send('Browser.getVersion');
        }
    
        this.page = await this.browser.newPage({context: currentUnixTime});
        this.context = await this.browser.newContext({
          locale: 'ja-JP',
          // viewport: { width: constant.defaultWidth, height: constant.defaultHeight }
          // ...iPhone11,
          // geolocation: { longitude: 12.492507, latitude: 41.889938 },
          // permissions: ['geolocation'],
          httpCredentials: {
            username: constant.basicAuthUser,
            password: constant.basicAuthPassword,
          },
          // recordVideo: {
          //   dir: "./recordings",
          //   size: { width: constant.defaultWidth, height: constant.defaultHeight },
          // }
        });
        this.page = await this.context.newPage();
        await this.page.setViewportSize({width: constant.defaultWidth, height: constant.defaultHeight});
      } else if (await constant.tool === 'selenium') {
        // selenium
        // await driver.manage().window().setRect({width: constant.defaultWidth, height: constant.defaultHeight});
        // await driver.manage().window().maximize();

        // User data directory
        // const userDataDir = `/coverage/user-data/s/selenium_user_data_${Date.now()}`; // Unique user data directory
        const userDataDir = path.resolve(__dirname, `../../../coverage/user-data/selenium_user_data_pid_${process.pid}_${getFormattedDate()}_${Math.random().toString(36).substring(2, 15)}`); // Unique user data for parallelism random run

        // selenium driver setup (deprecated)
        // const capabilities = Capabilities.chrome();
        // capabilities.set('chromeOptions', { 
        //   "w3c": false, 
        //   args: [
        //     "--headless",
        //     `--user-data-dir=${userDataDir}`
        //   ] 
        // }); // Enable headless mode
        // this.seleniumDriver = new Builder().withCapabilities(capabilities).build();

        // selenium driver setup
        let options = new ChromeSeleniumWebdriver.Options();
        process.env.DEBUG === "1" ? '' : options.addArguments('--headless=new'); // Run Chrome in new headless mode
        options.addArguments(`--user-data-dir=${userDataDir}`); // User data directory

        this.seleniumDriver = new Builder()
          .forBrowser('chrome')
          .setChromeOptions(options)
          .build();

        // Get browser version
        const driverCapabilities = await this.seleniumDriver.getCapabilities();
        const browserName = driverCapabilities.get('browserName');
        const browserVersion = driverCapabilities.get('browserVersion');
        this.browserVersion = browserVersion;

        // Output Test Browser Information
        console.log('SELENIUM DRIVER CAPABILITIES:', driverCapabilities);
        console.log(`SELENIUM BROWSER NAME: ${browserName}`);
        console.log(`SELENIUM BROWSER VERSION: ${browserVersion}`);
        console.log('USER DATA DIR:', userDataDir);
      } else {
        // robot framework
      }

      // Output Test Browser Information
      console.log('BROWSER VERSION:', this.browserVersion);
    } catch (error) {
      // Handle the error as needed
      console.error("An error occurred in the Before hook:", error);
      // throw the error to fail the scenario
      throw error;
    }
  });

  After(
    {
      tags: " \
        @api or \
        @e2e or \
        @puppetter or \
        @playwright or \
        @selenium or \
        @cucumber \
      "
    }, 
    async function() {
      await evidenceAction.closing(this.page, this.browser);
    }
  );

  AfterAll(async function(){
      // await driver.quit();
  });