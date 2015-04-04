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

  /**
  * Changes directory to :directory requested.
  *
  * @Given /^I am in a directory "([^"]*)"$/
  */
  public function iAmInADirectory($dir)
  {
      //if (!file_exists($dir)) {
      //    mkdir($dir);
      //}
      chdir($dir);
  }

  /**
  * Runs a command line argument.
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
  *
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
