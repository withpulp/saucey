#sauc·ey[*](http://www.urbandictionary.com/define.php?term=saucey)
[ /ˈsɑː-/ ] *intoxicated, drunk, or under the influence*
>Last night we went out to celebrate and got saucey at the bar off henessy.

##What this is?
Saucey is an Automation framework written in mainly PHP. Designed to kick-ass and take names.

##What it do?
This framework allows testers to:

* Control most aspects of the PC, i.e open a native iOS app with Xcode's iOS Simulator, etc.
* `Click`, `right-click`, `double-click`, `triple-click` & `drag` via X/Y coordinates.
* `Press any keyboard key(s)` either in conjunction or individually.
* `iOS/Android gestures`, i.e. 4-finger swipe left/right.
* Create & maintain tests for `Selenium` & headless drivers with [Gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin).
* Evaluate `REST/SOAP API` endpoints with business-logic driven code.
* Run `load & performance` tests.
* Hook a Browser-Based Web Inspector to your app
* Assert against `Network/XHR` & `console logs`, `DOM`, etc.
* Test UI elements with user-driven logic.
* Verify arrangement of files and directories; availability of assets.
* Set server-side, front-end and functional assertions.
* A reporting engine, with pass-fail statuses of all test cases, scenarios, and features
* Design `End-To-End`, `User Acceptance`, `Regression` & `Functional` test suites & cases
* Connect test suite(s) to a `continuous integration` system of choice.
* It's a Docker & Vagrant Image. Yes. The whole damn thing.

##What's inside

