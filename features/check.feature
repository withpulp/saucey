Feature: I want to make sure this test suite is up and running

  As a tester
  I want to make sure this test suite is up and running
  So that I can automate continuous integration and regression tests using it

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
      Given I am on "http://www.javascripter.net/faq/alert.htm"
      Then I should see "How do I display an alert message from JavaScript?"
      When I press "Try it now"
      Then I should see "Hello from JavaScript!" in popup
      When I confirm the popup
      Then I should be on "http://www.javascripter.net/faq/alert.htm"
      And I should see "The alert() method does not return a value (that is, it returns undefined)."

    @javascript @check @scroll
    Scenario: Scroll up and down a site
      Given I am on "http://blackestate.co.nz/"
      And I wait for 2 seconds
      Then I should see "Black Estate is a remarkable place for wine."
      When I scroll to the bottom
      And I wait for 3 seconds
      Then I should see "2014 Season Report"
      When I scroll to the top
      Then I should see "Tasting Room & Eatery"

    @javascript @check @scrollToElement
    Scenario: Scroll to an element
      Given I am on "http://stackoverflow.com/questions/11067186/is-using-footer-inside-form-semantically-fine"
      And I wait for 2 seconds
      Then I should see "Is using <footer> inside <form> semantically fine?"
      When I scroll to the "wmd-input" field
      And I wait for 1 seconds
      Then I should see "Your Answer"
