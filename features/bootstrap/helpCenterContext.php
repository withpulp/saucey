<?php
use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;
use GuzzleHttp\Client;

use Behat\Behat\Context\Step;

class HelpCenterContext extends BehatContext
{
    /*HELP CENTER UNIQUE*/

    /**
    * @BeforeFeature [@helpCenter]
    */
    public static function prepare(BeforeFeatureScope $scope)
    {
       //exec('mongo keystone --eval "db.dropDatabase();"');
    }

    /**
     * @AfterScenario @database
     */
    public function cleanDB(AfterScenarioScope $scope)
    {
      //exec('mongo keystone --eval "db.dropDatabase();"');
    }

    /**
     * @Given /^I am on help center$/
     */
    public function iAmOnHelpCenter()
    {
      $this->getMainContext()->getMainContext()->visit('https://help-stage.adcade.com');
    }

    /**
     * @Given /^I am on help center feedback$/
     */
    public function iAmOnHelpCenterFeedback()
    {
      $this->getMainContext()->visit('https://help-stage.adcade.com/feedback');
    }

    /**
     * @Given /^I am on help center keystone$/
     */
    public function iAmOnHelpCenterKeystone()
    {
      $this->getMainContext()->visit('https://help-stage.adcade.com/keystone');
    }


    /**
     * @Then /^I should be on help center$/
     */
    public function iShouldBeOnHelpCenter($page)
    {
      $this->getMainContext()->driver
          ->expects($this->getMainContext()->once())
          ->method('getCurrentUrl')
          ->will($this->getMainContext()->returnValue($ret = 'https://help-stage.adcade.com'));

      $this->getMainContext()->assertEquals($ret, $this->getMainContext()->session->getCurrentUrl());
    }

    /**
    * @Given /^I am authenticated on help center as "([^"]*)" using "([^"]*)"$/
    */
    public function iAmAuthenticatedOnHelpCenterAs($username, $password) {
      $this->getMainContext()->visit('https://help-stage.adcade.com');
      $this->getMainContext()->fillField('username', $username);
      $this->getMainContext()->fillField('password', $password);
      $this->getMainContext()->pressButton('login-submit');
    }

    public function iAmAuthenticatedOnKeystoneAs($username, $password) {
      $this->getMainContext()->visit('https://help-stage.adcade.com/keystone');
      $this->getMainContext()->fillField('email', $username);
      $this->getMainContext()->fillField('password', $password);
      $this->getMainContext()->pressButton('Sign In');
    }

