# HTTP-API-Web-Testing-Kit
Automation of HTTP, HTTPS, API and UI using PHPUnit, Behat, Mink, Pear and Selenium.

## Dependancies
On Mac OS X, this requires:

1. [XCode](https://developer.apple.com/xcode/downloads/) & [Developer Tools](http://stackoverflow.com/questions/9329243/xcode-4-4-and-later-install-command-line-tools)
3. [Java JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html), see [documentation](http://docs.oracle.com/javase/7/docs/webnotes/install/mac/mac-jdk.html) 
4. [cURL](http://curl.haxx.se/download.html)
5. [WAMP](http://www.wampserver.com/en/) `Windows Only` 


## Installation
##Clone It

	git clone https://github.com/sajjadhossain/HTTP-API-Web-Testing-Kit.git

##Start Selenium
Open Terminal, go to the project folder, and run:

	java -jar selenium-server-standalone-2.43.1.jar

Then `COMMAND + T` or open a new Terminal tab. Then:

##Run Tests

	bin/behat feature/AdcadeRegression.feature

You should see:

```gherkin
	Feature: I want to automate continous integration and regression tests for API and End Points
	  
	  As a tester
	  I want to evaluate API and end-points
	  So that I can automate continous integration and regression tests
	
	  @regression @smoke @POSTRequests @Staples
	  Scenario Outline: Metric Requests for Staples Accelerator  # features/AdcadeAPI.feature:8
	    Given I send a POST request to "<requestURL>" with body: # Behat\CommonContexts\WebApiContext::iSendARequestWithBody()
	      """
	      BODY
	      """
	    Then the response code should be 200                     # Behat\CommonContexts\WebApiContext::theResponseCodeShouldBe()
	
	    Examples:
	      | requestURL | body |
	      | http://ad-stage.adcade.com/2/event/81983ac5-2703-4631-b9de-19e1a724e7e6/ | POST DATA|
	      ...
	      | http://ad-stage.adcade.com/2/event/81983ac5-2703-4631-b9de-19e1a724e7e6/ | POST DATA |
	
	  @regression @smoke @POSTRequests @Videos
	  Scenario Outline: Metric Requests for Refinery 29 Video H-Unit # features/AdcadeAPI.feature:28
	    Given I send a POST request to "<requestURL>" with body:     # Behat\CommonContexts\WebApiContext::iSendARequestWithBody()
	      """
	      BODY
	      """
	    Then the response code should be 200                         # Behat\CommonContexts\WebApiContext::theResponseCodeShouldBe()
	
	    Examples:
	     | requestURL | body |
	     | https://ad-stage.adcade.com/2/event/cf7964c2-2619-42b2-9bac-81cb26d0da97/ | POST DATA |
			...
			| https://ad-stage.adcade.com/2/event/cf7964c2-2619-42b2-9bac-81cb26d0da97/ | POST DATA |
	
	  @javascript @regression @smoke @GETRequests
	  Scenario Outline: GET 200 Requests                             # features/AdcadeAPI.feature:45
	    Given I am on "<requestURL>"                                 # FeatureContext::visit()
	    Then the response should contain "<expectedOutcome>"         # FeatureContext::assertResponseContains()
	
	    Examples:
	      | requestURL | expectedOutcome |
	      ...	      
	      | https://resource.adcade.com/ad-assets/f2a81d25-a9cb-4404-9840-fb48db6445c7/assets/vid/video.mp4?q=3d7c2c79b16b | video.mp4 |
	
	38 scenarios (38 passed)
	76 steps (76 passed)
	0m9.96s
```

##Components
This repository is powered by:
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
