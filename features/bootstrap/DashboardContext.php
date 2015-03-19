<?php

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;

use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;

class DashboardContext extends FeatureContext
{
  /**
   * @Given /^I am on dashboard stage$/
   */
  public function iAmOnDashboardStage()
  {
    $this->visit('https://adstack-stage.adcade.com');
  }

  /**
   * @Given /^I am on Profile Settings of dashboard stage$/
   */
  public function iAmOnProfileSettingsOfDashboardStage()
  {
    $this->visit('https://adstack-stage.adcade.com/account/profile');
  }

  /**
   * @Given /^I am on All Organizations of dashboard stage$/
   */
  public function iAmOnAllOrganizationsOfDashboardStage()
  {
    $this->visit('https://adstack-stage.adcade.com/organizations');
  }

  /**
   * @When /^I authenticate as "([^"]*)" using "([^"]*)"$/
   */
  public function iAuthenticateAsUsing($email, $pw)
  {
    $this->fillField('username', $email);
    $this->fillField('password', $pw);
    $this->pressButton('Sign In');
  }

  /**
  * @Then /^I should see dashboard header and footer components with name "([^"]*)"$/
  */
  public function iShouldSeeDashboardHeaderAndFooterComponentsWithName($name)
  {
    $this->assertSession()->pageTextContains('Dashboard');
    $this->assertSession()->pageTextContains('Reporting');
    $this->assertSession()->pageTextContains('Adcade');
    $this->assertSession()->pageTextContains($name);
    $this->assertSession()->pageTextContains('Help');
    $this->assertSession()->pageTextContains('Feedback');
  }

  /**
  * @Then /^I should see dashboard header and footer components$/
  */
  public function iShouldSeeDashboardHeaderAndFooterComponents()
  {
    $this->assertSession()->pageTextContains('Dashboard');
    $this->assertSession()->pageTextContains('Reporting');
    $this->assertSession()->pageTextContains('Adcade');
    $this->assertSession()->pageTextContains('Sylvia');
    $this->assertSession()->pageTextContains('Help');
    $this->assertSession()->pageTextContains('Feedback');
  }

  /**
  * @Then /^I should see copyright and version$/
  */
  public function iShouldSeeCopyright()
  {
    $this->assertSession()->pageTextContains('© 2015 Adcade. All Rights Reserved. 1.1.0');
  }

  /**
  * @Then /^I should see dashboard Profile Settings content with first name "([^"]*)" and last name "([^"]*)"$/
  */
  public function iShouldSeeDashboardProfileSettingsContentWithFirstAndLastName($fname, $lname)
  {
    $this->assertSession()->pageTextContains('Profile Information');
    $this->assertSession()->pageTextContains('First Name');
    $this->assertSession()->pageTextContains($fname);
    $this->assertSession()->pageTextContains('Last Name');
    $this->assertSession()->pageTextContains($lname);
    $this->assertSession()->pageTextContains('Email Address');
    $this->assertSession()->pageTextContains('Phone Number');
    $this->assertSession()->pageTextContains('Company');
    $this->assertSession()->pageTextContains('Job Title');
    $this->assertSession()->pageTextContains('Updat Profile');
    $this->assertSession()->pageTextContains('Cancel');
    $this->assertSession()->pageTextContains('Password Update');
    $this->assertSession()->pageTextContains('Current Password');
    $this->assertSession()->pageTextContains('New Password');
    $this->assertSession()->pageTextContains('Confirm New Password');
    $this->assertSession()->pageTextContains('Update Password');
  }

  /**
  * @Then /^I should see dashboard Profile Settings content$/
  */
  public function iShouldSeeDashboardProfileSettingsContent()
  {
    $this->assertSession()->pageTextContains('Profile Information');
    $this->assertSession()->pageTextContains('First Name');
    $this->assertSession()->pageTextContains('Sylvia');
    $this->assertSession()->pageTextContains('Last Name');
    $this->assertSession()->pageTextContains('Leung');
    $this->assertSession()->pageTextContains('Email Address');
    $this->assertSession()->pageTextContains('Phone Number');
    $this->assertSession()->pageTextContains('Company');
    $this->assertSession()->pageTextContains('Job Title');
    $this->assertSession()->pageTextContains('Updat Profile');
    $this->assertSession()->pageTextContains('Cancel');
    $this->assertSession()->pageTextContains('Password Update');
    $this->assertSession()->pageTextContains('Current Password');
    $this->assertSession()->pageTextContains('New Password');
    $this->assertSession()->pageTextContains('Confirm New Password');
    $this->assertSession()->pageTextContains('Update Password');
  }

  /**
   * @Given /^I enter my current password "([^"]*)" and new password "([^"]*)"$/
   */
  public function iEnterMyCurrentPasswordAndNewPassword($currpw, $newpw)
  {
    $this->fillField('curr-pass', $currpw);
    $this->fillField('new-pass', $newpw);
    $this->fillField('confirm-pass', $newpw);
    $this->pressButton('Change Password');
  }

  /**
   * @When /^I visit drop down link of item "([^"]*)"$/
   */
  public function iVisitDropDownLinkOfItem($item)
  {
      $session = $this->getSession(); // get the mink session
      $element = $session->getPage()->findLink($item);

      if (null === $element) {
        throw new \InvalidArgumentException(sprintf('Could not find item: "%s"', $item));
      }

      $href = $element->getAttribute('href');
      echo sprintf(
          "The URL is '%s'\n", $href
      );

      // errors must not pass silently
      if (null === $href) {
        throw new \InvalidArgumentException(sprintf('Could not find URL of item: "%s"', $item));
      }

      $this->visit($href);
  }

  /**
   * @When /^I enter value "([^"]*)" into csspath field "([^"]*)"$/
   */
  public function iEnterValueIntoCSSPathField($value, $csspath)
  {
    $session = $this->getSession(); // get the mink session
    $element = $session->getPage()->find('css',$csspath);

    if (null === $element) {
      throw new \InvalidArgumentException(sprintf('Could not evaluate CssPath: "%s"', $csspath));
    }

    $element->setValue($value);
  }

  /**
   * @When /^I set browser window size to "([^"]*)" x "([^"]*)"$/
   */
  public function iSetBrowserWindowSizeToX($width, $height) {
    $this->getSession()->getDriver()->resizeWindow((int)$width, (int)$height, 'current');
  }
}
