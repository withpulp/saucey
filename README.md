# Saucy.php
Automation of HTTP, HTTPS, API and UI using PHPUnit, Behat, Mink, Pear and Selenium.

## Dependancies
On Mac OS X, this requires:

1. [XCode](https://developer.apple.com/xcode/downloads/) & [Developer Tools](http://stackoverflow.com/questions/9329243/xcode-4-4-and-later-install-command-line-tools)
3. [Java JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html), see [documentation](http://docs.oracle.com/javase/7/docs/webnotes/install/mac/mac-jdk.html) 
4. [cURL](http://curl.haxx.se/download.html)
5. [WAMP](http://www.wampserver.com/en/) `Windows Only` 


## Installation
##Clone It

	git clone https://github.com/sajjadhossain/SaucyPHP.git

##Start Selenium
Open Terminal, go to the project folder, and run:

	java -jar selenium-server-standalone-2.43.1.jar

Then `COMMAND + T` or open a new Terminal tab. Then:

##Run Tests

	bin/behat

You should see:

```gherkin

	Feature: I want to make sure this test suite is up and running
	  
	  As a tester
	  I want to make sure this test suite is up and running
	  So that I can automate continuous integration and regression tests
	
	@javascript @regression @sanity
	  Scenario: Check against google.com and search # features/check.feature:8
	    Given I am on "http://google.com"           # FeatureContext::visit()
	    Then the response should contain "Google"   # FeatureContext::assertResponseContains()
	    And I should see "Google Search"            # FeatureContext::assertPageContainsText()
	    When I fill in "q" with "Adcade"            # FeatureContext::fillField()
	    And I wait for 5 seconds                    # FeatureContext::iWaitForSeconds()
	    Then I should see "Adcade"                  # FeatureContext::assertPageContainsText()
	

```

##Reporting & More
###Run tests and save reports in /report

	bin/behat --format html --out report/<name>.html

###Run tests grouped by tags
A good example of this is accomplished for the help-center. 

	bin/behat --tags "@helpCenter"

These parameters can be combined, for say when you want reports generated for tests executed against scenarios grouped in a tag. 

	bin/behat --tags "@helpCenter" --out report/<name>.html

###More

See `Guidelines.md` within this directory on how to run these tests against multiple browsers and on the cloud. Includes iOS and Android, Phone and Tablets.

##Components
The below **ARE NOT REQUIREMENTS/DEPENDANCIES** , they simply make this tool functional. This repository is powered by:
#### Composer

	curl http://getcomposer.org/installer | php
	php composer.phar install

Or you may need to just update to install thhe dependancies listed in `composer.json` via:

	php composer.phar update
	

#### Pear

	wget http://pear.php.net/go-pear.phar
	php go-pear.phar

#### PHPUnit 3.x & Up

	pear channel-discover pear.phpunit.de
	pear channel-discover components.ez.no
	pear channel-discover pear.symfony-project.com	
	pear install phpunit/PHPUnit
