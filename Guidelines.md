#Local Automated Testing 
## Mac OS X
Make sure you have `Internet Explorer`, `Chrome` & `Firefox` downloaded on your machine or virtual machine.

Open Terminal, then navigate to the project directory:

	cd ~/Desktop/HTTP-API-Web-Testing-Kit/

### Firefox
Start Selenium with default:

	java -jar selenium-server-standalone-2.43.1.jar
	
Open a new window/tab, then:

	bin/behat
	
### Chrome
In Terminal or Finder open `behat.yml` in the root of the project directory.

Then change:

    selenium2:
      browser: firefox

To:

    selenium2:
      browser: chrome

Start Selenium with the chromeDriver as a parameter:

	java -jar selenium-server-standalone-2.43.1.jar -Dwebdriver.chrome.driver=./Drivers/chromedriver

Wait 1-3 minutes, open a new window/tab, then: 

	bin/behat
	
	or
	
	bin/behat features/AdcadeRegression.feature
	
### Safari
In Terminal or Finder open `behat.yml` in the root of the project directory.

Then change:

    selenium2:
      browser: firefox

To:

    selenium2:
      browser: safari

1. Download this [plugin](https://github.com/SeleniumHQ/selenium/raw/master/javascript/safari-driver/prebuilt/SafariDriver.safariextz).
2. Install the [developers certificate](https://developer.apple.com/account/overview.action) in your "Keychain"
3. Open Safari
4. Go to Preferences
5. Click on the Extensions tab
6. Make sure WebDriver for WebDriver 2.38.0 is checked "enabled"
7. Close Safari

Start Selenium with the safariDriver as a parameter:

	java -jar selenium-server-standalone-2.43.1.jar -Dwebdriver.safari.noinstall=true
	
Wait 1-3 minutes, open a new window/tab, then: 

	bin/behat
	
	or
	
	bin/behat features/AdcadeRegression.feature
	
## Windows
### Requirements
If you're on a Virtual Machine, there are a couple of things needed to get behat running. Make sure you have `Internet Explorer`, `Chrome` & `Firefox` downloaded on your machine or virtual machine. 

1. [Visual C++ 2008 Redistributables](http://www.microsoft.com/downloads/details.aspx?familyid=9B2DA534-3E03-4391-8A4D-074B9F2BC1BF)
2. [WAMP](http://www.wampserver.com/en/)
3. Add java to your PATH via [steps](https://www.java.com/en/download/help/path.xml)
4. Similar to the above step, add PHP to your PATH `C:\wamp\bin\php\php5.5.12;`
5. Depending on your Internet Explorer settings, you may need to [Enable Protection Mode](http://stackoverflow.com/questions/14952348/not-able-to-launch-ie-browser-using-selenium2-webdriver-with-java)


Open Command Prompt, then navigate to the project directory:

	cd Desktop\HTTP-API-Web-Testing-Kit
	
### Internet Explorer
Start Selenium with the ieDriver as a parameter:

	java -jar selenium-server-standalone-2.43.1.jar -Dwebdriver.ie.driver=Drivers\IEDriverServer.exe

Open a new window/tab, then: 

	bin\behat
	
	or
	
	bin/behat features/AdcadeRegression.feature	
### Firefox 
In Terminal or Finder open `behat.yml` in the root of the project directory.

Then change:

    selenium2:
      browser: ie

To:

    selenium2:
      browser: firefox
 
Start Selenium with the firefoxDriver (default) as a parameter:

	java -jar selenium-server-standalone-2.43.1.jar
  
Open a new window/tab, then: 

	bin\behat
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature
	
###Chrome
In Terminal or Finder open `behat.yml` in the root of the project directory.

Then change:

    selenium2:
      browser: ie

To:

    selenium2:
      browser: chrome
 
Start Selenium with the firefoxDriver (default) as a parameter:

	java -jar selenium-server-standalone-2.43.1.jar -Dwebdriver.chrome.driver=Drivers\chromedriver.exe
  
Open a new window/tab, then: 

	bin\behat
	
	or
	
	bin/behat features/AdcadeRegression.feature	
#Cloud Automated Testing
You can see the syntax [here](https://saucelabs.com/platforms/webdriver) for web driver manipulation.

## Mac OS X Simulating
### Firefox
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Then change:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}

To: 

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "OS X 10.10", "version": "8", "name": "NAME THIS SUITE"}

Make sure you've changed the `name`.

Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature
	
### Chrome
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Then change:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}

To: 

	selenium2:
	  browser: chrome
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "OS X 10.10", "version": "8", "name": "NAME THIS SUITE"}

Make sure you've changed the `name`.

Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature
	
### Safari
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Then change:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}

To: 

	selenium2:
	  browser: safari
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "OS X 10.10", "version": "8", "name": "NAME THIS SUITE"}

Make sure you've changed the `name`.

Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature
	
##Windows Simulating
### Internet Explorer
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Then change:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}
	  
To:

	selenium2:
	  browser: ie
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 7", "version": "8", "name": "NAME THIS SUITE"}
	  
Make sure you've changed the `name`.

Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature
	
### Firefox
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Make sure the `selenium2` instance is called as:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}
	  
Make sure you've changed the `name`.

Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature

### Chrome
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Then change:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}
	  
To:

	selenium2:
	  browser: chrome
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 7", "version": "39", "name": "NAME THIS SUITE"}
	  
Make sure you've changed the `name`.

Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature

## Cloud Mobile Automated Testing
## iPad
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Then change:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}
	  
To:

      selenium2:
        browser: iPad
        wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
        capabilities: {  "platform": "OS X 10.9", "version": "8.1", "name": "NAME THIS SUITE"}
	  
Make sure you've changed the `name`. Additionally, you can add `"deviceOrientation": "landscape",` or `portrait` to test orientation. 

Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature

## iPhone
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Then change:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}
	  
To:

      selenium2:
        browser: iPhone
        wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
        capabilities: {  "platform": "OS X 10.9", "version": "8.1", "name": "NAME THIS SUITE"}
	  
Make sure you've changed the `name`.

Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature

## Android Phone
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Then change:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}
	  
To:

      selenium2:
        browser: android
        wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
        capabilities: {  "platform": "Linux", "version": "4.4", "name": "NAME THIS SUITE", "deviceType": "phone"}
	  
Make sure you've changed the `name`.

Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature

## Android Tablet
In Terminal or Finder open `sauce.yml` in the root of the project directory.

Then change:

	selenium2:
	  browser: firefox
	  wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
	  capabilities: {  "platform": "Windows 2012", "version": "10", "name": "Regression Suite"}
	  
To:

      selenium2:
        browser: android
        wd_host: sajjadAdcade:f6bd677e-c92b-42ce-9564-e75f90d80cfb@ondemand.saucelabs.com/wd/hub
        capabilities: {  "platform": "Linux", "version": "4.4", "name": "NAME THIS SUITE", "deviceType": "tablet"}
	  
Make sure you've changed the `name`. Additionally, you can add `"deviceOrientation": "landscape",` or `portrait` to test orientation. 


Then: 

	bin/behat  -c sauce.yml
	
	or
	
	bin/behat  -c sauce.yml features/AdcadeRegression.feature