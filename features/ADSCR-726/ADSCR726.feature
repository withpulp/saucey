Feature: Cool ass functionality

  As a tester
  I want to run a regression suite against ADSCR-726
  So that I can mark it as PASSED QA or

  @saucey @javascript @inpage @adscr736Ad
  Scenario: Test against PLID issues
    Given I set my browser window size to MacBook Retina
    And I am on "http://adcade.dev/adz/tnbr_pushdown_marquee/deploy/index.html"
    And I wait for 15 seconds
    When I tap "1540" x "125" coordinates
    And I wait for 5 seconds

  @saucey @javascript @inpage @adscr736Metrics
  Scenario: Look at app metrics for PLID issues
    Given I am on "http://127.0.0.1:7890/client/#anonymous"
    Then I should see "Elements"
    And I should see "Network"
    And I should see "Console"
    And I go to network tab
    And I wait for 20 seconds
    Then I should see "ad-stage.adcade.com"
    When I select the first request
    And I am on the header tab
    Then I should see "GET"
    And the response should contain "imp"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select the second request
    Then I should see "POST"
    And the response should contain "std.auto.expansion"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select the third request
    And I am on the header tab
    Then I should see "POST"
    And the response should contain "std.auto.video.mute.video"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select the fourth request
    And I am on the header tab
    Then I should see "POST"
    And the response should contain "std.auto.video.start.video"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select the fifth request
    And I am on the header tab
    Then I should see "POST"
    And the response should contain "std.auto.video.1st_quartile.video"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select the sixth request
    And I am on the header tab
    Then I should see "POST"
    And the response should contain "std.auto.collapse"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select the seventh request
    And I am on the header tab
    Then I should see "POST"
    And the response should contain "tdn"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select the eighth request
    And I am on the header tab
    Then I should see "POST"
    And the response should contain "std.interact.expansion"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I select the ninth request
    And I am on the header tab
    Then I should see "POST"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"