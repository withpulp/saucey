<?php
// features/bootstrap/FeatureContext.php testing-rest-api-with-behat/FeatureContext.php
use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;
use GuzzleHttp\Client;


//
// Require 3rd-party libraries here:
//
//   require_once 'PHPUnit/Autoload.php';
//   require_once 'PHPUnit/Framework/Assert/Functions.php';
//
require_once 'RestContext.php';
require_once 'vendor/autoload.php';

/**
* Features context.
*/

class FeatureContext extends Behat\MinkExtension\Context\MinkContext
{

     /*GLOBAL CONTEXT*/

     /**
     * @BeforeFeature [@helpCenter]
     */
     public static function prepare(BeforeFeatureScope $scope)
     {
        exec('mongo keystone --eval "db.dropDatabase();"');
     }

     /**
      * @AfterScenario @database
      */
     public function cleanDB(AfterScenarioScope $scope)
     {
       exec('mongo keystone --eval "db.dropDatabase();"');
     }

    /**
     * Initializes context.
     * Every scenario gets its own context object.
     *
     * @param   array   $parameters     context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        $this->useContext('api',
            new Behat\CommonContexts\WebApiContext($parameters['base_url'])        );

        $this->getSubcontext('api')
            ->setPlaceHolder('BASE_URL', rtrim($parameters['base_url'], '/')        );
    }

    /**
    * @Given /^I wait for (\d+) seconds$/
    */
    public function iWaitForSeconds($seconds)
    {
      $this->getSession()->wait($seconds*1000);
    }

    /**
    * @When /^I mouse over the element matching "([^"]*)"$/
    */
    public function iMouseOverElementMatching($selector)
    {
        $this->spin(function($context) use ($selector) {
            $page = $context->getSession()->getPage();
            $element = $page->find('css', $selector);
            $xpath = $element->getXpath();
            $wdSession = $context->getSession()->getDriver()->getWebDriverSession();
            $elements = $wdSession->elements('xpath', $xpath);
            $wdSession->moveto(array('element' => $elements[0]->getID()));
            return true;
        });
    }

