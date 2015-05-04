<?php
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Testwork\Hook\Scope\BeforeSuiteScope;
use Behat\Behat\Hook\Scope\AfterScenarioScope;

/**
 * Class FeatureContext
 */
class FeatureContext implements Context, SnippetAcceptingContext
{
    /*FEATURE CONTEXT*/
    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     *
     */
    public function __construct()
    {
        //todo
    }

    /**
     * @BeforeSuite
     */
    public static function prepare(BeforeSuiteScope $scope)
    {
        // prepare system for test suite
        // before it runs
    }

    /**
     * @AfterScenario @database
     */
    public function cleanDB(AfterScenarioScope $scope)
    {

    }

    /**
     * @BeforeFeature
     */
    public static function setupFeature(FeatureEvent $event)
    {

    }

    /**
     * @AfterFeature
     */
    public static function teardownFeature(FeatureEvent $event)
    {

    }

    # TODO:
    // 1. Connect to its own Jenkins CI instance
    // 2. Dockerize with Robo
    // 3. Further abstract XY Context in to reusable functions in XYContext

}