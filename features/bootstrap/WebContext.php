<?php
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;

/**
* Defines application features from the WEB context.
*/

class WebContext extends MinkContext implements Context, SnippetAcceptingContext
{
    public $webUrl;

    /*WEB CONTEXT*/
    /**
    * Initializes context.
    * Every scenario gets it's own context object.
    *
    */
    public function __construct($webUrl)
    {
        $this->webUrl = $webUrl;
    }

    /**
    * @Given /^I wait for (\d+) seconds$/
    * Example: Given I wait for 10 seconds
    * Example: When I wait for 9 seconds
    * Example: And I wait for 8 seconds
    *
    */
    public function iWaitForSeconds($seconds)
    {
        $this->getSession()->wait($seconds*1000);
    }

    /**
    * @Given /^I set browser window size to "([^"]*)" x "([^"]*)"$/
    * Example: Given I set browser window size to "1900" x "1200"
    * Example: When I set browser window size to "1900" x "1200"
    * Example: And I set browser window size to "1900" x "1200"
    *
    * @param string $width, $height The message.
    */
    public function iSetBrowserWindowSizeToX($width, $height) {
        $this->getSession()->getDriver()->resizeWindow((int)$width, (int)$height, 'current');
    }

    /**
    * @Given I set my browser window size to MacBook Standard
    * Example: Given I set my browser window size to MacBook Standard
    * Example: When I set my browser window size to MacBook Standard
    * Example: And I set my browser window size to MacBook Standard
    *
    */
    public function iSetMyBrowserWindowSizeToMacbookStandard()
    {
        $this->getSession()->getDriver()->resizeWindow((int)'1440', (int)'900', 'current');
    }

    /**
    * @Given I set my browser window size to 15 inch MacBook Retina
    * Example: Given I set my browser window size to 15 inch MacBook Retina
    * Example: When I set my browser window size to 15 inch MacBook Retina
    * Example: And I set my browser window size to 15 inch MacBook Retina
    *
    */
    public function iSetMyBrowserWindowSizeTo15InchMacbookRetina()
    {
        $this->getSession()->getDriver()->resizeWindow((int)'2880', (int)'1800', 'current');
    }

    /**
     * @Given I set my browser window size to 13 inch MacBook Retina
     * Example: Given I set my browser window size to 13 inch MacBook Retina
     * Example: When I set my browser window size to 13 inch MacBook Retina
     * Example: And I set my browser window size to 13 inch MacBook Retina
     *
     */
    public function iSetMyBrowserWindowSizeTo13InchMacbookRetina()
    {
        $this->getSession()->getDriver()->resizeWindow((int)'2560', (int)'1600', 'current');
    }



    /**
    * @Given I set my browser window size to Windows Standard
    * Example: Given I set my browser window size to Windows Standard
    * Example: When I set my browser window size to Windows Standard
    * Example: And I set my browser window size to Windows Standard
    *
    */
    public function iSetMyBrowserWindowSizeToWindowsStandard()
    {
        $this->getSession()->getDriver()->resizeWindow((int)'1280', (int)'1084', 'current');
    }

    /**
     * @Given I set my browser window size to :x x :y
     * Example: Given I set my browser window size to "500" x "500"
     * Example: When I set my browser window size to "500" x "500"
     * Example: And I set my browser window size to "500" x "500"
     */
    public function iSetMyBrowserWindowSizeToX($x, $y)
    {
        $this->getSession()->getDriver()->resizeWindow((int)"'.$x.'", (int)"'.$y.'", 'current');
    }


