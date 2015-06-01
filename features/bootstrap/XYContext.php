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

use Symfony\Component\Finder\Finder;

/**
* Defines application features from the this kick-ass context.
*/

class XYContext implements Context, SnippetAcceptingContext
{
    private $aut;

    /**
     * @param $aut
     */
    public function __construct($aut)
    {
        $this->aut = $aut;
    }

    /**
     * Clicks or taps based on x,y coordinates
     * Example: When I tap "10" x "10" coordinates
     * Example: And I tap "10" x "10" coordinates
     *
     * @Given I tap :x x :y coordinates
     * @param $x
     * @param $y
     */
    public function iTapXCoordinates($x, $y)
    {
        exec('./bin/cliclick c:"'.$x.'","'.$y.'" w:1000');
    }

    /**
     * Initiates drag based on x,y coordinates
     * Example: When I initiate drag at "10" x "10" coordinates
     * Example: And I initiate drag at "10" x "10" coordinates
     *
     * @Given I initiate drag at :x x :y coordinates
     * @param $x
     * @param $y
     */
    public function iDragXCoordinates($x, $y)
    {
        exec('./bin/cliclick dd:"'.$x.'","'.$y.'" w:1000');
    }

    /**
     * Releases drag based on x,y coordinates
     * Example: When I release drag at "10" x "10" coordinates
     * Example: And I release drag at "10" x "10" coordinates
     *
     * @Given I release drag at :x x :y coordinates
     * @param $x
     * @param $y
     */
    public function iReleaseXCoordinates($x, $y)
    {
        exec('./bin/cliclick du:"'.$x.'","'.$y.'" w:1000');
    }

    /**
     * Moves mouse based on x,y coordinates
     * Example: When I move to "10" x "10" coordinates
     * Example: And I move to "10" x "10" coordinates
     *
     * @When I move to :x x :y coordinates
     * @param $x
     * @param $y
     */
    public function iMoveToXCoordinates($x, $y)
    {
        exec('./bin/cliclick m:"'.$x.'","'.$y.'" w:1000');
    }

    /**
     * Moves mouse along x axis based on x, y1 & y2 coordinates
     * Example: When I move along x axis "10" from y "10" to "20"
     * Example: And I move along x axis "10" from y "10" to "20"
     *
     * @Given I move along x axis :x from y :y1 to :y2
     * @param $x
     * @param $y1
     * @param $y2
     */
    public function iMoveAlongXAxisFromYTo($x, $y1, $y2)
    {
        exec('./bin/cliclick m:"'.$x.'","'.$y1.'" w:1000 && ./bin/cliclick m:"'.$x.'","'.$y2.'" w:1000');
    }

    /**
     * Moves mouse along y axis based on y, x1 & x2 coordinates
     * Example: When I move along y axis "10" from x "10" to "20"
     * Example: And I move along y axis "10" from x "10" to "20"
     *
     * @Given I move along y axis :y from x :x1 to :x2
     * @param $y
     * @param $x1
     * @param $x2
     */
    public function iMoveAlongYAxisFromXTo($y, $x1, $x2)
    {
        exec('./bin/cliclick m:"'.$y.'","'.$x1.'" w:1000 && ./bin/cliclick m:"'.$y.'","'.$x2.'" w:1000');
    }

    /**
     * Initiates drag, then drags from x1,y1 to x2,y2, then releases
     * Example: When I drag from "100,100" to "200,200"
     * Example: And I drag from "100,100" to "200,200"
     *
     * @Given I drag from :xy1 to :xy2
     * @param $xy1
     * @param $xy2
     */
    public function iDragFromTo($xy1, $xy2)
    {
        exec('./bin/cliclick dd:"'.$xy1.'" w:1000 && ./bin/cliclick m:"'.$xy2.'" w:1000 && ./bin/cliclick du:"'.$xy2.'" w:1000');
    }

    /**
     * Moves from x1,y1 to x2,y2
     * Example: When I move from "100,100" to "200,200"
     * Example: And I move from "100,100" to "200,200"
     *
     * @Given I move from :xy1 to :xy2
     * @param $xy1
     * @param $xy2
     */
    public function iMoveFromTo($xy1, $xy2)
    {
        exec('./bin/cliclick m:"'.$xy1.'" w:1000 && ./bin/cliclick m:"'.$xy2.'" w:1000');
    }

}