<?php
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

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

    # TODO:
    // 1. Connect to its own Jenkins CI instance
    // 2. Dockerize with Robo
    // 3. Further abstract XY Context in to reusable functions in XYContext

}