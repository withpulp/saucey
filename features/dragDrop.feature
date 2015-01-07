Feature: I want to drag and drop an element

  As a tester
  I want to drag and drop an element
  So that I can automate continous integration and regression tests

    @javascript @regression @smoke @dragDrop @testTags
    Scenario: Metric Requests for Staples Accelerator
      Given I am on "http://adcade.com/demo/yahoo/testtags/160x600_expandable/index.html"
      Then the response should contain "YAHOO"
      When I click and hold coordinates "x","y"
      And I drag "x","y" down and right "x","y"
