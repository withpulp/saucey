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

 class ShellContext implements Context, SnippetAcceptingContext
{
    /**
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
   * @When /^I run "([^"]*)"$/
   */
  public function iRun($command)
  {
      exec($command, $output);
      $this->output = trim(implode("\n", $output));
  }

  /**
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
