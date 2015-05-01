Feature: Cool ass functionality

  As a tester
  I want to run a regression suite against ADSCR-726
  So that I can mark it as PASSED QA or BACK TO DEV

  @javascript @ADSCR_726_Desktop
  Scenario: Testing functionality and assets for campaign
    Given I set my browser window size to MacBook Standard
    And I tap "81" x "43" coordinates
    And I am on "http://adcade.dev/saucey/apps/ads/tnbr_pushdown_marquee/deploy/index.html"
    And I wait for 15 seconds
    When I tap "1320" x "120" coordinates
    And I wait for 5 seconds
    And I tap "1320" x "120" coordinates
    Then the response should contain "2015 Levis"

  @javascript @ADSCR_726_Desktop_Metrics
  Scenario: Click-through and metrics testing for HTTPS requests
    Given I am on "http://adcade.dev:7890/client/#anonymous"
    Then I should see "Elements"
    And I should see "Network"
    And I should see "Console"
    When I go to network tab
    And I wait for 20 seconds
    Then the response should contain "ad-stage.adcade.com"
    When I select request "1"
    And I am on the network header tab
    Then I should see "GET"
    And the response should contain "imp"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select request "2"
    And I am on the network header tab
    Then I should see "POST"
    And the response should contain "std.auto.expansion"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select request "3"
    And I am on the network header tab
    Then I should see "POST"
    And the response should contain "std.auto.video.mute.video"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select request "4"
    And I am on the network header tab
    Then I should see "POST"
    And the response should contain "std.auto.video.start.video"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select request "5"
    And I am on the network header tab
    Then I should see "POST"
    And the response should contain "std.auto.video.1st_quartile.video"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select request "6"
    And I am on the network header tab
    Then I should see "POST"
    And the response should contain "std.auto.collapse"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select request "7"
    And I am on the network header tab
    Then I should see "POST"
    And the response should contain "tdn"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select request "8"
    And I am on the network header tab
    Then I should see "POST"
    And the response should contain "std.interact.expansion"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select request "9"
    And I am on the network header tab
    Then I should see "POST"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"

  @javascript @ADSCR_726_Desktop_Compatibility
  Scenario: Compatibility tests for the campaign
#    Given I am on ""
#    Then the response should contain ""
#    When I am on ""
#    Then the response should contain ""

  @javascript @IE_Backup_ADSCR_726_Desktop
  Scenario: IE 8 Back up tests for the campaign
#    Given I am on ""
#    Then the response should contain ""
#    When I am on ""
#    Then the response should contain ""
