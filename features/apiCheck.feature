Feature: I want to make sure api features are up and running

  As a tester
  I want to make sure api features are up and running
  So that I can automate continuous integration and regression tests using it

    @javascript @check @apiCheck
    Scenario: Make and validate request
      Given I request "GET http://testweb.pw"
