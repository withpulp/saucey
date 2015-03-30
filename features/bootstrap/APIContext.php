<?php
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;

use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step;

use GuzzleHttp\Client;
use GuzzleHttp\Ring\Client\MockHandler;

/**
 * Defines application features from the API context.
 */

class APIContext implements Behat\Behat\Context\SnippetAcceptingContext
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
   * @Then the response status code should be :code
   */
  public function theResponseStatusCodeShouldBe($code)
  {
    $client = new Client();
    $request = $client->createRequest('GET', 'http://testweb.pw');
    $response = $client->send($request);
    $code = $response->getStatusCode();
    // 200
  }

//  public function iExample($user, $password)
//  {
//      $userName = $this->params['user'];
//  }

}
