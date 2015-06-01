<?php

use Behat\Behat\Tester\Exception\PendingException,
    Behat\Behat\Context\Context,
    Behat\MinkExtension\Context\MinkContext,
    Behat\Behat\Context\SnippetAcceptingContext,
    Behat\Testwork\Hook\Scope\BeforeSuiteScope,
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

    /**
     * Wienre: Shifts focus to Network tab
     * Example: When I go to network tab
     * Example: Then I go to network tab
     * Example: And I go to network tab
     *
     * @Then I go to network tab
     */
    public function iGoToNetworkTab($xpath = '//*[@id="toolbar"]/button[4]')
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

    /**
     * Wienre: Shifts focus to Elements tab
     * Example: When I go to elements tab
     * Example: Then I go to elements tab
     * Example: And I go to elements tab
     *
     * @Then I go to elements tab
     */
    public function iGoToElementsTab($xpath = '//*[@id="toolbar"]/button[2]/div[1]')
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

    /**
     * Wienre: Shifts focus to console tab
     * Example: When I go to console tab
     * Example: Then I go to console tab
     * Example: And I go to console tab
     *
     * @Then I go to console tab
     */
    public function iGoToConsoleTab($xpath = '//*[@id="toolbar"]/button[7]/div[2]')
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

    /**
     * Wienre: Shifts focus to Network tab for a given request
     * Example: When I select request 1
     * Example: Then I select request 1
     * Example: And I select request 1
     *
     * @Then I select request :number
     * @param $number
     */
    public function iSelectRequest($number)
    {
        $xpath = "//*[@id='network-container']/div/div[1]/table/tbody/tr[{$number}]/td[1]/div";

        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

    /**
     * Wienre: Shifts focus to Network header tab
     * Example: When I go to network header tab
     * Example: Then I go to network header tab
     * Example: And I go to network header tab
     *
     * @Then I am on the network header tab
     */
    public function iAmOnTheHeaderTab($xpath = '//*[@id="network-views"]/div/div[1]/li[1]')
    {
        $session = $this->getSession(); // get the mink session
        $element = $session->getPage()->find(
            'xpath',
            $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
        ); // runs the actual query and returns the element

        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
        }

        // ok, let's click on it
        $element->click();
    }

}