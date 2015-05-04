Feature: Cool ass functionality

  As a saucey developer
  I want to showcase the big bang of saucey
  So that I can automate continuous integration and regression tests using it

  @saucey @javascript @initial
  Scenario: Initiate app metrics
    Given I am on "http://127.0.0.1:9987/"
    And I wait for 6 seconds
    Then I should see "Hello world!"

  @saucey @javascript @metrics
  Scenario: Look at app metrics
    Given I am on "http://127.0.0.1:7890/client/#anonymous"
    And I wait for 3 seconds
    Then I should see "Elements"
    And I should see "Network"
    And I should see "Console"
    And I go to elements tab
    And I wait for 1 seconds
    Then I should see "Computed Style"
    When I go to console tab
    And I wait for 1 seconds
    Then I should see "All"
    When I go to network tab
    And I wait for 1 seconds
    Then I should see "Name"