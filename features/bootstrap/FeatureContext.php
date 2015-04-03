<?php
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;

/**
 * Defines application features from the specific context.
 */

 class FeatureContext extends MinkContext implements Context, SnippetAcceptingContext
{
  /*GLOBAL CONTEXT*/
  /**
   * Initializes context.
   * Every scenario gets it's own context object.
   *
   */
   public function __construct($baseUrl)
   {
     $this->baseUrl = $baseUrl;
   }

  /**
  * @Given /^I wait for (\d+) seconds$/
  */
  public function iWaitForSeconds($seconds)
  {
    $this->getSession()->wait($seconds*1000);
  }

  /**
   * @Given /^I set browser window size to "([^"]*)" x "([^"]*)"$/
   *
   * @param string $width, $height The message.
   */
  public function iSetBrowserWindowSizeToX($width, $height) {
    $this->getSession()->getDriver()->resizeWindow((int)$width, (int)$height, 'current');
  }

  /**
   * @When /^I hover over the element "([^"]*)"$/
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
  */
  public function confirmPopup()
  {
    $this->getSession()->getDriver()->getWebDriverSession()->accept_alert();
  }
  /**
  * @when /^(?:|I )cancel the popup$/
  */
  public function cancelPopup()
  {
    $this->getSession()->getDriver()->getWebDriverSession()->dismiss_alert();
  }

  /**
  * @When /^I should see "([^"]*)" in popup$/
  *
  * @param string $message The message.
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
  *
  * @param string $message The message.
  */
  public function setPopupText($message)
  {
    $this->getSession()->getDriver()->getWebDriverSession()->postAlert_text($message);
  }

  /**
  * @Given /^I click on the element with xpath "([^"]*)"$/
  */
  public function iClickOnTheElementWithXpath2($xpath)
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
  * @When /^I click on the element with xpath \'([^\']*)\'$/
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
  */
  public function iClick($css)
  {
    $session = $this->getSession();
    $element = $session->getPage()->find('css', $css);
    $element->click();
  }

  /**
  * @Given /^I scroll to the bottom$/
  */
  public function iScrollToBottom() {
    $javascript = 'window.scrollTo(0, Math.max(document.documentElement.scrollHeight, document.body.scrollHeight, document.documentElement.clientHeight));';
    $this->getSession()->executeScript($javascript);
  }

  /**
  * @Given /^I scroll to the top$/
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
  */
  public function iAmOnANewSession()
  {
    $this->getSession()->restart();
  }



  #
  # WORK IN PROGRESS
  # TO DO:
  // 1. Make context for clicking XY coordinates
  // 2. Make context for dragging and dropping with XY coordinates
  // 3. Connect to its own Jenkins CI instance
  // 4. Dockerize!!!

  /**
  * @When /^I click ad coordinates$/
  */
  public function iClickAdCoordinates()
  {
    //$session->moveto(array('xoffset' => 3, 'yoffset' => 300));
    //$this->getSession()->click();
  }

}
