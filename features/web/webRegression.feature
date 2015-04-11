Feature: Web API Functionality

  As a tester
  I want to make sure this test suite is up and running
  So that I can automate continuous integration and regression tests using it

@saucey @javascript @web @search @button @link
Scenario: Perform a search query against html5doctor.com
  Given I am on "/"
  Then I should see "HTML5 Doctor"
  And the response should contain "banner"
  When I fill in "q" with "header"
  And I press "search-button"
  And I wait for 1 seconds
  Then I should see "header | HTML5 Doctor"
  And I should be on "/search/?q=header"
  When I follow "About"
  Then I should be on "/about/"

@saucey @javascript @web @table @multipleQueries
Scenario Outline: Perform multiple search queries against html5doctor.com
  Given I am on "/"
  Then I should see "HTML5 Doctor"
  And the response should contain "banner"
  When I fill in "q" with "<query>"
  And I press "search-button"
  And I wait for 1 seconds
  Then I should see "<expectedResult>"

Examples:
| query | expectedResult |
| head | Element Index |
| link | Element Index |
| meta | Element Index |
| span | Element Index |
| batman | No results for batman. |

@saucey @javascript @web @xpathPress @redirect @browserWindowSize
Scenario Outline: Capture a redirect, change window size, and press an element by XPath
  Given I am on "<request>"
  And I wait for 3 seconds
  And I set my browser window size to MacBook Retina
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

@saucey @javascript @web @alert
Scenario: Verify javascript pop up alerts
  Given I am on "http://www.javascripter.net/faq/alert.htm"
  Then I should see "How do I display an alert message from JavaScript?"
  When I press "Try it now"
  Then I should see "Hello from JavaScript!" in popup
  When I confirm the popup
  Then I should be on "http://www.javascripter.net/faq/alert.htm"
  And I should see "The alert() method does not return a value (that is, it returns undefined)."

@saucey @javascript @web @scroll
Scenario: Scroll up and down a site
  Given I am on "/"
  Then I should see "HTML5 Doctor"
  And the response should contain "banner"
  When I scroll to the bottom
  Then I should see " All rights reserved. "
  When I scroll to the top
  Then I should see "RECENT COMMENTS"

@saucey @javascript @web @scrollToElement
Scenario: Scroll to an element by XPath or ID
  Given I am on "http://stackoverflow.com/questions/11067186/is-using-footer-inside-form-semantically-fine"
  And I wait for 1 seconds
  Then I should see "Is using <footer> inside <form> semantically fine?"
  When I scroll to the "wmd-input" field
  And I wait for 1 seconds
  Then I should see "Your Answer"

@saucey @javascript @web @browserFunctionality
Scenario: Test some other browser functionality
  Given I am on a new session
  And I am on "/"
  Then I should see "HTML5 Doctor"
  And the response should contain "banner"
  When I reload the page
  Then I should be on "/"

@saucey @javascript @web @form
Scenario: Fill out a form
  Given I am on "http://www.html5rocks.com/en/tutorials/forms/html5forms/input-types.html"
  Then I should see "Before you may cross the bridge, you must answer these questions!"
  When I fill in the following:
    | first_last | Bruce Wayne |
    | email_addr | bruce@wayneenterprises.com |
    | email_addr_confirm | bruce@wayneenterprises.com |
    | fav_website | http://whoisbatman.com |
    | fav_pizza | 555-111-1234 |
    | dob | 02191915 |
    | age | 51 |
    | chocolate | Dark Chocolate with Almonds |
    | part_number | XXX9999XX |
  And I wait for 3 seconds
  Then I should be on "http://www.html5rocks.com/en/tutorials/forms/html5forms/input-types.html"
  And I should see "Before you may cross the bridge, you must answer these questions!"

@saucey @javascript @web @form
Scenario: Fill out a form
  Given I am on "http://www.html5rocks.com/en/tutorials/forms/html5forms/input-types.html"
  Then I should see "Before you may cross the bridge, you must answer these questions!"
  When I fill in "first_last" with "Bruce Wayne"
  And I fill in "email_addr" with "bruce@wayneenterprises.com"
  And I fill in "email_addr_confirm" with "bruce@wayneenterprises.com"
  And I fill in "fav_website" with "http://whoisbatman.com"
  And I fill in "fav_pizza" with "555-111-1234"
  And I fill in "dob" with "02191915"
  And I fill in "age" with "51"
  And I fill in "chocolate" with "Dark Chocolate with Almonds"
  And I fill in "part_number" with "XXX9999XX"
  And I wait for 2 seconds
  Then I should be on "http://www.html5rocks.com/en/tutorials/forms/html5forms/input-types.html"
  And I should see "Before you may cross the bridge, you must answer these questions!"

@saucey @javascript @web @failure
Scenario: Generate some failures for our report
  Given I am on "/"
  Then I should see "HTML5 Doctor"
  And the response should contain "banner"
  When I follow "Article Archive"
  Then I should be on "/farticle-farchive/"
  And I should see "Some failures in my report"

@saucey @javascript @web @failure
Scenario: Generate some MOAR failures for our report
  Given I am on "/"
  Then I should see "HTML5 Doctor"
  And the response should contain "banner"
  When I follow "Element Index"
  Then I should be on "/felement-findex/"
  And I should see "Some failures in my report"

@saucey @javascript @web @skipped @snippets
Scenario: Generate some snippets and skipped steps for our report
  Given I am on "/"
  Then I should see "HTML5 Doctor"
  And the response should contain "banner"
  When I do some fancy ass shit
  Then the rest of this test should be skipped
  And I should see "Some skipped steps` in my report"
