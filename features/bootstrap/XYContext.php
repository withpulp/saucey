<?php
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;

/**
* Defines application features from the WEB context.
*/

class XYContext extends PHPUnit_Framework_TestCase implements Context, SnippetAcceptingContext
{
  /**
  * @var \RemoteWebDriver
  */
  protected $webDriver;

  public function setUp()
  {
      $capabilities = array(\WebDriverCapabilityType::BROWSER_NAME => 'firefox');
      $this->webDriver = RemoteWebDriver::create('http://localhost:4444/wd/hub', $capabilities);
  }

  protected $url = 'http://demo.adcade.com/refinery29/banana_republic/the_new_br/marquee/';

  public function testBanana()
  {
      $this->webDriver->get($this->url);
      // checking that page title contains word 'GitHub'
      $this->assertContains('2015 Levis hunit', $this->webDriver->getTitle());
  }


  /**
  * @param WebDriverCoordinates $where
  * @param int $x_offset
  * @param int $y_offset
  * @return WebDriverMouse
  */
  public function moveToThenClick()
  {
      $this->mouseMove($x_offset = 400, $y_offset = 50);
      $this->click($x_offset = 400, $y_offset = 50);
  }

  public function tearDown()
  {
      $this->webDriver->close();
  }

}
