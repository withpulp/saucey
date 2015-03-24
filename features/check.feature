Feature: I want to make sure this test suite is up and running

  As a tester
  I want to make sure this test suite is up and running
  So that I can automate continuous integration and regression tests

    @javascript @check @googleQuery
    Scenario: Query against google.com and search
      Given I am on "http://google.com"
      Then I should see "Gmail"
      And the response should contain "Google Search"
      When I fill in "q" with "Batman"
      And I wait for 2 seconds
      Then I should see "Batman"

      @javascript @check @googleQueries
      Scenario Outline: Multiple queries against google.com and search
        Given I am on "http://google.com"
        Then I should see "Gmail"
        And the response should contain "Google Search"
        When I fill in "q" with "<hero>"
        And I wait for 2 seconds
        Then I should see "<expectedText>"

      Examples:
      | hero | expectedText |
      | Batman | Batman |
      | Superman | Superman |
      | Wonder Woman | Diana Prince |
      | Captain Marvel | Shazam |

      @javascript @check @elementPress @redirect
      Scenario Outline: Expect redirect from request to URL and function by XPath
        Given I am on "<request>"
        And I wait for 3 seconds
        And I set browser window size to "2000" x "1200"
        Then I should be on "<URL>"
        And I should see "<expectedText>"
        When I click on the element with xpath '<heroIcon>'
        And I wait for 2 seconds
        And I click on the element with xpath '//*[@id="nextslide"]'
        Then I should see "CLOSE GALLERY"

      Examples:
      | request | URL | expectedText | heroIcon |
      | http://batman.com | http://www.dccomics.com/characters/batman | Dark Knight | //*[@id="main"]/div/div[2]/div/div[1]/img |
      | http://superman.com | http://www.dccomics.com/characters/superman | Look! Up in the sky! | //*[@id="main"]/div/div[2]/div/div[1]/img |

      @javascript @check @alert
      Scenario: Popup and JS Alerts
        Given I am on "http://www.w3schools.com/js/tryit.asp?filename=tryjs_alert"
        Then I should see "Try it Yourself"
        When I click on the element with xpath '/html/body/button'
        Then I should see "I am an alert box!" in popup
        When I confirm the popup
        Then I should be on "http://www.w3schools.com/js/tryit.asp?filename=tryjs_alert"

      @javascript @check @scroll
      Scenario: Scroll down a parallax driven website
        Given I am on "http://journey.lifeofpimovie.com/"
        And I wait 10 seconds
        Then I should see "Scroll down to discover more..."
        When I scroll to the bottom
        Then I should see "OWN IT ON BLU-RAY 3D"
