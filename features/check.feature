Feature: I want to make sure this test suite is up and running

  As a tester
  I want to make sure this test suite is up and running
  So that I can automate continuous integration and regression tests

    @javascript @regression @sanity
    Scenario: Check against google.com and search
      Given I am on "http://google.com"
      Then the response should contain "Google"
      And I should see "Google Search"
      When I fill in "q" with "Adcade"
      And I wait for 5 seconds
      Then I should see "Adcade"


#    @javascript @regression @sanity
#    Scenario: Check against google.com and search
#      Given I am on "http://adcade.com/demo/refinery29/testtags/320x50_expandable/index.html"
#      Then the response should contain "Testtags"
#      When I click "x, y" coordinates
#      Then the response should contain "top: 0px;"