    /**
     * @Given /^I mouse over the element matching \'([^\']*)\'$/
     */
    public function iMouseOverTheElementMatching($selector)
    {
      $this->spin(function($context) use ($selector) {
          $page = $context->getSession()->getPage();
          $element = $page->find('css', $selector);
          $xpath = $element->getXpath();
          $wdSession = $context->getSession()->getDriver()->getWebDriverSession();
          $elements = $wdSession->elements('xpath', $xpath);
          $wdSession->moveto(array('element' => $elements[0]->getID()));
          return true;
      });
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
    * @When /^I click ad coordinates$/
    */
    public function iClickAdCoordinates()
    {
      //$session->moveto(array('xoffset' => 3, 'yoffset' => 300));
      //$this->getSession()->click();
    }

    /**
    * @When /^I authenticate as "([^"]*)" using "([^"]*)"$/
    */
    public function iAuthenticateAs($email, $password)
    {
      //$this->visit('https://help-stage.adcade.com/');
      //$this->fillField('email', $email);
      //$this->fillField('password', $password);
      //$this->pressButton('Sign In');
    }

    /**
    * @When /^I confirm the popup$/
    */
    public function confirmPopup()
    {
      $this->getMainContext()->getSession()->getDriver()->getWebDriverSession()->accept_alert();
    }
    /**
    * @when /^(?:|I )cancel the popup$/
    */
    public function cancelPopup()
    {
      $this->getMainContext()->getSession()->getDriver()->getWebDriverSession()->dismiss_alert();
    }

    /**
    * @When /^I should see "([^"]*)" in popup$/
    *
    * @param string $message The message.
    */
    public function assertPopupMessage($message)
    {
      $alertText = $this->getMainContext()->getSession()->getDriver()->getWebDriverSession()->getAlert_text();
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
      $this->getMainContext()->getSession()->getDriver()->getWebDriverSession()->postAlert_text($message);
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
      $el = $page->find('named', array($type, "'$locator'"));
      assertNotNull($el, sprintf('%s element not found', $locator));
      $id = $el->getAttribute('id');
      if(empty($id)) {
        throw new \InvalidArgumentException('Element requires an "id" attribute');
      }
      $js = sprintf("document.getElementById('%s').scrollIntoView(true);", $id);
      $this->getSession()->executeScript($js);
    }
    /**
    * Scroll to a certain element by CSS selector.
    * Requires an "id" attribute to uniquely identify the element in the document.
    *
    * Example: Given I scroll to the ".css_element" element
    *
    * @Given /^I scroll to the "(?P<locator>(?:[^"]|\\")*)" element$/
    */
    public function iScrollToElement($locator) {
      $el = $this->getSession()->getPage()->find('css', $locator);
      assertNotNull($el, sprintf('The element "%s" is not found', $locator));
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

    /*CAMPAIGN UNIQUE*/

    /**
    * @Given /^I have my POST header$/
    */
    public function iHaveMyPostHeader()
    {
      $this->getSession()->setRequestHeader('Referer', 'http://adcade.com/demo/cara/staple/calculator/300x600_inpage/index.html');
      $this->getSession()->setRequestHeader('Content-Type', 'application/json');
      $this->getSession()->setRequestHeader('Origin', 'http://adcade.com');
      $this->getSession()->setRequestHeader('Host', 'ad-stage.adcade.com');
      $this->getSession()->setRequestHeader('Content-Type', 'multipart/form-data');
      $this->getSession()->setRequestHeader('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.99 Safari/537.36');
    }

    /*HELP CENTER UNIQUE*/

    /**
     * @Given /^I am on help center$/
     */
    public function iAmOnHelpCenter()
    {
      $this->visit('https://help-stage.adcade.com/');
    }

    /**
     * @Given /^I am on help center feedback$/
     */
    public function iAmOnHelpCenterFeedback()
    {
      $this->visit('https://help-stage.adcade.com/feedback');
    }

    /**
     * @Then /^I should be on help center$/
     */
    public function iShouldBeOnHelpCenter($page)
    {
      $this->driver
          ->expects($this->once())
          ->method('getCurrentUrl')
          ->will($this->returnValue($ret = 'https://help-stage.adcade.com/'));

      $this->assertEquals($ret, $this->session->getCurrentUrl());
    }

    /**
    * @Given /^I am authenticated on help center as "([^"]*)" using "([^"]*)"$/
    */
    public function iAmAuthenticatedAs($username, $password) {
      $this->visit('https://help-stage.adcade.com/');
      $this->fillField('username', $username);
      $this->fillField('password', $password);
      $this->pressButton('login-submit');
      $this->visit('https://help-stage.adcade.com/keystone/signin');
      $this->fillField('email', $username);
      $this->fillField('password', $password);
      $this->pressButton('Sign In');
    }

    /**
    * @Given /^I should see add filter elements$/
    */
    public function iShouldSeeAddFilterElements()
    {
      $this->assertSession()->pageTextContains('contains', 'exact match', 'invert', 'Name');
    }

    //HEADER AND FOOTER SPECIFIC

    /**
    * @Given /^I should see help center header and footer components$/
    */
    public function iShouldSeeHelpCenterHeaderAndFooterComponents()
    {
      $this->assertSession()->pageTextContains('Help Center', 'Visual Editor', 'Dashboard', 'AdScript', 'Resource Center', '© 2015 Adcade Help Center', ' Feedback', 'Powered by', 'Adcade');
    }

    /**
    * @Given /^I should see Keystone header and footer components$/
    */
    public function iShouldSeeKeystoneHeaderAndFooterComponents()
    {
      $this->assertSession()->pageTextContains('Keystone', 'Adscript', 'Tutorials', 'Resources', 'Users', 'Sign Out', 'Keystone Powered by', 'Signed in as', 'Admin User');
    }

    //TYPES SPECIFIC

    /**
    * @Given /^I should see create type view elements$/
    */
    public function iShouldSeeCreateTypeViewElements()
    {
      $this->assertSession()->pageTextContains('New Type', 'cancel', 'Create');
    }

    /**
    * @Given /^I should see edit type view elements$/
    */
    public function iShouldSeeEditTypeViewElements()
    {
      $this->assertSession()->pageTextContains('Save', 'reset changes', 'delete type', 'Types', 'Users', 'New Type');
    }

    /**
    * @Given /^I should see filter type view elements$/
    */
    public function iShouldSeeFilterTypeViewElements()
    {
      $this->assertSession()->pageTextContains('Name');
    }

    //SHAPES SPECIFIC

    /**
    * @Given /^I should see create shape view elements$/
    */
    public function iShouldSeeCreateShapeViewElements()
    {
      $this->assertSession()->pageTextContains('Save','reset changes', 'delete shape', 'Types', 'Users', 'New Shape');
    }

    /**
    * @Given /^I should see filter shape view elements$/
    */
    public function iShouldSeeFilterShapeViewElements()
    {
      $this->assertSession()->pageTextContains('Title', 'State', 'Content Description', 'Type');
    }

    //PROPERTY SPECIFIC

    /**
    * @Given /^I should see create property view elements$/
    */
    public function iShouldSeeCreatePropertyViewElements()
    {
      $this->assertSession()->pageTextContains('Save', 'reset changes', 'delete property', 'Types', 'Users', 'New Property');
    }

    /**
    * @Given /^I should see filter property view elements$/
    */
    public function iShouldSeeFilterPropertyViewElements()
    {
      $this->assertSession()->pageTextContains('Title', 'State', 'Type');
    }

    /**
    * @Given /^I should see create method view elements$/
    */
    public function iShouldSeeCreateMethodViewElements()
    {
      $this->assertSession()->pageTextContains('Save');
      $this->assertSession()->pageTextContains('reset changes');
      $this->assertSession()->pageTextContains('delete method');
      $this->assertSession()->pageTextContains('Types');
      $this->assertSession()->pageTextContains('Users');
      $this->assertSession()->pageTextContains('New Method');
    }

    /**
    * @Given /^I should see create utility view elements$/
    */
    public function iShouldSeeCreateUtilityViewElements()
    {
      $this->assertSession()->pageTextContains('Save');
      $this->assertSession()->pageTextContains('reset changes');
      $this->assertSession()->pageTextContains('delete utility');
      $this->assertSession()->pageTextContains('Types');
      $this->assertSession()->pageTextContains('Users');
      $this->assertSession()->pageTextContains('New Utility');
    }

    /**
     * @Given /^I should see tutorial elements$/
     */
    public function iShouldSeeTutorialElements()
    {
      $this->assertSession()->pageTextContains('Sections');
      $this->assertSession()->pageTextContains('Pages');
    }

    /**
     * @Given /^I should see tutorial section editing elements$/
     */
    public function iShouldSeeTutorialSectionEditingElements()
    {
      $this->assertSession()->pageTextContains('About');
      $this->assertSession()->pageTextContains('key:');
      $this->assertSession()->pageTextContains('New Section');
      $this->assertSession()->pageTextContains('Sections');
      $this->assertSession()->pageTextContains('Save');
      $this->assertSession()->pageTextContains('reset changes');
      $this->assertSession()->pageTextContains('delete section');
    }

    /**
     * @Given /^I should see tutorial page editing elements$/
     */
    public function iShouldSeeTutorialPageEditingElements()
    {
      $this->assertSession()->pageTextContains('State');
      $this->assertSession()->pageTextContains('Author');
      $this->assertSession()->pageTextContains('About');
      $this->assertSession()->pageTextContains('Section');
      $this->assertSession()->pageTextContains('Content Description');
      $this->assertSession()->pageTextContains('slug:');
      $this->assertSession()->pageTextContains('New Page');
      $this->assertSession()->pageTextContains('Pages');
      $this->assertSession()->pageTextContains('Save');
      $this->assertSession()->pageTextContains('reset changes');
      $this->assertSession()->pageTextContains('delete page');
    }

    /**
     * @Given /^I should see download elements$/
     */
    public function iShouldSeeDownloadElements()
    {
      $this->assertSession()->pageTextContains('Downloads');
      $this->assertSession()->pageTextContains('Download Filters');
      $this->assertSession()->pageTextContains('Editor Downloads');

    }

    /**
     * @Given /^I should see download page editing elements$/
     */
    public function iShouldSeeDownloadPageEditingElements()
    {
      $this->assertSession()->pageTextContains('Type');
      $this->assertSession()->pageTextContains('Filter');
      $this->assertSession()->pageTextContains('Image');
      $this->assertSession()->pageTextContains('Downloadable');
      $this->assertSession()->pageTextContains('slug:');
      $this->assertSession()->pageTextContains('Downloads');
      $this->assertSession()->pageTextContains('New Download');
      $this->assertSession()->pageTextContains('Save');
      $this->assertSession()->pageTextContains('reset changes');
      $this->assertSession()->pageTextContains('delete download');
    }


}
