# [saucey](http://www.urbandictionary.com/define.php?term=saucey)
*intoxicated, drunk, or under the influence*
> Last night we went out to celebrate and got saucey at the bar off henessy. 

Saucey is an Automation framework written in mainly PHP, using Behat and Mink. This framework allows testers to:

* Control selenium & headless drivers with [Gherkin](http://blog.sajjad.pw/technology/2014/07/15/Behavior-Driven-Development-And-Gherkin.html)
* Evaluate API endpoints with business-logic driven code
* Test UI element with user-driven logic
* Verify arrangement of files and directories;s availability of assets
* Set server-side, front-end and functional assertions
* Report coverage and pass-fail status of suites
* Connect test suite(s) to a continuous integration system of choice

Find out more @ [http://saucey.io](http://saucey.io)  
Fork the repo @ [https://github.com/sajjadhossain/saucey.git](https://github.com/sajjadhossain/saucey.git)  



## Dependancies
On Mac OS X, (with the exception of LAMP for Windows) this requires:


1. [XCode](https://developer.apple.com/xcode/downloads/) & [Developer Tools](http://stackoverflow.com/questions/9329243/xcode-4-4-and-later-install-command-line-tools)
2. [PHP](http://php-osx.liip.ch/)
3. [Java JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html), see [documentation](http://docs.oracle.com/javase/7/docs/webnotes/install/mac/mac-jdk.html) 
4. [cURL](http://curl.haxx.se/download.html)
5. [WAMP](http://www.wampserver.com/en/) `Windows Only` 


##Get Started
Hit the ground running. Install all dependancies with composer (may require a php installation, see [php-documents](http://php-osx.liip.ch/)).

From the root of the project, run:

	php composer.phar install


Running your first suite as easy as:  

1. For testing against the `cloud`: 
	
		saucey drunk @<tag> <environment> <browser>
	
2. For testing `locally`: 
		
		start_selnium <environment>
		
	*then*

		saucey sober @<tag> <browser>


#Examples
##Local - Tipsy

1. View saucy intro:

		./saucy

2. Start selenium via:
	
		./start_selenium mac
	
3. Open a new tab with `CMD` + `T`
4. Run a sanity suite via:
	
		./saucy tipsy check chrome 

5. Open a new finder window, then open `reports/check_suite/report.html`
6. Press "Feature: I want to make sure this test suite is up and running" to open detail view for that test suite. You should see:
		
```gherkin

	Feature: I want to make sure this test suite is up and running
	  
	  As a tester
	  I want to make sure this test suite is up and running
	  So that I can automate continuous integration and regression tests
	
	@javascript @check
	  Scenario: Check against google.com and search # features/check.feature:8
	    Given I am on "http://google.com"           # FeatureContext::visit()
	    Then the response should contain "Google"   # FeatureContext::assertResponseContains()
	    And I should see "Google Search"            # FeatureContext::assertPageContainsText()
	    When I fill in "q" with "Adcade"            # FeatureContext::fillField()
	    And I wait for 5 seconds                    # FeatureContext::iWaitForSeconds()
	    Then I should see "Adcade"                  # FeatureContext::assertPageContainsText()


```


##Cloud w/ [SauceLabs](saucelabs.com) - Drunk

1. View saucy intro:

		./saucy
		
2. Run a sanity suite via:
	
		./saucy drunk check mac chrome
		
3. Open a new finder window, then open `reports/check_suite/report.html`
6. Press "Feature: I want to make sure this test suite is up and running" to open detail view for that test suite. You should see the same out put as above. 

		
###Mobile & Tablet
Open Terminal, go to the project folder, and run:

For iOS:

	./saucy drunk check ios_phone
	
	./saucy drunk check ios_tablet
	
	./saucy drunk check ios_tablet_landscape

For Android:

	./saucy drunk check android_phone
	
	./saucy drunk check android_tablet
	
	./saucy drunk check android_tablet_landscape
		

##Reporting & More
By default, reports are saved to the `reports/` directory. If you ran a suite via `./saucy drunk` or `./saucy tipsy`, you can see the report in:

	reports/<tag>_suite/

So for our example above the report would be available by opening `reports/check_suite/report.html`.

###More

See `./setup.md` for more on how this framework was set up.