    /**
    * @When /^I hover over the element "([^"]*)"$/
    * Example: When I hover over the element "sign-up-button"
    * Example: And I hover over the element "sign-up-button"
    *
    */
    public function iHoverOverTheElement($locator)
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find('css', $locator); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
          throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $locator));
        }

        // ok, let's hover it
        $element->mouseOver();
    }

    /**
    * @When /^I confirm the popup$/
    * Example: When I confirm the popup
    * Example: And I confirm the popup
    *
    */
    public function confirmPopup()
    {
        $this->getSession()->getDriver()->getWebDriverSession()->accept_alert();
    }
    /**
    * @When /^(?:|I )cancel the popup$/
    * Example: When I cancel the popup
    * Example: And I cancel the popup
    *
    */
    public function cancelPopup()
    {
        $this->getSession()->getDriver()->getWebDriverSession()->dismiss_alert();
    }

    /**
     * @When /^I should see "([^"]*)" in popup$/
     * Example: And I should see "Bruce Wayne is not Batman" in popup
     * Example: Then I should see "Bruce Wayne is not Batman" in popup
     *
     * @param string $message The message.
     * @throws Exception
     */
    public function assertPopupMessage($message)
    {
        $alertText = $this->getSession()->getDriver()->getWebDriverSession()->getAlert_text();
        if ($alertText !== $message){
          throw new Exception("Modal dialog present: $alertText, when expected was $message");
        }
    }

    /**
    * @When /^(?:|I )fill "([^"]*)" in popup$/
    * Example: When I fill "Then why does he hang out with Dick Grayson?" in popup
    * Example: And I fill "Then why does he hang out with Dick Grayson?" in popup
    *
    * @param string $message The message.
    */
    public function setPopupText($message)
    {
        $this->getSession()->getDriver()->getWebDriverSession()->postAlert_text($message);
    }

    /**
    * @When /^I click on the element with xpath \'([^\']*)\'$/
    * @Given /^I click on the element with xpath "([^"]*)"$/
    *
    * Example: When I click on the element with xpath '//*[@id="find-out-who-batman-is"]'
    * Example: And I click on the element with xpath '//*[@id="find-out-who-batman-is"]'
    *
    * @param string $xpath is an XPath for an object
    */
    public function iClickOnTheElementWithXPath($xpath)
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
          'xpath',
        $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
          throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

    /**
    * @Given /^I click "([^"]*)"/
    * Example: Given I click "css-class"
    * Example: And I click "css-class"
    *
    */
    public function iClick($css)
    {
        $session = $this->getSession();
        $element = $session->getPage()->find('css', $css);
        $element->click();
    }

    /**
    * @Given /^I scroll to the bottom$/
    * Example: Given I scroll to the bottom
    * Example: When I scroll to the bottom
    * Example: And I scroll to the bottom
    *
    */
    public function iScrollToBottom() {
        $javascript = 'window.scrollTo(0, Math.max(document.documentElement.scrollHeight, document.body.scrollHeight, document.documentElement.clientHeight));';
        $this->getSession()->executeScript($javascript);
    }

    /**
    * @Given /^I scroll to the top$/
    * Example: Given I scroll to the top
    * Example: When I scroll to the top
    * Example: And I scroll to the top
    *
    */
    public function iScrollToTop() {
        $this->getSession()->executeScript('window.scrollTo(0,0);');
    }

    /**
    * Scroll to a certain element by label.
    * Requires an "id" attribute to uniquely identify the element in the document.
    *
    * Example: Given I scroll to the "Submit" button
    * Example: Given I scroll to the "My Date" field
    *
    * @Given /^I scroll to the "([^"]*)" (field|link|button)$/
    */
    public function iScrollToField($locator, $type) {
        $page = $this->getSession()->getPage();
        $el = $page->find('named', array($type, $locator));
        # assertNotNull($el, sprintf('%s element not found', $locator));
        $id = $el->getAttribute('id');
        if(empty($id)) {
          throw new \InvalidArgumentException('Element requires an "id" attribute');
        }
        $js = sprintf("document.getElementById('%s').scrollIntoView(true);", $id);
        $this->getSession()->executeScript($js);
    }

    /**
    * @Given /^I am on a new session$/
    * Example: Given I am on a new session
    * Example: And I am on a new session
    *
    */
    public function iAmOnANewSession()
    {
        $this->getSession()->restart();
    }

    /**
     * @Then I go to network tab
     * Example: When I go to network tab
     * Example: Then I go to network tab
     * Example: And I go to network tab
     */
    public function iGoToNetworkTab($xpath = '//*[@id="toolbar"]/button[4]')
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

    /**
     * @Then I go to elements tab
     * Example: When I go to elements tab
     * Example: Then I go to elements tab
     * Example: And I go to elements tab
     */
    public function iGoToElementsTab($xpath = '//*[@id="toolbar"]/button[2]/div[1]')
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

    /**
     * @Then I go to console tab
     * Example: When I go to console tab
     * Example: Then I go to console tab
     * Example: And I go to console tab
     */
    public function iGoToConsoleTab($xpath = '//*[@id="toolbar"]/button[7]/div[2]')
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

    /**
     * @Then I select request :number
     * Example: When I select request 1
     * Example: Then I select request 1
     * Example: And I select request 1
     *
     * @param $number
     */
    public function iSelectRequest($number)
    {
        $xpath = "//*[@id='network-container']/div/div[1]/table/tbody/tr[{$number}]/td[1]/div";

        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

    /**
     * @Then I am on the network header tab
     * Example: When I go to network header tab
     * Example: Then I go to network header tab
     * Example: And I go to network header tab
     */
    public function iAmOnTheHeaderTab($xpath = '//*[@id="network-views"]/div/div[1]/li[1]')
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }


}