    /**
    * @Given /^I should see add filter elements$/
    */
    public function iShouldSeeAddFilterElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('contains', 'exact match', 'invert', 'Name');
    }

    //HEADER AND FOOTER SPECIFIC

    /**
    * @Given /^I should see help center header and footer components$/
    */
    public function iShouldSeeHelpCenterHeaderAndFooterComponents()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Visual Editor', 'Dashboard', 'AdScript', 'Downloads', '© 2015 Adcade. All Rights Reserved.', ' Feedback');
    }

    /**
    * @Given /^I should see Keystone header and footer components$/
    */
    public function iShouldSeeKeystoneHeaderAndFooterComponents()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Keystone', 'Adscript', 'Tutorials', 'Resources', 'Users', 'Sign Out', 'Keystone Powered by', 'Signed in as', 'Admin User');
    }

    //TYPES SPECIFIC

    /**
    * @Given /^I should see create type view elements$/
    */
    public function iShouldSeeCreateTypeViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('New Type', 'cancel', 'Create');
    }

    /**
    * @Given /^I should see edit type view elements$/
    */
    public function iShouldSeeEditTypeViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Save', 'reset changes', 'delete type', 'Types', 'Users', 'New Type');
    }

    /**
    * @Given /^I should see filter type view elements$/
    */
    public function iShouldSeeFilterTypeViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Name');
    }

    //SHAPES SPECIFIC

    /**
    * @Given /^I should see create shape view elements$/
    */
    public function iShouldSeeCreateShapeViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Save','reset changes', 'delete shape', 'Types', 'Users', 'New Shape');
    }

    /**
    * @Given /^I should see filter shape view elements$/
    */
    public function iShouldSeeFilterShapeViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Title', 'State', 'Content Description', 'Type');
    }

    //PROPERTY SPECIFIC

    /**
    * @Given /^I should see create property view elements$/
    */
    public function iShouldSeeCreatePropertyViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Save', 'reset changes', 'delete property', 'Types', 'Users', 'New Property');
    }

    /**
    * @Given /^I should see filter property view elements$/
    */
    public function iShouldSeeFilterPropertyViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Title', 'State', 'Type');
    }

    //METHOD SPECIFIC

    /**
    * @Given /^I should see create method view elements$/
    */
    public function iShouldSeeCreateMethodViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Save', 'reset changes', 'delete method', 'Types', 'Users', 'New Method');
    }

    /**
    * @Given /^I should see filter method view elements$/
    */
    public function iShouldSeeFilterMethodViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Title', 'State', 'Type');
    }

    /**
    * @Given /^I should see create utility view elements$/
    */
    public function iShouldSeeCreateUtilityViewElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Save');
      $this->getMainContext()->assertSession()->pageTextContains('reset changes');
      $this->getMainContext()->assertSession()->pageTextContains('delete utility');
      $this->getMainContext()->assertSession()->pageTextContains('Types');
      $this->getMainContext()->assertSession()->pageTextContains('Users');
      $this->getMainContext()->assertSession()->pageTextContains('New Utility');
    }

    /**
     * @Given /^I should see tutorial elements$/
     */
    public function iShouldSeeTutorialElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Sections');
      $this->getMainContext()->assertSession()->pageTextContains('Pages');
    }

    /**
     * @Given /^I should see tutorial section editing elements$/
     */
    public function iShouldSeeTutorialSectionEditingElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('About');
      $this->getMainContext()->assertSession()->pageTextContains('key:');
      $this->getMainContext()->assertSession()->pageTextContains('New Section');
      $this->getMainContext()->assertSession()->pageTextContains('Sections');
      $this->getMainContext()->assertSession()->pageTextContains('Save');
      $this->getMainContext()->assertSession()->pageTextContains('reset changes');
      $this->getMainContext()->assertSession()->pageTextContains('delete section');
    }

    /**
     * @Given /^I should see tutorial page editing elements$/
     */
    public function iShouldSeeTutorialPageEditingElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('State');
      $this->getMainContext()->assertSession()->pageTextContains('Author');
      $this->getMainContext()->assertSession()->pageTextContains('About');
      $this->getMainContext()->assertSession()->pageTextContains('Section');
      $this->getMainContext()->assertSession()->pageTextContains('Content Description');
      $this->getMainContext()->assertSession()->pageTextContains('slug:');
      $this->getMainContext()->assertSession()->pageTextContains('New Page');
      $this->getMainContext()->assertSession()->pageTextContains('Pages');
      $this->getMainContext()->assertSession()->pageTextContains('Save');
      $this->getMainContext()->assertSession()->pageTextContains('reset changes');
      $this->getMainContext()->assertSession()->pageTextContains('delete page');
    }

    /**
     * @Given /^I should see download elements$/
     */
    public function iShouldSeeDownloadElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Downloads');
      $this->getMainContext()->assertSession()->pageTextContains('Download Filters');
      $this->getMainContext()->assertSession()->pageTextContains('Editor Downloads');

    }

    /**
     * @Given /^I should see download page editing elements$/
     */
    public function iShouldSeeDownloadPageEditingElements()
    {
      $this->getMainContext()->assertSession()->pageTextContains('Type');
      $this->getMainContext()->assertSession()->pageTextContains('Filter');
      $this->getMainContext()->assertSession()->pageTextContains('Image');
      $this->getMainContext()->assertSession()->pageTextContains('Downloadable');
      $this->getMainContext()->assertSession()->pageTextContains('slug:');
      $this->getMainContext()->assertSession()->pageTextContains('Downloads');
      $this->getMainContext()->assertSession()->pageTextContains('New Download');
      $this->getMainContext()->assertSession()->pageTextContains('Save');
      $this->getMainContext()->assertSession()->pageTextContains('reset changes');
      $this->getMainContext()->assertSession()->pageTextContains('delete download');
    }


}
