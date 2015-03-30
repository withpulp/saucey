Feature: I want to make sure api features are up and running

  As a tester
  I want to make sure api features are up and running
  So that I can automate continuous integration and regression tests using it

    @javascript @api
    Scenario: Make and validate request
      Given I make a request to "http://testweb.pw"
      Then the response status code should be "404"
