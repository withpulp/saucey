<?php

use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode,
    Behat\MinkExtension\Context\MinkContext,
    Behat\MinkExtension\Context\MinkAwareContext,
    Behat\Behat\Context\Step,
    Behat\Behat\Context\Context,
    Behat\Behat\Context\SnippetAcceptingContext,
    Behat\Behat\Hook\Scope\BeforeScenarioScope,
    Behat\Testwork\Hook\Scope\BeforeSuiteScope,
    Behat\Behat\Hook\Scope\AfterScenarioScope;


class HelpCenterContext extends MinkContext implements Context, SnippetAcceptingContext
{
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
        $this->$driver
            ->expects($this->once())
            ->method('getCurrentUrl')
            ->will($this->returnValue($ret = 'https://help-stage.adcade.com'));

        $this->assertEquals($ret, $this->$session->getCurrentUrl());
    }

    /**
     * @Given /^I am authenticated on help center as "([^"]*)" using "([^"]*)"$/
     */
    public function iAmAuthenticatedOnHelpCenterAs($username, $password) {
        $this->visit('https://help-stage.adcade.com/login');
        $this->fillField('username', $username);
        $this->fillField('password', $password);
        $this->pressButton('login-submit');
    }

    /**
     * @Given /^I am authenticated on keystone as "([^"]*)" using "([^"]*)"$/
     */
    public function iAmAuthenticatedOnKeystoneAs($username, $password) {
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
        $this->assertSession()->pageTextContains('contains');
        $this->assertSession()->pageTextContains('exact match');
        $this->assertSession()->pageTextContains('invert');
        $this->assertSession()->pageTextContains('Name');
    }

    //HEADER AND FOOTER SPECIFIC

    /**
     * @Given /^I should see help center header and footer components$/
     */
    public function iShouldSeeHelpCenterHeaderAndFooterComponents()
    {
        $this->assertSession()->pageTextContains('Help & Feedback');
        $this->assertSession()->pageTextContains('Can\'t find your answers?');
        $this->assertSession()->pageTextContains('We want to know what you think!');
        $this->assertSession()->pageTextContains('We\'re here to help.');
        $this->assertSession()->pageTextContains('© 2015 Adcade. All Rights Reserved.');
        $this->assertSession()->pageTextContains('Epoch');
        $this->assertSession()->pageTextContains('AdScript API');
        $this->assertSession()->pageTextContains('Downloads');

    }

    /**
     * @Given /^I should see Keystone header and footer components$/
     */
    public function iShouldSeeKeystoneHeaderAndFooterComponents()
    {
        $this->assertSession()->pageTextContains('Keystone');
        $this->assertSession()->pageTextContains('Adscript');
        $this->assertSession()->pageTextContains('Tutorials');
        $this->assertSession()->pageTextContains('Downloads');
        $this->assertSession()->pageTextContains('Users');
        $this->assertSession()->pageTextContains('Sign Out');
        $this->assertSession()->pageTextContains('Keystone Powered by');
        $this->assertSession()->pageTextContains('Signed in as');
        $this->assertSession()->pageTextContains('Admin User');
    }

    //TYPES SPECIFIC

    /**
     * @Given /^I should see create type view elements$/
     */
    public function iShouldSeeCreateTypeViewElements()
    {
        $this->assertSession()->pageTextContains('cancel');
        $this->assertSession()->pageTextContains('Create');
    }

    /**
     * @Given /^I should see edit type view elements$/
     */
    public function iShouldSeeEditTypeViewElements()
    {
        $this->assertSession()->pageTextContains('Save');
        $this->assertSession()->pageTextContains('reset changes');
        $this->assertSession()->pageTextContains('delete type');
        $this->assertSession()->pageTextContains('Types');
        $this->assertSession()->pageTextContains('New Type');
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
        $this->assertSession()->pageTextContains('Save');
        $this->assertSession()->pageTextContains('reset changes');
        $this->assertSession()->pageTextContains('delete shape');
        $this->assertSession()->pageTextContains('Shapes');
        $this->assertSession()->pageTextContains('New Shape');
    }

    /**
     * @Given /^I should see edit shape view elements$/
     */
    public function iShouldSeeEditShapeViewElements()
    {
        $this->assertSession()->pageTextContains('Save');
        $this->assertSession()->pageTextContains('reset changes');
        $this->assertSession()->pageTextContains('delete shape');
        $this->assertSession()->pageTextContains('Shapes');
        $this->assertSession()->pageTextContains('New Shape');
    }

    /**
     * @Given /^I should see filter shape view elements$/
     */
    public function iShouldSeeFilterShapeViewElements()
    {
        $this->assertSession()->pageTextContains('Title');
        $this->assertSession()->pageTextContains('State');
        $this->assertSession()->pageTextContains('Shape');
    }

    //PROPERTY SPECIFIC

    /**
     * @Given /^I should see create property view elements$/
     */
    public function iShouldSeeCreatePropertyViewElements()
    {
        $this->assertSession()->pageTextContains('Save');
        $this->assertSession()->pageTextContains('reset changes');
        $this->assertSession()->pageTextContains('delete property');
        $this->assertSession()->pageTextContains('Users');
        $this->assertSession()->pageTextContains('Types');
        $this->assertSession()->pageTextContains('New Property');
    }

    //METHOD SPECIFIC

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
     * @Given /^I should see filter method view elements$/
     */
    public function iShouldSeeFilterMethodViewElements()
    {
        $this->assertSession()->pageTextContains('Title');
        $this->assertSession()->pageTextContains('State');
        $this->assertSession()->pageTextContains('Type');
    }

    //UTILITY SPECIFIC

    /**
     * @Given /^I should see create utility view elements$/
     */
    public function iShouldSeeCreateUtilityViewElements()
    {
        $this->assertSession()->pageTextContains('Save');
        $this->assertSession()->pageTextContains('reset changes');
        $this->assertSession()->pageTextContains('delete utility');
        $this->assertSession()->pageTextContains('Users');
        $this->assertSession()->pageTextContains('New Utility');
    }

    //CHANGELOG SPECIFIC

    /**
     * @Given /^I should see create changelog view elements$/
     */
    public function iShouldSeeCreateChangelogViewElements()
    {
        $this->assertSession()->pageTextContains('Save');
        $this->assertSession()->pageTextContains('reset changes');
        $this->assertSession()->pageTextContains('delete changelog item');
        $this->assertSession()->pageTextContains('State');
        $this->assertSession()->pageTextContains('Versions');
        $this->assertSession()->pageTextContains('Details');
    }

    //VERSIONS SPECIFIC

    /**
     * @Given /^I should see create version view elements$/
     */
    public function iShouldSeeCreateVersionViewElements()
    {
        $this->assertSession()->pageTextContains('Save');
        $this->assertSession()->pageTextContains('reset changes');
        $this->assertSession()->pageTextContains('delete version');
        $this->assertSession()->pageTextContains('State');
        $this->assertSession()->pageTextContains('key');
        $this->assertSession()->pageTextContains('New Version');
    }

    //TUTORIAL SPECIFIC

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
        $this->assertSession()->pageTextContains('About');
        $this->assertSession()->pageTextContains('Section');
        $this->assertSession()->pageTextContains('Content Description');
        $this->assertSession()->pageTextContains('New Page');
        $this->assertSession()->pageTextContains('Pages');
        $this->assertSession()->pageTextContains('Save');
    }

    //DOWNLOAD SPECIFIC

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
        $this->assertSession()->pageTextContains('Downloads');
        $this->assertSession()->pageTextContains('New Download');
        $this->assertSession()->pageTextContains('Save');
        $this->assertSession()->pageTextContains('reset changes');
        $this->assertSession()->pageTextContains('delete download');
    }

    //USERS SPECIFIC

    /**
     * @Given /^I should see create user elements$/
     */
    public function iShouldSeeCreateUserElements()
    {
        $this->assertSession()->pageTextContains('Name');
        $this->assertSession()->pageTextContains('Email');
        $this->assertSession()->pageTextContains('Password');
    }

    /**
     * @Given /^I should see edit user elements$/
     */
    public function iShouldSeeEditUserElements()
    {
        $this->assertSession()->pageTextContains('Name');
        $this->assertSession()->pageTextContains('Email');
        $this->assertSession()->pageTextContains('Password');
        $this->assertSession()->pageTextContains('Save');
        $this->assertSession()->pageTextContains('Can access Keystone');
        $this->assertSession()->pageTextContains('reset changes');
        $this->assertSession()->pageTextContains('delete user');
    }

}
