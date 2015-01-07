<?php
// features/bootstrap/FeatureContext.php testing-rest-api-with-behat/FeatureContext.php
use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;
use GuzzleHttp\Client;


//
// Require 3rd-party libraries here:
//
//   require_once 'PHPUnit/Autoload.php';
//   require_once 'PHPUnit/Framework/Assert/Functions.php';
//
require_once 'RestContext.php';
require_once 'vendor/autoload.php';

/**
* Features context.
*/

class FeatureContext extends Behat\MinkExtension\Context\MinkContext
{

    /**
     * Initializes context.
     * Every scenario gets its own context object.
     *
     * @param   array   $parameters     context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        $this->useContext('api',
            new Behat\CommonContexts\WebApiContext($parameters['base_url'])
        );

        $this->getSubcontext('api')
            ->setPlaceHolder('BASE_URL', rtrim($parameters['base_url'], '/'));
    }

    

}
