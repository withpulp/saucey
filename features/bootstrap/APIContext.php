<?php
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;

use Behat\GuzzleExtension\Context\GuzzleAwareContext;
use GuzzleHttp\Client;
use GuzzleHttp\Message\ResponseInterface;

/**
 * Defines application features from the API context.
 */

class APIContext implements Behat\Behat\Context\Context
{
  public function __construct()
  {
    //
  }

  /**
   * @Given I make a request to :url
   */
  public function iMakeARequestTo($url)
  {
    $client = new Client();
    $response = $client->get($url);
  }


  /**
   * @Given I make a request to home
   */
  public function iMakeARequestToHome()
  {
    $client = new Client();
    $request = $client->createRequest('GET', 'http://testweb.pw');
    $response = $client->send($request);
  }

  /**
   * @Then the response code should be :code
   */
  public function theResponseCodeShouldBe($code)
  {
    $client = new Client();
    $client->createRequest('GET', 'http://testweb.pw')

  }
//  public function iExample($user, $password)
//  {
//      $userName = $this->params['user'];
//  }

}
