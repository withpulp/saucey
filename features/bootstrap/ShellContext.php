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

/**
* Defines application features from the SHELL context.
*/

class ShellContext implements Context, SnippetAcceptingContext
{
  public $basePath;

  /*WEB CONTEXT*/
  /**
  * Initializes context.
  * Every scenario gets it's own context object.
  *
  */
  public function __construct($basePath)
  {
    $this->basePath = $basePath;
  }

  /**
  * Changes directory to :directory requested.
  * Example: Given I am in "/Users/bWayne/secretfiles/batman"
  * Example: And I am in "/Users/bWayne/secretfiles/batman"
  *
  * @Given I am in :dir directory
  */
  public function iAmInDirectory($dir)
  {
    //if (!file_exists($dir)) {
    //    mkdir($dir);
    //}
    chdir($dir);
  }

  /**
  * Runs a command line argument.
  * Example: When I run ".openCaveEntrance"
  * Example: And I run ".openCaveEntrance"
  *
  * @When /^I run "([^"]*)"$/
  */
  public function iRun($command)
  {
      exec($command, $output);
      $this->output = trim(implode("\n", $output));
  }

  /**
  * Asserts against previously run command line argument.
  * Example: Then I should see:
  *          """
  *          Opening cave, master Bruce.
  *          """
  * Example: And I should see:
  *          """
  *          Opening cave, master Bruce.
  *          """
  * @Then I should see:
  */
  public function iShouldSee(PyStringNode $string)
  {
      if ($string->getRaw() !== $this->output) {
          throw new \Exception(
              "Actual output is:\n" . $this->output
          );
      }
  }

}
