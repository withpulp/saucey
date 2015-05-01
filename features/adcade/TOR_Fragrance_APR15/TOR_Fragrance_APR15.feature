Feature: TOR_Fragrance_APR15

  As a tester
  I want to run campaign metrics functional test cases against TOR_Fragrance_APR15 campaign
  So that I can mark it as PASSED QA or BACK TO DEV

  @javascript @TOR_Fragrance_1032x1100_Desktop @Regression_TOR_Fragrance_APR15
  Scenario: Testing functionality and assets for campaign
    Given I set my browser window size to 15 inch MacBook Retina
    And I am on "http://demo.adcade.com/timeInc/2015/toryBurch/desktop_qa.html"
    And I wait for 10 seconds
    When I tap "1400" x "120" coordinates
    And I tap "1400" x "120" coordinates
    And I tap "1720" x "660" coordinates
    And I wait for 5 seconds

  @javascript @Regression_TOR_Fragrance_APR15_Metrics
  Scenario: Click-through and metrics testing for HTTPS requests
    Given I am on "http://adcade.dev:7890/client/#anonymous"
    Then I should see "Elements"
    And I should see "Network"
    And I should see "Console"
    When I go to network tab
    And I wait for 20 seconds
    Then the response should contain "ad-adstack.adcade.com"
    When I select request "1"
    And I am on the network header tab
    Then the response should contain "GET"
    And the response should contain "imp"
    And the response should contain "7081a21a-c754-42c8-b6a6-cb2aad449671"
    And the response should contain "e0804edc-fb19-472d-b315-9f84979e5b43"
    When I select request "2"
    And I am on the network header tab
    Then the response should contain "POST"
    And the response should contain "std.auto.expansion"
    And the response should contain "7081a21a-c754-42c8-b6a6-cb2aad449671"
    And the response should contain "e0804edc-fb19-472d-b315-9f84979e5b43"
    When I select request "3"
    And I am on the network header tab
    Then the response should contain "POST"
    And the response should contain "std.auto.collapse"
    And the response should contain "7081a21a-c754-42c8-b6a6-cb2aad449671"
    And the response should contain "e0804edc-fb19-472d-b315-9f84979e5b43"
    When I select request "4"
    And I am on the network header tab
    Then the response should contain "POST"
    And the response should contain "std.auto.collapse"
    And the response should contain "7081a21a-c754-42c8-b6a6-cb2aad449671"
    And the response should contain "e0804edc-fb19-472d-b315-9f84979e5b43"
    When I select request "5"
    And I am on the network header tab
    Then the response should contain "POST"
    And the response should contain "tdn"
    And the response should contain "7081a21a-c754-42c8-b6a6-cb2aad449671"
    And the response should contain "e0804edc-fb19-472d-b315-9f84979e5b43"
    When I select request "6"
    And I am on the network header tab
    Then the response should contain "POST"
    And the response should contain "std.interact.replay"
    And the response should contain "7081a21a-c754-42c8-b6a6-cb2aad449671"
    And the response should contain "e0804edc-fb19-472d-b315-9f84979e5b43"
    When I select request "7"
    And I am on the network header tab
    Then the response should contain "POST"
    And the response should contain "tdn"
    And the response should contain "7081a21a-c754-42c8-b6a6-cb2aad449671"
    And the response should contain "e0804edc-fb19-472d-b315-9f84979e5b43"
    When I select request "8"
    And I am on the network header tab
    Then the response should contain "POST"
    And the response should contain "std.auto.collapse"
    And the response should contain "7081a21a-c754-42c8-b6a6-cb2aad449671"
    And the response should contain "e0804edc-fb19-472d-b315-9f84979e5b43"
    When I select request "9"
    And I am on the network header tab
    Then the response should contain "POST"
    And the response should contain "std.exit.clickthrough"
    And the response should contain "7081a21a-c754-42c8-b6a6-cb2aad449671"
    And the response should contain "e0804edc-fb19-472d-b315-9f84979e5b43"

  @javascript @TOR_Fragrance_1032x1100_Desktop @Compatibility_TOR_Fragrance_APR15
  Scenario: Compatibility tests for the campaign
    Given I am on "http://demo.adcade.com/timeInc/2015/toryBurch/desktop_qa.html"
    Then the response should contain "2015 Tory Burch Fragrence Desktop"
    When I am on "https://resource.adcade.com/fa3fedc3-c00e-4fbb-8f43-174577fbde99/7081a21a-c754-42c8-b6a6-cb2aad449671/20150427200014/img/wallpaper.png"
    Then the response should contain "wallpaper.png"

  @javascript @TOR_Fragrance_1032x1100_Tablet
  Scenario: Compatibility tests on Mobile Devices for the campaign
    Given I am on "http://demo.adcade.com/timeInc/2015/toryBurch/tablet_qa.html"
    Then the response should contain "2015 Tory Burch Fragrence Desktop"
    When I am on "https://resource.adcade.com/fa3fedc3-c00e-4fbb-8f43-174577fbde99/7081a21a-c754-42c8-b6a6-cb2aad449671/20150427200014/img/wallpaper.png"
    Then the response should contain "wallpaper.png"

  @javascript @TOR_Fragrance_1032x1100_Desktop @IE_Backup_TOR_Fragrance_APR15
  Scenario: IE 8 Back up tests for the campaign
    Given I am on "http://demo.adcade.com/timeInc/2015/toryBurch/desktop_qa.html"
    Then the response should contain "2015 Tory Burch Fragrence Desktop"
    When I am on "https://ad.adcade.com/2/backup/imp/7081a21a-c754-42c8-b6a6-cb2aad449671/pl/e0804edc-fb19-472d-b315-9f84979e5b43/key/ie8/?"
    Then I should not see "wallpaper.png"
