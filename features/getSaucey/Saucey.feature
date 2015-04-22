Feature: Cool ass functionality

  As a saucey developer
  I want to showcase the big bang of saucey
  So that I can automate continuous integration and regression tests using it

  @saucey @javascript @adcade
  Scenario: Play the app
    Given I set my browser window size to MacBook Retina
    And I am on "https://www.adcade.com/"
    And I wait for 1 seconds
    When I move to "1476" x "160" coordinates
    And I move to "1576" x "160" coordinates
    And I move to "1876" x "160" coordinates
    And I tap "1876" x "160" coordinates
    Then I should see "Sajjad Hossain"

  @saucey @javascript @inpage @play @adscr736
  Scenario: Play the app
    Given I set my browser window size to MacBook Retina
    And I am on "http:.///adcade.dev/adz/tnbr_pushdown_marquee/deploy/index.html"
    And I wait for 15 seconds
    When I tap "1540" x "130" coordinates
    And I wait for 10 seconds

  @saucey @javascript @initial
  Scenario: Start at app metrics
    Given I am on "http://127.0.0.1:9987/"
    Then I should see "Hello world!"
    And I wait for 10 seconds

  @saucey @javascript @metrics
  Scenario: Look at app metrics
    Given I am on "http://127.0.0.1:7890/client/#anonymous"
    And I wait for 5 seconds
    Then I should see "Elements"
    And I should see "Network"
    And I should see "Console"
    And I go to network tab
    And I wait for 5 seconds
    And I select request 1
    And I am on the header tab
    Then I should see "GET"


  @saucey @javascript @inpage @adscr736Metrics
  Scenario: Look at app metrics
    Given I am on "http://127.0.0.1:7890/client/#anonymous"
    Then I should see "Elements"
    And I should see "Network"
    And I should see "Console"
    And I click on the element with xpath '//*[@id="toolbar"]/button[4]'
    And I wait for 30 seconds
    Then I should see "ad-stage.adcade.com"
    When I click on the element with xpath '//*[@id="network-container"]/div/div[1]/table/tbody/tr[1]/td[1]'
    And I click on the element with xpath '//*[@id="network-views"]/div/div[1]/li[1]'
    Then I should see "GET"
    And the response should contain "imp"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I click on the element with xpath '//*[@id="network-container"]/div/div[1]/table/tbody/tr[2]/td[1]'
    And I click on the element with xpath '//*[@id="network-views"]/div/div[1]/li[1]'
    Then I should see "POST"
    And the response should contain "std.auto.expansion"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I click on the element with xpath '//*[@id="network-container"]/div/div[1]/table/tbody/tr[3]/td[1]'
    And I click on the element with xpath '//*[@id="network-views"]/div/div[1]/li[1]'
    Then I should see "POST"
    And the response should contain "std.auto.video.mute.video"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I click on the element with xpath '//*[@id="network-container"]/div/div[1]/table/tbody/tr[4]/td[1]'
    And I click on the element with xpath '//*[@id="network-views"]/div/div[1]/li[1]'
    Then I should see "POST"
    And the response should contain "std.auto.video.start.video"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I click on the element with xpath '//*[@id="network-container"]/div/div[1]/table/tbody/tr[5]/td[1]'
    And I click on the element with xpath '//*[@id="network-views"]/div/div[1]/li[1]'
    Then I should see "POST"
    And the response should contain "std.auto.video.1st_quartile.video"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I click on the element with xpath '//*[@id="network-container"]/div/div[1]/table/tbody/tr[6]/td[1]'
    And I click on the element with xpath '//*[@id="network-views"]/div/div[1]/li[1]'
    Then I should see "POST"
    And the response should contain "std.auto.collapse"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I click on the element with xpath '//*[@id="network-container"]/div/div[1]/table/tbody/tr[7]/td[1]'
    And I click on the element with xpath '//*[@id="network-views"]/div/div[1]/li[1]'
    Then I should see "POST"
    And the response should contain "tdn"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I click on the element with xpath '//*[@id="network-container"]/div/div[1]/table/tbody/tr[8]/td[1]'
    And I click on the element with xpath '//*[@id="network-views"]/div/div[1]/li[1]'
    Then I should see "POST"
    And the response should contain "std.interact.expansion"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"
    When I click on the element with xpath '//*[@id="network-container"]/div/div[1]/table/tbody/tr[9]/td[1]'
    And I click on the element with xpath '//*[@id="network-views"]/div/div[1]/li[1]'
    Then I should see "POST"
    And the response should contain "2e29ff49-0fb1-48dc-8374-9565d430b9c3"
    And the response should contain "88f87a37-491e-4372-b762-f0b9a568c418"

