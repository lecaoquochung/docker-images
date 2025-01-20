# Yarn
# TOOL=puppeteer  yarn cucumber --tags "@selenium"
# TOOL=selenium  yarn cucumber --tags "@selenium"
# TOOL=playwright  yarn cucumber --tags "@selenium"

# yarn feature --tags "@selenium"

# NPM
# TOOL=puppeteer  npx cucumber-js --tags "@selenium"
# TOOL=selenium  npx cucumber-js --tags "@selenium"
# TOOL=playwright  npx cucumber-js --tags "@selenium"

@selenium
Feature: Searching for Cheese on Google

  Scenario: Finding some cheese with Selenium
    """
      Documentation
      https://cucumber.io/docs/guides/browser-automation/?lang=javascript

      Handling capcha when searching for "Cheese!" on Google
    """
    Given I am on the Google search page
    When  I search for "Cheese!"
    Then  the page title should start with "cheese"
    Then  Verify screenshot "selenium-chees"