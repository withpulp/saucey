Feature: Cool ass functionality

  As a saucey developer
  I want to showcase the big bang of saucey
  So that I can automate continuous integration and regression tests using it

  @saucey @javascript @game @play
  Scenario: Play the app
    Given I set my browser window size to MacBook Standard
    And I am on "http://demo.adcade.com/demo/yahoo/testtags/160x600_expandable/index.html"
    And I tap "80" x "420" coordinates
    And I drag "300" x "420" coordinates
    And I drag "420" x "420" coordinates
    And I drag "420" x "300" coordinates
    And I drag "300" x "420" coordinates
    And I release "80" x "420" coordinates

  @saucey @javascript @game @metrics
  Scenario: Play the app
    Given I set my browser window size to MacBook Standard
    And I am on "http://127.0.0.1:7890/client/#anonymous"
    And I click on the element with xpath '//*[@id="toolbar"]/button[2]/div[1]'
    And I wait for 3 seconds
    Then I should see "Computed Style"
    When I click on the element with xpath '//*[@id="toolbar"]/button[4]/div[1]'
    And I wait for 3 seconds
    Then I should see "Name"

