<?php
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;

/**
 * Defines application features from the feature specific context.
 */

 class FeatureContext implements Context, SnippetAcceptingContext
{
  /*FEATURE CONTEXT*/
  /**
   * Initializes context.
   * Every scenario gets it's own context object.
   *
   */
   public function __construct($baseUrl)
   {
     $this->baseUrl = $baseUrl;
   }
}