* [Selenium](http://docs.seleniumhq.org/)
* [PhantomJS](http://phantomjs.org/)
* [Behat](http://docs.behat.org/en/v3.0/)  
* [Pear](http://pear.php.net/)
* [Mink](http://mink.behat.org/en/latest/)  
* [JMeter](http://jmeter.apache.org/)
* [CLIClick](https://github.com/cucumber/cucumber/wiki/Gherkin)
* [Composer](https://getcomposer.org/)
* [Robo](https://github.com/Codegyre/Robo)
* [Weinre](http://people.apache.org/~pmuellr/weinre-docs/latest/Home.html)

##MOAR
* Find out more @ [http://saucey.io](http://saucey.io)  
* Fork the repo @ [https://github.com/withpulp/saucey.git](https://github.com/withpulp/saucey.git) 
* See [wiki](https://github.com/withpulp/saucey/wiki/)
	* See [The Winery](https://github.com/withpulp/saucey/wiki/The-Winery) for more on how this framework was set up.  
	* See [The Cellar](https://github.com/withpulp/saucey/wiki/The-Cellar) for available functionality.  

#Get Started
##Pour a glass (Init & Install)
To make things simpler, we'll use [Robo](https://github.com/Codegyre/Robo) for all of our task management needs. Lets install it! Install all dependancies through composer, if you run in to any issues please see the [wiki](https://github.com/withpulp/saucey/wiki/). 

For all instances of `<tag>` replace it with the tag for the test suite. For example, for my tests in **features/getSaucey** the tag is `saucey`.

1. From the root of the project, run:

		curl -sS https://getcomposer.org/installer | php

2. Then run:

		php composer.phar install
		
	Or if this is not the first time you are initializing saucey, run:
	
		php composer.phar update
		
3. From here, robo takes control, run:

		bin/robo init

4. For testing with Selenium `locally`:

		bin/robo saucey:tipsy '<tag> <browser>'
	
	or, if you want to test with PhantomJS or Goutte (headless & lightweight)
	
		bin/robo saucey:tipsy '<tag>'
		
	***Note: Not all tests will work with PhantomJS, i.e. @alert*

5. For testing against the `cloud`, obtain your `username` & `api-key` from [https://saucelabs.com/account](https://saucelabs.com/account) then set up your account with:

		
		robo saucey:connect
		
	Answer the following two questions with the information from your clipboard, and your project should be initialized.
		
	then, run:

		bin/robo saucey:drunk '<tag> <environment> <browser>'

##Shots! (examples)
###Local w/ [Selenium](http://docs.seleniumhq.org/) - Tipsy

1. Given you've installed via the below from above, Step 1. 
	
		curl -sS https://getcomposer.org/installer | php 
		
		php composer.phar install
		
		bin/robo init
		
2. Run local examples via:

		bin/robo saucey:tipsy 'form firefox'

	or 
	
		bin/robo saucey:tipsy 'web chrome'
		
	or 

		bin/robo saucey:tipsy 'api'
		
	or 
		
		bin/robo saucey:tipsy 'shell'
		
3. Robo should be running the test suite(s), upon completion it should open a newly generated report.

4. You should see a bunch of tests that look like the below output from `api`:

```gherkin
Feature: SOAP & REST API Functionality

  As a tester
  I want to make sure api features are up and running
  So that I can automate continuous integration and regression tests using it

    @api @get
    Scenario: Make and validate a GET request
      Given send a GET request to "/comments?postId=1&id=1"
      Then  the response code should be 200
      And the response should contain json:
      """
        [
          {
            "postId": 1,
            "id": 1,
            "name": "id labore ex et quam laborum",
            "email": "Eliseo@gardner.biz",
            "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
          }
        ]
```

###Cloud w/ [SauceLabs](saucelabs.com) - Drunk
1. Given you've installed via the below from above, Step 1. 
	
		curl -sS https://getcomposer.org/installer | php 
		
		php composer.phar install
		
		bin/robo init
		
2. Point your **saucey** installation to SauceLabs, you'd need your `username` and `api-key`. Sign up and register for a **free** [SauceLabs](https://saucelabs.com/) account. Then get your username and api-key via `/account.` Copy the info into your clipboard.
4. Run:

		robo saucey:connect
		
	Answer the following two questions with the information from your clipboard, and your project should be initialized.

5. Run a sanity suite via:  

		bin/robo saucey:drunk 'saucey mac chrome'

6. Then, go to [https://saucelabs.com/account](https://saucelabs.com/) and view your running/completed tests. Navigate through and download meta-data, screenshots and video recordings of the entire suite.

##Winery ([weinre](http://people.apache.org/~pmuellr/weinre-docs/latest/))

Open the `winery` via:

	bin/robo winery
		
Then, go to [http://127.0.0.1:7890](http://127.0.0.1:7890) 
	
Be sure to checkout the `Browser-Based Inspector` @ [http://127.0.0.1:7890/client/#anonymous](http://127.0.0.1:7890/client/#anonymous)
		
####localhost testing on the cloud
To test something on a localhost in the cloud, you can open a tunnel with sauce connect. With your username and api-key/access_key from the steps above, run:

	vendor/bin/sauce_config user_name access_key

To start the connect tunnel:

	vendor/sauce/connect/bin/sauce_connect 


###Mobile & Tablet
####For iOS:

	bin/robo saucey:drunk '<tag> ios_phone'

	bin/robo saucey:drunk '<tag> ios_tablet'

	bin/robo saucey:drunk '<tag> ios_tablet_landscape'

####For Android:

	bin/robo saucey:drunk '<tag> android_phone'

	bin/robo saucey:drunk '<tag> android_tablet'

	bin/robo saucey:drunk '<tag> android_tablet_landscape'

## Dependancies
On Mac OS X, (with the exception of LAMP for Windows) saucey requires the below dependancies. For now, the [Pour a glass](https://github.com/withpulp/saucey#pour-a-glass) section above should cover all dependancies. However, if there are errors thrown upon running:  

`php composer.phar install` or `php composer.phar update`

...you can reference the sources below. They should also be maintained. 


1. [XCode](https://developer.apple.com/xcode/downloads/) & [Developer Tools](http://stackoverflow.com/questions/9329243/xcode-4-4-and-later-install-command-line-tools)
2. [Java JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html), see [documentation](http://docs.oracle.com/javase/7/docs/webnotes/install/mac/mac-jdk.html)
3. [Node.js](https://nodejs.org/) & [npm](https://www.npmjs.com/package/download)
4. [cURL](http://curl.haxx.se/download.html)
5. [WAMP](http://www.wampserver.com/en/) `Windows Only`
6. [PHP](http://php-osx.liip.ch/) *just incase, should be covered by composer.*

#Reporting & MOAR

##Reporting
By default, reports are saved to the `reports/` directory. If you ran a suite via `saucey:drunk` or `saucey:tipsy`, you can see the report in:

	reports/

View real reports below:  

* [http://testweb.pw/adcade/Default/reports/saucey_report_web.html](http://testweb.pw/adcade/Default/reports/saucey_report_web.html)
* [http://testweb.pw/adcade/Default/reports/saucey_report_api.html](http://testweb.pw/adcade/Default/reports/saucey_report_api.html)
* [http://testweb.pw/adcade/Default/reports/saucey_report_shell.html](http://testweb.pw/adcade/Default/reports/saucey_report_shell.html)

#Caveats
1. To use the `local_safari` profile, in other words to test against a local version of Safari, go to:

	vendor/saucey/framework/drivers
	
2. And install the `safari_extension.cer`
3. Go `Safari`>`Preferences` and make sure it is enabled.

##Selenium Issues
The issues listed below are some known issues with the Selenium WebDriver.

1. Firefox ≤36.0.3 does not render ANY web driver functions from selenium, fixed in v36.0.4 with selenium 
2. Most of the major web driver functionality, i.e. pressing buttons, following links are completely non-functional for the Safari Web Driver.
3. Locally, some step definitions are non-functional: `iMoveBackwardOnePage`, `iMoveForwardOnePage`,`iRefreshThePage`

##Saucey Issues
See [https://github.com/withpulp/saucey/issues](https://github.com/withpulp/saucey/issues)

##TODO
See [https://github.com/withpulp/saucey/issues](https://github.com/withpulp/saucey/issues)
