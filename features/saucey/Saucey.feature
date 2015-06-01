Feature: Testing browser functionality

  As a saucey developer
  I want to showcase the saucey functionality
  So that I can automate continuous integration and regression tests using it

  @saucey @javascript @browser
  Scenario: Test some cool browser functionality
    Given I am on url composed by:
     | parameters |
     | #epoch-workflow |
    And I set my browser window size to "2800" x "1800"
    And I wait 3 seconds until I see "Build Better HTML5 Ads Faster"
    Then I should see more than 2 "div" in the 1st "body"
    And I should see less than 80 "div" in the 1st "body"
    And I should see 78 "div" in the 1st "body"
    When I click on the 2nd "ul li a" element
    Then I should see "For Designers and Developers"
    When I follow "Sign Up Now!"
    And I wait until I see "Epoch"
    And I switch to iframe "prefinery_signup1"
    And I fill in "tester_profile_email" with "sajjad@adcade.com"
    And I switch to main frame
    Then I should be on "https://www.adcade.com/#epoch-features"

  @saucey @javascript @browser @disabledButtons @enabledButtons
  Scenario: Test some cool browser functionality, specifically button states
    Given I am on "http://getbootstrap.com/css/#buttons-disabled"
    Then I should see "Disabled state"
    And the element ".btn .btn-primary .btn-lg" should be disabled
    When I go to "http://getbootstrap.com/css/#buttons"
    Then the element ".btn .btn-default" should be disabled
    And the ".btn" element should be visible
    And the ".btn-not-real" element should not be visible

  @saucey @javascript @browser @epoch
  Scenario: Test some cool browser functionality, specifically epoch
    Given I am on "http://www.epochconverter.com/"
    Then I should see "Epoch & Unix Timestamp Conversion Tools"
    When I fill in "TimeStamp" with the current date
    And I press "Epoch to Human date (with support for milliseconds and microseconds)"
    Then I should see "GMT"
    When I fill in "TimeStamp" with the current date and modifier "+4 days"
    And I press "Epoch to Human date (with support for milliseconds and microseconds)"
    Then I should see "GMT"

  @saucey @javascript @browser @hover @navigation
  Scenario: Test some cool browser functionality, specifically hover
    Given I am on "http://google.com"
    And I hover "input#gbqfbb"
    And I wait 1 second
    Then I should not see "I'm Feeling Lucky"
    When I go to "https://www.google.com/earth/explore/showcase/"
    And I wait 1 second until I see "Google Earth Showcase"
    And I move backward one page
    Then I should be on "http://www.google.com/"
    When I move forward one page
    And I reload the page
    Then I should see "Showcase"

  @saucey @api
  Scenario: Test some cool api functionality
    Given I send a GET request to "http://jsonplaceholder.typicode.com/posts"
    Then the response status code should be 200




