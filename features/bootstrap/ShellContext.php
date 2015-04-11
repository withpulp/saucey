<?php
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;


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
