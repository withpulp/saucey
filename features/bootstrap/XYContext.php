<?php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;

use Robo;

/**
* Defines application features from the this kick-ass context.
*/

class XYContext extends PHPUnit_Framework_TestCase implements Context, SnippetAcceptingContext
{
    public $aut;
    public $run;


    /**
     * @param $aut
     * @param $run
     */
    public function __construct($aut, $run)
    {
        $this->aut = $aut;
        $this->run = $run;
    }


}

class RoboContext extends \Robo\Tasks
{
    public function iStartTheAppInTheBackground()
    {
        /**
         * @When I start the app in the background
         * @param string $run the system call to make
         */

        // starts PHP server in background
        $this->taskPhpServer(8000)
            ->background()
            ->dir('../../games')
            ->run();

        // launches Selenium server
        $this->taskExec('java -jar ' . $pathToSelenium)
            ->background()
            ->run();

        // runs PHPUnit tests
        $this->taskPHPUnit()
            ->run();
    }
}