<?php
use Symfony\Component\Finder\Finder;

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;

/**
* Defines application features from the this kick-ass context.
*/

class XYContext implements Context, SnippetAcceptingContext
{
    private $aut;
    private $run;

    /**
     * @param $aut
     * @param $run
     */
    public function __construct($aut, $run)
    {
        $this->aut = $aut;
        $this->run = $run;
    }

    /**
     * @Given I tap :x x :y coordinates
     */
    public function iTapXCoordinates($x, $y)
    {
        exec('./bin/cliclick c:"'.$x.'","'.$y.'" w:1000');
    }

    /**
     * @Given I drag :x x :y coordinates
     */
    public function iDragXCoordinates($x, $y)
    {
        exec('./bin/cliclick dd:"'.$x.'","'.$y.'" w:1000');
    }

    /**
     * @Given I release :x x :y coordinates
     */
    public function iReleaseXCoordinates($x, $y)
    {
        exec('./bin/cliclick du:"'.$x.'","'.$y.'" w:1000');
    }

    /**
     * @When I move to :x x :y coordinates
     */
    public function iMoveToXCoordinates($x, $y)
    {
        exec('./bin/cliclick m:"'.$x.'","'.$y.'" w:1000');
    }


}