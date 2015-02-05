Feature: I want to make sure this test suite is up and running

  As a tester
  I want to make sure this test suite is up and running
  So that I can automate continuous integration and regression tests

    @javascript @check
    Scenario: Check against google.com and search
      Given I am on "http://google.com"
      Then the response should contain "Google"
      And I should see "Google Search"
      When I fill in "q" with "Adcade"
      And I wait for 5 seconds
      Then I should see "Adcade"
