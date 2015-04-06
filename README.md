#sauc·ey[*](http://www.urbandictionary.com/define.php?term=saucey)
[ /ˈsɑː-/ ] *intoxicated, drunk, or under the influence*
>Last night we went out to celebrate and got saucey at the bar off henessy.

##What this is?
Saucey is an Automation framework written in mainly PHP. Designed to kick-ass and take names.

##What it do?
This framework allows testers to:

* Control selenium & headless drivers with Gherkin
* Evaluate API endpoints with business-logic driven code
* Test UI elements with user-driven logic
* Verify arrangement of files and directories; availability of assets
* Set server-side, front-end and functional assertions
* Report coverage and pass-fail status of suites
* Connect test suite(s) to a continuous integration system of choice


#Get Started
##Pour a glass
Install all dependancies through composer, if you run in to any issues please see `Dependancies` below examples.

1. From the root of the project, run:

		php composer.phar install

	*or, if you've cloned/forked this repo before, run:*

		php composer.phar update


2. Then run:

		./saucey init

3. For testing against the `cloud`:

		vendor/sauce/connect/bin/sauce_connect user_name access_key
		
	then:
		
		vendor/sauce_config user_name access_key
	
	then:

		./saucey drunk @<tag> <environment> <browser>

4. For testing `locally`:

		./start_selnium <environment>

	*then*

		./saucey sober @<tag> <browser>

##Shots! (examples)
###Local w/ [Selenium](http://docs.seleniumhq.org/) - Tipsy

1. Initialize saucey by running:

		./saucey init

2. Start selenium via:

		./start_selenium mac

3. Open a new tab with `CMD` + `T`
4. Run a sanity suite via:

		./saucey tipsy api chrome

5. Open a new finder window, then open `reports/saucey_report_api.html`
6. Press "Feature: I want to make sure this test suite is up and running" to open detail view for that test suite. You should see a bunch of tests running, like:

```gherkin
Feature: SOAP & REST API Funtionality

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
1. Initialize saucey by running:

		./saucey init

2. To point **saucey** to SauceLabs, you'd need your `user_name` and `access_key`. Sign up and register for a **free** [SauceLabs](https://saucelabs.com/) account.
3. Get your username and api-key. *Should be available via /account.* Copy the info into your clipboard.
4. Open the `behat.yml` file with your favorite IDE and replace all instances of `adcadeQA:d3daa8f1-147e-4655-aa25-49606f633afa` with your username (used to log in) and api-key. Save.
5. Run a sanity suite via:  

		./saucey drunk web mac chrome

6. Then, go to [https://saucelabs.com/account](https://saucelabs.com/) and view your running/completed tests. Navigate through and download meta-data, screenshots and video recordings of the entire suite.
		
####localhost testing on the cloud
To test something on a localhost in the cloud, you can open a tunnel with sauce connect. With your username and api-key/access_key from the steps above, run:

	vendor/bin/sauce_config user_name access_key

To start the connect tunnel:

	vendor/sauce/connect/bin/sauce_connect 


###Mobile & Tablet
For iOS:

	./saucey drunk check ios_phone

	./saucey drunk check ios_tablet

	./saucey drunk check ios_tablet_landscape

For Android:

	./saucey drunk check android_phone

	./saucey drunk check android_tablet

	./saucey drunk check android_tablet_landscape

## Dependancies
On Mac OS X, (with the exception of LAMP for Windows) saucey requires the below dependancies. For now, the `Pour a glass` section above should cover all dependancies. However, if there are errors thrown upon running `php composer.phar install` or `php composer.phar update` in terminal you can reference the sources below. They should also be maintained. 


1. [XCode](https://developer.apple.com/xcode/downloads/) & [Developer Tools](http://stackoverflow.com/questions/9329243/xcode-4-4-and-later-install-command-line-tools)
2. [Java JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html), see [documentation](http://docs.oracle.com/javase/7/docs/webnotes/install/mac/mac-jdk.html)
3. [cURL](http://curl.haxx.se/download.html)
4. [WAMP](http://www.wampserver.com/en/) `Windows Only`
5. [PHP](http://php-osx.liip.ch/) *just incase, should be covered by composer.*

#Reporting & MOAR

##Reporting
By default, reports are saved to the `reports/` directory. If you ran a suite via `./saucey drunk` or `./saucey tipsy`, you can see the report in:

	reports/

View real output reports below:  

* [http://testweb.pw/adcade/Default/reports/saucey_report_web.html](http://testweb.pw/adcade/Default/reports/saucey_report_web.html)
* [http://testweb.pw/adcade/Default/reports/saucey_report_api.html](http://testweb.pw/adcade/Default/reports/saucey_report_api.html)
* [http://testweb.pw/adcade/Default/reports/saucey_report_shell.html](http://testweb.pw/adcade/Default/reports/saucey_report_shell.html)

##MOAR
* Find out more @ [http://saucey.io](http://saucey.io)  
* Fork the repo @ [https://github.com/saucey-io/saucey.git](https://github.com/saucey-io/saucey.git) 
* See [wiki](https://github.com/getsaucey/saucey/wiki/)
* See the [winery-setup](https://github.com/getsaucey/saucey/wiki/The-Winery) for more on how this framework was set up.  
* More on Behat [here](http://docs.behat.org/en/v3.0/)  
* .. Mink [here](http://mink.behat.org/en/latest/)  
* .. Pear [here](http://pear.php.net/)

#Caveats & Issues
##Caveats
1. To use the `local_safari` profile, in other words to test against a local version of Safari, go to:

	vendor/saucey/drivers/
	
2. And install the `safari_extension.cer`
3. Go `Safari`>`Preferences` and make sure it is enabled.

##Selenium Issues
The issues listed below are some known issues with the Selenium WebDriver.

1. Firefox ≤36.0.3 does not render ANY web driver functions from selenium, fixed in v36.0.4 with selenium 
2. Most of the major web driver functionality, i.e. pressing buttons, following links are completely non-functional for the Safari Web Driver.


##Saucey Issues
1. ~~API functionality is not implemented currently because of  aug blocking functionality.~~
2. ~~Using the current HTML output generator, there is no shell output when running `./saucey`~~
3. Dynamic reporting of error types. Steps that failed are shown, but the output is generic.
4. *Duplicate context and usage of FeatureContext* -- **High Priority !!!**

##TODO

[ ~~Done~~ / *In Progress* ]

###base tasks
1. ~~Contextualize shell functionality for reusability~~
2. ~~Change FeatureContext to WebContext of its' own.~~
3. *Make context for clicking XY coordinates*
4. *Make context for dragging and dropping with XY coordinates*
5. Load test automation with JMeter API
6. Connect to its own Jenkins CI instance
7. Dockerize!!!

###readme tasks
1. *How to write functional Gherkin tests*
2. How to write custom step definitions
3. How to add saucey to a project
4. How to add/modify yaml and composer dependancies
5. ~~Refactor and add comments to all step definitions~~

###frontend tasks
1. *get.saucey.io*
2. app.saucey.io, finish UI/UX and app skeleton
