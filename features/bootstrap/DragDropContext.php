<?php
use Behat\Behat\Context\BehatContext;
use Behat\Behat\Exception\PendingException;
use Behat\Mink\Mink;
use Behat\MinkExtension\Context\MinkAwareInterface;
class DragAndDropContext extends BehatContext implements MinkAwareInterface
{
    /**
     * @var \Behat\Mink\Mink
     */
    protected $mink;
    protected $minkParameters;
    /**
     * @When /^I drag "([^"]*)" "([^"]*)" pixels to the right$/
     */
    public function iDragPixelsToTheRight($element, $pixels)
    {
        $this->dragByPixels($element, $pixels, 0);
    }
    /**
     * @When /^I drag "([^"]*)" "([^"]*)" pixels to the left$/
     */
    public function iDragPixelsToTheLeft($element, $pixels)
    {
        $this->dragByPixels($element, -$pixels, 0);
    }
    /**
     * @When /^I drag "([^"]*)" "([^"]*)" pixels up$/
     */
    public function iDragPixelsUp($element, $pixels)
    {
        $this->dragByPixels($element, 0, -$pixels);
    }
    /**
     * @When /^I drag "([^"]*)" "([^"]*)" pixels down$/
     */
    public function iDragPixelsDown($element, $pixels)
    {
        $this->dragByPixels($element, 0, $pixels);
    }
    public function dragByPixels($selector, $pixelsX, $pixelsY)
    {
        $session = $this->mink->getSession()->getDriver()->getWebDriverSession();
        $el = $session->element('css selector', $selector);
        $session->moveto(['element' => $el->getID(), 'xoffset' => 2, 'yoffset' => 2]);
        $session->buttondown("");
        $session->moveto(['element' => null, 'xoffset' => (int) $pixelsX, 'yoffset' => (int) $pixelsY]);
        $session->buttonup("");
        usleep(50000);
    }
    /**
     * Sets Mink instance.
     *
     * @param Mink $mink Mink session manager
     */
    public function setMink(Mink $mink)
    {
        $this->mink = $mink;
    }
    /**
     * Sets parameters provided for Mink.
     *
     * @param array $parameters
     */
    public function setMinkParameters(array $parameters)
    {
        $this->minkParameters = $parameters;
    }
}
