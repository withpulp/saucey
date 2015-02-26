<?php
// features/bootstrap/RestContext.php
use Behat\Behat\Context\BehatContext;
use Symfony\Component\Yaml\Yaml;

class RestContext extends BehatContext
{

    private $_restObject        = null;
    private $_restObjectType    = null;
    private $_restObjectMethod  = 'get';
    private $_client            = null;
    private $_response          = null;
    private $_requestUrl        = null;
    private $_parameters			= array();

    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     */
    public function __construct(array $parameters)
    {
        // Initialize your context here

        $this->getMainContext()->_restObject  = new stdClass();
        $this->getMainContext()->_client      = new Guzzle\Service\Client();
        $this->getMainContext()->_parameters = $parameters;
    }

    public function getParameter($name)
    {
      if (count($this->getMainContext()->_parameters) === 0) {


            throw new \Exception('Parameters not loaded!');
      } else {

            $parameters = $this->getMainContext()->_parameters;
            return (isset($parameters[$name])) ? $parameters[$name] : null;
      }
    }

     /**
     * @Given /^that I want to make a new "([^"]*)"$/
     */
    public function thatIWantToMakeANew($objectType)
    {
        $this->getMainContext()->_restObjectType   = ucwords(strtolower($objectType));
        $this->getMainContext()->_restObjectMethod = 'post';
    }

     /**
     * @Given /^that I want to find a "([^"]*)"$/
     */
    public function thatIWantToFindA($objectType)
    {
        $this->getMainContext()->_restObjectType   = ucwords(strtolower($objectType));
        $this->getMainContext()->_restObjectMethod = 'get';
    }

    /**
     * @Given /^that I want to delete a "([^"]*)"$/
     */
    public function thatIWantToDeleteA($objectType)
    {
        $this->getMainContext()->_restObjectType   = ucwords(strtolower($objectType));
        $this->getMainContext()->_restObjectMethod = 'delete';
    }

    /**
     * @Given /^that its "([^"]*)" is "([^"]*)"$/
     */
    public function thatTheItsIs($propertyName, $propertyValue)
    {
        $this->getMainContext()->_restObject->$propertyName = $propertyValue;
    }

    /**
     * @When /^I request "([^"]*)"$/
     */
    public function iRequest($pageUrl)
    {
        $baseUrl 			= $this->getMainContext()->getParameter('base_url');
        $this->getMainContext()->_requestUrl 	= $baseUrl.$pageUrl;

        switch (strtoupper($this->getMainContext()->_restObjectMethod)) {
            case 'GET':
                $response = $this->getMainContext()->_client
                    ->get($this->getMainContext()->_requestUrl.'?'.http_build_query((array)$this->getMainContext()->_restObject))
                    ->send();
                break;
            case 'POST':
                $postFields = (array)$this->getMainContext()->_restObject;
                $response = $this->getMainContext()->_client
                    ->post($this->getMainContext()->_requestUrl,null,$postFields)
                    ->send();
                break;
            case 'DELETE':
              $response = $this->getMainContext()->_client
                    ->delete($this->getMainContext()->_requestUrl.'?'.http_build_query((array)$this->getMainContext()->_restObject))
                    ->send();
              break;
        }
        $this->getMainContext()->_response = $response;
    }

    /**
     * @Then /^the response is JSON$/
     */
    public function theResponseIsJson()
    {
        $data = json_decode($this->getMainContext()->_response->getBody(true));

        if (empty($data)) {
            throw new Exception("Response was not JSON\n" . $this->getMainContext()->_response);
        }
    }

    /**
     * @Given /^the response has a "([^"]*)" property$/
     */
    public function theResponseHasAProperty($propertyName)
    {
        $data = json_decode($this->getMainContext()->_response->getBody(true));

        if (!empty($data)) {
            if (!isset($data->$propertyName)) {
                throw new Exception("Property '".$propertyName."' is not set!\n");
            }
        } else {
            throw new Exception("Response was not JSON\n" . $this->getMainContext()->_response->getBody(true));
        }
    }

    /**
     * @Then /^the "([^"]*)" property equals "([^"]*)"$/
     */
    public function thePropertyEquals($propertyName, $propertyValue)
    {
        $data = json_decode($this->getMainContext()->_response->getBody(true));

        if (!empty($data)) {
          if (!isset($data->$propertyName)) {
                throw new Exception("Property '".$propertyName."' is not set!\n");
            }
            if ($data->$propertyName !== $propertyValue) {
              throw new \Exception('Property value mismatch! (given: '.$propertyValue.', match: '.$data->$propertyName.')');
            }
        } else {
            throw new Exception("Response was not JSON\n" . $this->getMainContext()->_response->getBody(true));
        }
    }

    /**
     * @Given /^the type of the "([^"]*)" property is ([^"]*)$/
     */
    public function theTypeOfThePropertyIsNumeric($propertyName,$typeString)
    {
        $data = json_decode($this->getMainContext()->_response->getBody(true));

        if (!empty($data)) {
            if (!isset($data->$propertyName)) {
                throw new Exception("Property '".$propertyName."' is not set!\n");
            }
            // check our type
            switch (strtolower($typeString)) {
                case 'numeric':
                    if (!is_numeric($data->$propertyName)) {
                        throw new Exception("Property '".$propertyName."' is not of the correct type: ".$theTypeOfThePropertyIsNumeric."!\n");
                    }
                    break;
            }

        } else {
            throw new Exception("Response was not JSON\n" . $this->getMainContext()->_response->getBody(true));
        }
    }

    /**
     * @Then /^the response status code should be (\d+)$/
     */
    public function theResponseStatusCodeShouldBe($httpStatus)
    {
      if ((string)$this->getMainContext()->getStatusCode() !== $httpStatus) {
        throw new \Exception('HTTP code does not match '.$httpStatus.
          ' (actual: '.$this->getMainContext()->getStatusCode().')');
      }
    }


     /**
     * @Then /^echo last response$/
     */
    public function echoLastResponse()
    {
        $this->getMainContext()->printDebug(
            $this->getMainContext()->_requestUrl."\n\n".
            $this->getMainContext()->_response
        );
    }
}
