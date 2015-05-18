<?php

use Behat\Behat\Tester\Exception\PendingException,
    Behat\Behat\Context\Context,
    Behat\Behat\Context\SnippetAcceptingContext,
    Behat\Testwork\Hook\Scope\BeforeSuiteScope,
    Behat\MinkExtension\Context\MinkContext,
    Behat\Behat\Hook\Scope\AfterScenarioScope;

/**
 * Class FeatureContext
 */
class FeatureContext extends MinkContext implements Context, SnippetAcceptingContext
{
    /*FEATURE CONTEXT*/
    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     *
     */
    public function __construct()
    {

    }

    public static function getAcceptedSnippetType()
    {
        return 'regex';
    }

    /**
     * @BeforeSuite
     */
    public static function prepare(BeforeSuiteScope $scope)
    {
    }

    /**
     * @AfterScenario @database
     */
    public function cleanDB(AfterScenarioScope $scope)
    {

    }


}