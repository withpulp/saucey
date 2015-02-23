Feature: I want to set up regression test suite for the Dashboard

  In order to perform regression testing on the Dashboard
  As a tester
  I want to set up regression test suite for the Dashboard

    @regression @dashboard @javascript @dashboardGuest
    Scenario Outline: I want to browse around as a guest on dashboard landing page
      Given I am on dashboard stage
      And I wait for 1 seconds
      Then I should see "<cta>"
      When I follow "<cta>"
      Then the url should match "<expectedUrl>"
      And I should see "<expectedText>"

    Examples:
    | cta | expectedUrl | expectedText |
    | Forgot password | https://adstack-stage.adcade.com/forgotpassword | Enter your email to receive a reset link. |
    | Sign In | posturl | SOME_ERROR |
    | Request Account | posturl | SOME_TEXT |
    
    @regression @dashboard @javascript @dashboardLoginError
    Scenario Outline: I want to log in with my fake credentials and see proper error messages
      Given I am on dashboard stage
      When I authenticate as "<email>" using "<password>"
      And I wait for 1 seconds
      Then I should see "<expectedText>"

    Examples:
    | email | password | expectedText |
    |  |  | LOGIN_ERROR |
    | abc |  | Please include an '@' in the email address. |
    | abc@adcade.com |  | MISSING_PASSWORD_ERROR |
    |  | 123 | MISSING_EMAIL_ERROR |
    | abc | 123 | INVALID_CREDENTIAL_ERROR |

    @regression @dashboard @javascript @dashboardLoginSuccess
    Scenario: I want to login as a user
      Given I am on dashboard stage
      And I wait for 1 seconds
      Then I should see "Remember Me"
      When I fill in "Email Address" with "sl@adcade.com"
      And I fill in "Password" with "Qwerty!23"
      And I press "Sign In"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      And I should see "Please select an organization to view its campaigns."
      And I should see dashboard header and footer components with name "Sylvia" and version "1.0.7"





#
# REQUIRE UPDATE!!
#
    @regression @dashboard @javascript @dashboardProfileSettings
    Scenario: I want to view my profile settings as a logged-in user
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I follow "Sylvia"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/account"
      And I should see dashboard Account Settings Content with first name "Sylvia" and last name "Leung"
      And I should see dashboard header and footer components with name "Sylvia" and version "1.0.7"

    @regression @dashboard @javascript @dashboardProfileSettingsChangePW
    Scenario: I want to view the Change Password page as a logged-in user
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I follow "Sylvia"
      And I press "Change Password"
      Then I should be on "https://adstack-stage.adcade.com/account"
      And I should see dashboard Account Settings Change Password Content
      And I should see dashboard header and footer components with name "Sylvia" and version "1.0.7"

    @regression @dashboard @javascript @dashboardProfileSettingsChangePWError
    Scenario Outline: I want to change my password as a logged-in user but an error occurred
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I follow "Sylvia"
      And I press "Change Password"
      And I enter my current password "<currpw>" and new password "<newpw>"
      And I press "Change Password"
      Then I should be on "https://adstack-stage.adcade.com/account"
      And I should see "<expectedError>"
      When I press "OK"
      Then I should not see "<expectedError>"
      And I should see dashboard Account Settings Change Password Content
      And I should see dashboard header and footer components with name "Sylvia" and version "1.0.7"

    Examples:
    | currpw | newpw | expectedError |
    |  |  | EMPTY_FORM_ERROR |
    | abc | 12345678 | OLD_PASSWORD_ERROR |
    | Qwerty!23 | abc | CHANGE_PASSWORD_ERROR |
    # Please fix the following errors
    # Invalid password! Please make sure your new password is at least 8 characters long. You can use as many special characters as you want.

    @regression @dashboard @javascript @dashboardSettings @dashboardEmptyScreens
    Scenario: I want to view my organization settings after logging in
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I visit drop down link of item "Settings"
      And I wait for 1 seconds
      Then I should see "New Advertiser"
      And I should see "EMPTY_ADVERTISERS_LIST_MESSAGE"

    @regression @dashboard @javascript @dashboardBilling @dashboardEmptyScreens
    Scenario: I want to view my billing after logging in
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I visit drop down link of item "Billing"
      And I wait for 1 seconds
      Then I should see "New Organization" 
      And I should see "EMPTY_ORGANIZATION_LIST_MESSAGE"

    @regression @dashboard @javascript @dashboardAddNewUser @dashboardEmptyScreens
    Scenario: I want to view the Users settings after logging in
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I visit drop down link of item "Users"
      And I wait for 1 seconds
      Then I should see "Add New User" 
      And I should see "EMPTY_USERS_LIST_MESSAGE"


# Scenario: Session Expire
# You still there?
# Your session is about to expire. Do you want to continue working?
# btn Cancel
# btn OK


#
# TEST
#

    @regression @dashboard @javascript @dashboardTest
    Scenario: Testing Gherkin code
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I visit drop down link of item "Settings"
      And I wait for 1 seconds
      Then I should see "New Advertiser"

