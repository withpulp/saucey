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

}