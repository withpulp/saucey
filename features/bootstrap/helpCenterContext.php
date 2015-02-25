<?php
use Behat\MinkExtension\Context\MinkContext;

/**
 * Features context.
 */
class HelpCenterContext extends MinkContext
{

    /*HELP CENTER UNIQUE*/

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
     * @Given /^I am on help center$/
     */
    public function iAmOnHelpCenter()
    {
      $this->visit('https://help-stage.adcade.com');
    }

    /**
     * @Given /^I am on help center feedback$/
     */
    public function iAmOnHelpCenterFeedback()
    {
      $this->visit('https://help-stage.adcade.com/feedback');
    }

    /**
     * @Given /^I am on help center keystone$/
     */
    public function iAmOnHelpCenterKeystone()
    {
      $this->visit('https://help-stage.adcade.com/keystone');
    }


    /**
     * @Then /^I should be on help center$/
     */
    public function iShouldBeOnHelpCenter($page)
    {
      $this->driver
          ->expects($this->once())
          ->method('getCurrentUrl')
          ->will($this->returnValue($ret = 'https://help-stage.adcade.com'));

      $this->assertEquals($ret, $this->session->getCurrentUrl());
    }

    /**
    * @Given /^I am authenticated on help center as "([^"]*)" using "([^"]*)"$/
    */
    public function iAmAuthenticatedAs($username, $password) {
      $this->visit('https://help-stage.adcade.com');
      $this->fillField('username', $username);
      $this->fillField('password', $password);
      $this->pressButton('login-submit');
      $this->visit('https://help-stage.adcade.com/keystone');
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

    //METHOD SPECIFIC

    /**
    * @Given /^I should see create method view elements$/
    */
    public function iShouldSeeCreateMethodViewElements()
    {
      $this->assertSession()->pageTextContains('Save', 'reset changes', 'delete method', 'Types', 'Users', 'New Method');
    }

    /**
    * @Given /^I should see filter method view elements$/
    */
    public function iShouldSeeFilterMethodViewElements()
    {
      $this->assertSession()->pageTextContains('Title', 'State', 'Type');
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
