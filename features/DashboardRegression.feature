Feature: I want to set up regression test suite for the Dashboard

  In order to perform regression testing on the Dashboard
  As a tester
  I want to set up regression test suite for the Dashboard


    #
    # Dashboard: Guest
    #

    @javascript @regression @dashboard @dashboardGuest @dashboardGuestBrowse
    Scenario Outline: I want to browse around as a guest on dashboard landing page
      Given I am on dashboard stage
      And I wait for 1 seconds
      Then I should see "<cta>"
      When I follow "<cta>"
      Then the url should match "<expectedUrl>"
      And I should see "<expectedText>"
      And I should see copyright and version

    Examples:
    | cta | expectedUrl | expectedText |
    | Forgot password | https://adstack-stage.adcade.com/forgotpassword | Enter your email to receive a reset link. |
    | Sign In | posturl | SOME_ERROR |
    | Request Account | posturl | SOME_TEXT |

    @javascript @regression @dashboard @dashboardGuest @dashboardGuestRedirect
    Scenario: I want to ensure I'm redirected to login if I attempt to hit a page that requires login credentials
      Given I go to "https://adstack-stage.adcade.com/dashboard"
      When I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/login"
      And I should see copyright and version
      Given I go to "https://adstack-stage.adcade.com/account/profile"
      When I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/login"
      And I should see copyright and version
      Given I go to "https://adstack-stage.adcade.com/organizations"
      When I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/login"
      And I should see copyright and version

    #
    # Dashboard: Forgot Password
    #

    @javascript @regression @dashboard @dashboardForgotPW @dashboardForgotPWCancel
    Scenario: I forgot my password and I want to retrieve it with a valid email address
      Given I am on dashboard stage
      And I wait for 1 seconds
      When I follow "Forgot password"
      Then I should see "Enter your email to receive a reset link."
      When I fill in "email" with "sl@adcade.com"
      And I press "Request Link"
      Then I should see "Are you sure?"
      And I should see "Click OK to request a reset link"
      When I press "Cancel"
      And I wait for 1 seconds
      Then I should not see "Are you sure?"
      And I should see copyright and version

    @javascript @regression @dashboard @dashboardForgotPW @dashboardForgotPWError
    Scenario: I forgot my password and I want to retrieve it with a bogus email address
      Given I am on dashboard stage
      And I wait for 1 seconds
      When I follow "Forgot password"
      Then I should see "Enter your email to receive a reset link."
      When I fill in "email" with "sl@adcade"
      And I press "Request Link"
      Then I should see "Invalid email! The email address you entered is not valid."
      When I press "Close"
      And I wait for 1 seconds
      Then I should not see "Please fix the following errors"
      And I should see copyright and version

    @javascript @regression @dashboard @dashboardForgotPW @dashboardForgotPWSuccess
    Scenario: I forgot my password and I want to retrieve it with a valid email address
      Given I am on dashboard stage
      And I wait for 1 seconds
      When I follow "Forgot password"
      Then I should see "Enter your email to receive a reset link."
      When I fill in "email" with "sl@adcade.com"
      And I press "Request Link"
      Then I should see "Are you sure?"
      And I should see "Click OK to request a reset link"
      When I press "OK"
      And I wait for 2 seconds
      Then I should see "Email Sent!"
      And I should see "An email containing a reset link has been sent to you. Please click the link in the email to receive further instructions."
      When I press "Close"
      And I wait for 1 seconds
      Then I should see "Remember Me"
      And I should see copyright and version

    #
    # Dashboard: Login
    #

    # NOTE: Unable to check and uncheck checkboxes on Firefox

    @javascript @regression @dashboard @dashboardLogin @dashboardLoginRememberMe
    Scenario: I want to be able to check and uncheck Remember Me on dashboard landing page
      Given I am on dashboard stage
      And I wait for 1 seconds
      Then I should see "Remember Me"
      When I check "Remember Me"
      Then the "Remember Me" checkbox should be checked
      When I uncheck "Remember Me"
      Then the "Remember Me" checkbox should not be checked
      And I should see copyright and version

    @javascript @regression @dashboard @dashboardLogin @dashboardLoginRememberMeChecked
    Scenario: I want to be able to enable Remember Me on dashboard landing page
      Given I am on dashboard stage
      And I wait for 1 seconds
      Then I should see "Remember Me"
      When I check "Remember Me"
      Then the "Remember Me" checkbox should be checked
      When I fill in "Email Address" with "sl@adcade.com"
      And I fill in "Password" with "Qwerty!23"
      And I press "Sign In"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      When I visit drop down link of item "Log Out"
      Then I should see "Sign In"
      And I should see "sl@adcade.com"
      And the "Remember Me" checkbox should be checked
      And I should see copyright and version

    @javascript @regression @dashboard @dashboardLogin @dashboardLoginRememberMeUnchecked
    Scenario: I want to be able to disable Remember Me on dashboard landing page
      Given I am on dashboard stage
      And I wait for 1 seconds
      Then I should see "Remember Me"
      When I uncheck "Remember Me"
      Then the "Remember Me" checkbox should not be checked
      When I fill in "Email Address" with "sl@adcade.com"
      And I fill in "Password" with "Qwerty!23"
      And I press "Sign In"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      When I visit drop down link of item "Log Out"
      Then I should see "Sign In"
      And I should not see "sl@adcade.com"
      And the "Remember Me" checkbox should not be checked
      And I should see copyright and version

    @javascript @regression @dashboard @dashboardLogin @dashboardLoginError
    Scenario Outline: I want to log in with my fake credentials and see proper error messages
      Given I am on dashboard stage
      When I authenticate as "<email>" using "<password>"
      And I wait for 2 seconds
      Then I should see "<expectedText>"
      And I should see copyright and version

    Examples:
    | email | password | expectedText |
    |  |  | MISSING_CREDENTIAL_ERROR |
    | abc |  | INVALID_EMAIL_ERROR |
    | abc@adcade.com |  | MISSING_PASSWORD_ERROR |
    |  | 123 | MISSING_EMAIL_ERROR |
    | abc | 123 | INVALID_CREDENTIAL_ERROR |

    @javascript @regression @dashboard @dashboardLogin @dashboardLoginSuccess @emptyScreens
    Scenario: I want to login as a user
      Given I am on dashboard stage
      And I wait for 1 seconds
      Then I should see "Remember Me"
      When I fill in "Email Address" with "sl@adcade.com"
      And I fill in "Password" with "Qwerty!23"
      And I press "Sign In"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      And I should see "New Campaign"
      And I should see "EMPTY_CAMPAIGNS_MESSAGE"
      And I should see dashboard header and footer components
      And I should see copyright and version

    #
    # Dashboard: Sylvia
    # Default to profile settings
    #

    @javascript @regression @dashboard @dashboardProfileSettings @dashboardDefaultProfileEntry
    Scenario: I want to view my profile settings by selecting my name
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I follow "Sylvia"
      Then I should be on "https://adstack-stage.adcade.com/account/profile"
      And I should see dashboard Profile Settings content
      And I should see dashboard header and footer components
      And I should see copyright and version

    #
    # Dashboard: Sylvia > Profile Settings
    # editable fields
    # https://docs.google.com/a/adcade.com/document/d/1zBUvh0lOV-tsRnb0ce-FQqYTL1-YW--IKoKP7k3w2Fs/edit
    # profile info: first name (required), last name (required), email (required)
    #

    @javascript @regression @dashboard @dashboardProfileSettings @dashboardProfileSettingsEntry
    Scenario: I want to view my profile settings by selecting Profile Settings in drop down
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I visit drop down link of item "Profile Settings"
      Then I should be on "https://adstack-stage.adcade.com/account/profile"
      And I should see dashboard Profile Settings content
      And I should see dashboard header and footer components
      And I should see copyright and version

    @javascript @regression @dashboard @dashboardProfileSettings @dashboardUpdateProfile
    Scenario: I want to be able to update multiple fields of my profile at the same time
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on Profile Settings of dashboard stage
      When I fill in "fname" with "SYLVIA"
      And I fill in "lname" with "LEUNG"
      And I fill in "email" with "SYLVIA@ADCADE.COM"
      And I fill in "phone" with "1234567890"
      And I fill in "company" with "ADCADE"
      And I fill in "jtitle" with "THE QA WHO LOVES USABILITY"
      And I press "Update Profile"
      Then I should see "SUBMIT_SUCCESSFUL_MESSAGE"
      When I follow "Dashboard"
      And I follow "Sylvia"
      Then I should see "SYLVIA"
      And I should see "LEUNG"
      And I should see "SYLVIA@ADCADE.COM"
      And I should see "1234567890"
      And I should see "ADCADE"
      And I should see "THE QA WHO LOVES USABILITY"
      And I should see copyright and version

    @javascript @regression @dashboard @dashboardProfileSettings @dashboardUpdateProfile
    Scenario: I want to be able to submit changes of my profile multiple times
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on Profile Settings of dashboard stage
      When I fill in "fname" with "Sylvia"
      And I fill in "lname" with "Leung"
      And I fill in "email" with "sl@adcade.com"
      And I fill in "company" with "Adcade"
      And I fill in "jtitle" with "QA Engineer"
      And I press "Update Profile"
      Then I should see "SUBMIT_SUCCESSFUL_MESSAGE"
      When I fill in "phone" with ""
      And I press "Update Profile"
      Then I should see "SUBMIT_SUCCESSFUL_MESSAGE"
      When I follow "Dashboard"
      And I follow "Sylvia"
      Then I should see "Sylvia"
      And I should see "Leung"
      And I should see "sl@adcade.com"
      And I should see "Adcade"
      And I should see "QA Engineer"
      And I should not see "1234567890"
      And I should see copyright and version

    @javascript @regression @dashboard @dashboardProfileSettings @dashboardUpdateProfileError
    Scenario: I want to be able to update my profile but an error occurred
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on Profile Settings of dashboard stage
      When I fill in "email" with "sl@"
      And I press "Update Profile"
      Then I should see "INVALID_EMAIL_ERROR"
      When I press "Close"
      Then I should not see "INVALID_EMAIL_ERROR"
      When I fill in "phone" with "abc"
      And I press "Update Profile"
      Then I should see "INVALID_PHONE_FORMAT_ERROR"
      When I press "Close"
      Then I should not see "INVALID_PHONE_FORMAT_ERROR"
      And I should see copyright and version

    @javascript @regression @dashboard @dashboardProfileSettings @dashboardChangePWError
    Scenario Outline: I want to change my password as a logged-in user but an error occurred
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I follow "Sylvia"
      And I enter my current password "<currpw>" and new password "<newpw>"
      And I press "Update Password"
      Then I should see "<expectedError>"
      When I press "Close"
      Then I should not see "<expectedError>"
      And I should see dashboard header and footer components
      And I should see copyright and version

    Examples:
    | currpw | newpw | expectedError |
    |  |  | EMPTY_FORM_ERROR |
    | abc | 12345678 | INCORRECT_OLD_PASSWORD_ERROR |
    | Qwerty!23 | abc | INVALID_PASSWORD_FORMAT_ERROR |

    @javascript @regression @dashboard @dashboardProfileSettings @dashboardChangePWSuccess
    Scenario Outline: I want to verify my updated password and change it back
      Given I am on dashboard stage
      When I authenticate as "<email>" using "<pw_new>"
      Then I should see "INVALID_CREDENTIAL_ERROR"
      When I authenticate as "<email>" using "<pw_cur>"
      And I wait for 2 seconds
      Then I should see "Sylvia"
      When I follow "Sylvia"
      And I enter my current password "<pw_cur>" and new password "<pw_new>"
      And I press "Update Password"
      Then I should see "UPDATE_SUCCESSFUL_MESSAGE"
      When I press "Close"
      Then I should not see "UPDATE_SUCCESSFUL_MESSAGE"
      And I should see dashboard header and footer components
      And I should see copyright and version

    Examples:
    | email | pw_cur | pw_new |
    | sl@adcade.com | Qwerty!23 | abcd1234 |
    | sl@adcade.com | abcd1234 | Qwerty!23 |

    #
    # Dashboard: Sylvia > Log Out
    #

    @javascript @regression @dashboard @dashboardLogOut
    Scenario: I want to log out
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      When I visit drop down link of item "Log Out"
      Then I should see "Sign In"
      And I should see "Remember Me"
      Given I go to "https://adstack-stage.adcade.com/account/profile"
      When I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/login"

    #
    # Dashboard: Adcade (Organization)
    # default to settings
    #

    @javascript @regression @dashboard @OrgSettings @emptyScreens
    Scenario: I want to view my organization settings after logging in
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      When I follow "myQaOrg"
      And I wait for 1 seconds
      Then I should see "New Advertiser"
      And I should be on "https://adstack-stage.adcade.com/settings/"
      And I should see "EMPTY_ADVERTISERS_LIST_MESSAGE"
      And I should see dashboard header and footer components

    #
    # Dashboard: Adcade (Organization) > Settings
    #

    @javascript @regression @dashboard @OrgSettings @emptyScreens
    Scenario: I want to view my organization settings after logging in
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      When I visit drop down link of item "Settings"
      And I wait for 1 seconds
      Then I should see "New Advertiser"
      And I should be on "https://adstack-stage.adcade.com/settings/"
      And I should see "EMPTY_ADVERTISERS_LIST_MESSAGE"
      And I should see dashboard header and footer components

    #
    # Dashboard: Adcade (Organization) > Settings
    #
    # Create a New Advertiser:
    # Enter Advertiser Name (required)
    # Vertical Dropdown (required)
    #
    # btn: Save
    # btn: Save and Go To New Advertiser
    # btn: Cancel
    #

    @javascript @regression @dashboard @OrgSettings @createAdvertiserModal
    Scenario: I want to see the create new advertiser modal
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on myQaOrg Settings of dashboard stage
      When I press "New Advertiser"
      Then I should see "Create New Advertiser"
      And I should see "Save Advertiser"
      And I should see "Save and Go To Advertiser"
      And I should see "Cancel"

    @javascript @regression @dashboard @OrgSettings @createAdvertiserModalCancel
    Scenario: I want to create new advertiser but had to cancel
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on myQaOrg Settings of dashboard stage
      When I press "New Advertiser"
      And I follow "Cancel"
      Then I should not see "Save Advertiser"

    #
    # Dashboard: Adcade (Organization) > Settings
    # Missing required field, border-color becomes #a94442 (ruby red)
    #

    @javascript @regression @dashboard @OrgSettings @createAdvertiserModalError
    Scenario: I want to create a new advertiser but I missed required field
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on myQaOrg Settings of dashboard stage
      When I press "New Advertiser"
      And I press "Save Advertiser"
      Then the "advertisername" field border-color becomes red
      And the "advertiserVerticalDropdown" field border-color becomes red

    #
    # https://docs.google.com/a/adcade.com/spreadsheets/d/1oZtzfq6kFYOgi4HyLCd9UEWkDQd6OqfwVePYmY9zXWY/edit#gid=0
    # Advertiser Verticals:
    # Alcohol, Arts & Entertainment, Automotive, Business & Industrial, Dating & Personals, Electronics & Technology, Finance & Insurance, Food & Drink, Gambling, Health & Beauty, Hobbies & Leisure, Home & Garden, Internet & Telecom, Jobs & Education, Law & Government, News & Weather, Pets & Animals, Pharmaceuticals & Healthcare, Real Estate, Retail, Luxury Retail, Sports, Travel & Tourism, Other
    #

    @javascript @regression @dashboard @OrgSettings @createAdvertiserModalSave
    Scenario: I want to create new advertiser vertical of Other
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on myQaOrg Settings of dashboard stage
      When I fill in "advertisername" with "myAdvertiser Aero"
      And I select "Other" from "advertiserVerticalDropdown"
      And I press "Save Advertiser"
      Then I should see "myAdvertiser Aero"
      And I should see "Other"
      And I should not see "Save Advertiser"

    @javascript @regression @dashboard @OrgSettings @createAdvertiserModalSaveGoToAdvertiesr
    Scenario Outline: I want to create a new advertiser of a specific vertical and view it
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on myQaOrg Settings of dashboard stage
      When I fill in "advertisername" with "<myAdvertiserName>"
      And I select "<vertical>" from "advertiserVerticalDropdown"
      And I press "Save and Go To Advertiser"
      Then I should see "<myAdvertiserName>"
      And I should see "<vertical>"
      And I should see "New Campaign"
      And I should not see "Save Advertiser"
      And I should see copyright and version

    Examples:
    | myAdvertiserName | vertical |
    | myAdvertiser Blue | Alcohol |
    | myAdvertiser Cerise | Arts & Entertainment |
    | myAdvertiser Daffodil | Automotive |
    | myAdvertiser Eggplant | Business & Industrial |
    | myAdvertiser Folly | Dating & Personals |
    | myAdvertiser Gold | Electronics & Technology |
    | myAdvertiser Honeydew | Finance & Insurance |
    | myAdvertiser Ivory | Food & Drink |
    | myAdvertiser Jasmine | Gambling |
    | myAdvertiser Kobi | Health & Beauty |
    | myAdvertiser Lavender | Hobbies & Leisure |
    | myAdvertiser Magenta | Home & Garden |
    | myAdvertiser Navy |Internet & Telecom |
    | myAdvertiser Orange | Jobs & Education |
    | myAdvertiser Peach | Law & Government |
    | myAdvertiser Quartz | News & Weather |
    | myAdvertiser Raspberry | Pets & Animals |
    | myAdvertiser Seashell | Pharmaceuticals & Healthcare |
    | myAdvertiser Teal | Real Estate |
    | myAdvertiser Umber | Retail |
    | myAdvertiser Vanilla | Luxury Retail |
    | myAdvertiser White | Sports |
    | myAdvertiser Xanadu | Travel & Tourism |

    #
    # Dashboard: Adcade (Organization) > Settings
    # editable fields
    # https://docs.google.com/a/adcade.com/document/d/1zBUvh0lOV-tsRnb0ce-FQqYTL1-YW--IKoKP7k3w2Fs/edit
    # overview: click macro, cache buster, iframe buster
    # rows: advertiser name(required), vertical type(required)
    # to-do
    #
    # Org level Macros/Cache/iFrame Update:
    # All new placements will reflect the update
    # btn: Submit
    # btn: Cancel
    #
    # NOTE: Pia needs to update this. Org level updates should work similar to Delete where user can select which placements get affected.
    #

    @javascript @regression @dashboard @settingsClickMacroEditCancel
    Scenario: I want to edit my click macro, cache buster, and iframe buster thru organization settings
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on myQaOrg Settings of dashboard stage
      When I fill in "editClickMacro" with "testedit"
      And I manually press "enter"
      Then I should see "All new placements will reflect the update"
      And I should see "Submit"
      And I should see "Cancel"
      When I press "Cancel"
      Then I should see "ACTION_CANCELLED_MESSAGE"
      And I should not see "testedit"

    @javascript @regression @dashboard @settingsEdit
    Scenario Outline: I want to edit my click macro, cache buster, and iframe buster thru organization settings
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on myQaOrg Settings of dashboard stage
      When I fill in "<field>" with "<value>"
      And I manually press "enter"
      Then I should see "All new placements will reflect the update"
      And I should see "Submit"
      And I should see "Cancel"
      When I press "Submit"
      Then I should see "EDIT_SUCCESSFUL_MESSAGE"
      When I follow "Sylvia"
      And I follow "myQaOrg"
      Then I should see "<value>"

    Examples:
    | field | value |
    | editClickMacro | myQaOrg_clickmacro |
    | editCacheBuster | myQaOrg_cacheBuster |
    | editIframeBuster | myQaOrg_iframeBuster |

# START HERE





    #
    # Dashboard: Adcade (Organization) > Settings
    # Archive, Delete
    #
    # Delete Advertiser:
    # Advertiser Name
    # Number of Campaigns, Placements
    # Remove advertiser from delete list
    # Type delete to confirm (required)
    # btn: Delete
    # btn: Cancel
    #
    # Archive Warning:
    # Are you sure you want to archive this/these organizations/advertisers/campaigns?
    # btn: Submit
    # btn: Cancel
    #
    # Unarchive Warning:
    # Are you sure you want to unarchive this/these organizations/advertisers/campaigns?
    # btn: Submit
    # btn: Cancel
    #
    # to-do
    #





    #
    # Dashboard: Adcade (Organization) > Billing
    #

    @javascript @regression @dashboard @dashboardBilling @emptyScreens
    Scenario: I want to view my billing after logging in
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I visit drop down link of item "Billing"
      And I wait for 1 seconds
      Then I should see "Platform Agreement"
      And I should see "Billing Contact"
      And I should be on "https://adstack-stage.adcade.com/billing"
      And I should see "EMPTY_BILLING_LIST_MESSAGE"
      And I should see dashboard header and footer components

    #
    # Dashboard: Adcade (Organization) > Users
    #

    @javascript @regression @dashboard @dashboardUsers @emptyScreens
    Scenario: I want to view the Users settings after logging in
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I visit drop down link of item "Users"
      And I wait for 1 seconds
      Then I should see "Add New User"
      And I should be on "https://adstack-stage.adcade.com/organizations/users"
      And I should see "EMPTY_USERS_LIST_MESSAGE"
      And I should see dashboard header and footer components

    #
    # Dashboard: Adcade > All Organizations
    #
    # EMPTY_ORGANIZATION_LIST_MESSAGE
    # "You have not created any organizations yet. Please click the button in the sidebar to create one."
    #

    @javascript @regression @dashboard @dashboardAllOrgs @emptyScreens
    Scenario: I want to view all organizations after logging in
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      And I visit drop down link of item "All Organizations"
      And I wait for 1 seconds
      Then I should see "New Organization"
      And I should be on "https://adstack-stage.adcade.com/organizations"
      And I should see "EMPTY_ORGANIZATION_LIST_MESSAGE"
      And I should see dashboard header and footer components

    #
    # Dashboard: Adcade > All Organizations
    #
    # Create a New Organization:
    # Enter Organization Name (required)
    # Enter Click Macro
    # Enter Cache Buster
    # Enter iFrame Buster
    #
    # btn: Save
    # btn: Save and Go To New Organization
    # btn: Cancel
    #
    # to-do
    #

    @javascript @regression @dashboard @dashboardAllOrg @createOrgModal
    Scenario: I want to see the create new organization modal
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on All Organizations of dashboard stage
      When I press "New Organization"
      Then I should see "Create New Organization"
      And I should see "Save Organization"
      And I should see "Save and Go To Organization"
      And I should see "Cancel"

    @javascript @regression @dashboard @dashboardAllOrg @createOrgModalCancel
    Scenario: I want to create new organization but had to cancel
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on All Organizations of dashboard stage
      When I press "New Organization"
      And I follow "Cancel"
      Then I should not see "Save Organization"

    #
    # Dashboard: Adcade > All Organizations
    # Missing required field, border-color becomes #a94442 (ruby red)
    #

    @javascript @regression @dashboard @dashboardAllOrg @createOrgModalError
    Scenario: I want to create a new organization but I missed required field
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on All Organizations of dashboard stage
      When I press "New Organization"
      And I press "Save Campaign"
      Then the "orgname" field border-color becomes red

    @javascript @regression @dashboard @dashboardAllOrg @createOrgModalSave
    Scenario: I want to create new organization
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on All Organizations of dashboard stage
      When I fill in "orgname" with "myOrg Alberta"
      And I press "Save Organization"
      Then I should see "myOrg Alberta"
      And I should not see "Save Organization"

    @javascript @regression @dashboard @dashboardAllOrg @createOrgModalSaveGoToOrg
    Scenario: I want to create new organization and view it
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I am on All Organizations of dashboard stage
      When I fill in "orgname" with "myOrg BritishColumbia"
      And I fill in "clickmacro" with "%%BCMACRO%%"
      And I fill in "cachebuster" with "%%BCCACHEBUSTER%%"
      And I fill in "iframebuster" with "BCIFRAMEBUSTER"
      And I press "Save and Go To Organization"
      Then I should see "myOrg BritishColumbia"
      And I should see "New Advertiser"
      And I should not see "Save Organization"
      And I should see copyright and version

    #
    # Dashboard: Adcade > All Organizations
    # Archive, Delete
    #
    # Delete Organization:
    # Organization Name
    # Number of Advertisers, Placements
    # Remove organization from delete list
    # Type delete to confirm (required)
    # btn: Delete
    # btn: Cancel
    #    #
    # Archive Warning:
    # Are you sure you want to archive this/these organizations/advertisers/campaigns?
    # btn: Submit
    # btn: Cancel
    #
    # Unarchive Warning:
    # Are you sure you want to unarchive this/these organizations/advertisers/campaigns?
    # btn: Submit
    # btn: Cancel
    #
    # to-do
    #




#
# Scenarios on filling account with campaigns, advertisers, placements
#

    #
    # Dashboard: Dashboard > Campaigns
    #
    # Create a New Campaign:
    # Select an Advertiser Dropdown (required)
    #     Create a New Advertiser
    # Enter Campaign Name (required)
    # Enter Start/End Dates (required)
    # Enter Impression Goals
    # Enter Total Budget
    #
    # btn: Save
    # btn: Save and Go To New Campaign
    # btn: Cancel
    #
    # to-do
    #

    @javascript @regression @dashboard @createCampaignModal
    Scenario: I want to see the create a new campaign modal
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      When I press "New Campaign"
      Then I should see "Create New Campaign"
      And I should see "Save Campaign"
      And I should see "Save and Go To Campaign"
      And I should see "Cancel"

    @javascript @regression @dashboard @createCampaignModalCancel
    Scenario: I want to create a new campaign but had to cancel
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      When I press "New Campaign"
      And I press "Cancel"
      Then I should not see "Save Campaign"

    #
    # Dashboard: Dashboard > Campaigns
    # Missing required field, border-color becomes #a94442 (ruby red)
    #

    @javascript @regression @dashboard @createCampaignModalError
    Scenario: I want to create a new campaign but I missed required field
      Given I am on dashboard stage
      And I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      When I press "New Campaign"
      And I press "Save Campaign"
      Then the "advertiser_dropdown" dropdown border-color becomes red
      And the "campaignname" field border-color becomes red
      And the "startdate" field border-color becomes red
      And the "enddate" field border-color becomes red

    @javascript @regression @dashboard @createCampaignModalSave
    Scenario: I want to create a new campaign
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      When I press "New Campaign"
      And I visit drop down link of item "myAdvertiser Avocado"
      And I fill in "campaign name" with "myCampaign AgnesB"
      And I fill in the "start" date picker with "16/06/2015"
      And I fill in the "end" date picker with "16/07/2015"
      And I fill in "impression goal" with "16,000,000,000"
      And I fill in "total budget" with "160,000"
      And I press "Save Campaign"
      Then I should see "CREATE_SUCCESSFUL_MESSAGE"
      And I should see "myCampaign Aldo"
      And I should not see "Save Campaign"

    #
    # EMPTY_AD_LIST_MESSAGE
    # "You haven't created anything yet."
    #
    @javascript @regression @dashboard @createCampaignModalSaveGoToCampaign @emptyScreens
    Scenario: I want to create a new campaign and view it
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      When I press "New Campaign"
      And I visit drop down link of item "myAdvertiser Blueberry"
      And I fill in "campaign name" with "myCampaign Boss"
      And I fill in the "start" date picker with "21/07/2015"
      And I fill in the "end" date picker with "21/08/2015"
      And I fill in "impression goal" with "210,000,000,000"
      And I press "Save and Go To Campaign"
      Then I should see "CREATE_SUCCESSFUL_MESSAGE"
      And I should see "myCampaign Aldo"
      And I should see "Jul 21, 2015"
      And I should see "Aug 21, 2015"
      And I should see "210,000,000,000"
      And I should see "Add Budget"
      And I should see "New Ad"
      And I should see "EMPTY_AD_LIST_MESSAGE"
      And I should not see "Save Campaign"

    #
    # Dashboard: Dashboard > Campaigns
    # editable fields
    # https://docs.google.com/a/adcade.com/document/d/1zBUvh0lOV-tsRnb0ce-FQqYTL1-YW--IKoKP7k3w2Fs/edit
    # rows: campaign name (required), advertiser (required), start date (required), end date (required)
    # to-do
    #
    # BLOCKER: How to edit a specific campaign if all edit campaign icon are identical? use of ugly xpath or csspath?
    #

    @javascript @regression @dashboard @dashboardCampaignNameEdit
    Scenario: I want to edit the name of an existing campaign
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      When I hover over the element "edit campaign"
      And I press "edit campaign" of "myCampaign AgnesB"
      And I fill in "edit campaign input box" with "myCampaign AgnesB edited"
      And I manually press "enter"
      Then I should see "EDIT_SUCCESSFUL_MESSAGE"
      When I follow "Sylvia"
      And I follow "Dashboard"
      Then I should see "myCampaign AgnesB edited"

    @javascript @regression @dashboard @dashboardAdvertiserEdit
    Scenario: I want to edit the advertiser of an existing campaign
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
# START HERE
      When I hover over the element "edit campaign"
      And I press "edit campaign" of "myCampaign AgnesB"
      And I fill in "edit campaign input box" with "myCampaign AgnesB edited"
      And I manually press "enter"
      Then I should see "EDIT_SUCCESSFUL_MESSAGE"
      When I follow "Sylvia"
      And I follow "Dashboard"
      Then I should see "myCampaign AgnesB edited"


    #
    # Dashboard: Dashboard > Campaigns
    # pagination
    # to-do
    #

    #
    # Dashboard: Dashboard > Campaigns
    # show more entries on the same page
    # to-do
    #

    #
    # Dashboard: Dashboard > Campaigns
    # sort by name, advertiser, start date, end date, last modified in asc or desc (without time)
    # to-do
    #

    #
    # Dashboard: Dashboard > Campaigns
    # duplicate, archive, delete
    #
    # Delete Campaign:
    # Campaign Name
    # Number of Ads, Placements
    # Remove campaign from delete list
    # Type delete to confirm (required)
    # btn: Delete
    # btn: Cancel
    #
    # Archive Warning:
    # Are you sure you want to archive this/these organizations/advertisers/campaigns?
    # btn: Submit
    # btn: Cancel
    #
    # Unarchive Warning:
    # Are you sure you want to unarchive this/these organizations/advertisers/campaigns?
    # btn: Submit
    # btn: Cancel
    #
    # to-do
    #

    #
    # Dashboard: Dashboard > Campaigns
    # check for colour status red=pause, yellow=in production, green=live, blue=complete, grey=archived
    # to-do
    #

    #
    # Dashboard: Dashboard > Campaigns
    # Filters to come after Apr1
    # https://docs.google.com/a/adcade.com/document/d/17Oml5HSSzZDv10JjCxeWVL2O-UkgFlIrm2CGwfqRXl0/edit
    #
    # to-do
    #

    #
    # Dashboard: Dashboard > Advertiser > Campaign
    # pacing to be checked in unit test by Prakash
    # imp goal and total budget pulled from BE
    # to-do
    #

    #
    # Dashboard: Dashboad > Advertiser > Campaign
    #
    # Create a New Ad:
    # Enter Ad Name (required)
    # Enter Start/End Dates (required, pre-populated from campaign dates)
    # Enter Backup URL (required)
    # Enter Impression Pixel
    #
    # btn: Save
    # btn: Save and Go To New Ad
    # btn: Cancel
    #
    # to-do
    #

    #
    # Dashboard: Dashboard > Advertiser > Campaign
    # editable fields
    # https://docs.google.com/a/adcade.com/document/d/1zBUvh0lOV-tsRnb0ce-FQqYTL1-YW--IKoKP7k3w2Fs/edit
    # overview: start date (required), end date (required), impression goal, total budget
    # rows: ad name (required), start date (required), end date (required)
    # to-do
    #

    #
    # Dashboard: Dashboad > Advertiser > Campaign
    # Get Report, Generate Tags, Duplicate, Delete
    #
    # Generate Tags:
    # Campaign Name
    # Ad Name (removable from generate list)
    # Placements (removable from generate list)
    #    when expanded, select text for copy
    # btn: Download Tags
    # btn: Share Tags (see >>Share below)
    # btn: File Type Dropdown
    # btn: Cancel
    #
    # >>Share:
    # Paperclip attachment of file type
    # Enter Email Adresses (required, multiple addresses separated by comma)
    # Enter A Message
    # btn: Send
    # btn: Cancel
    #
    # Share Time Warning:
    # Preparnig document for sharing...
    # loader
    # Don't want to wait? We'll email you a confirmation when your file has sent.
    # btn: OK
    # btn: Cancel
    #
    # Share Confirmation:
    # Your tags/report have/has been shared successfully.
    # btn: Close
    #
    # Download Time Warning:
    # Preparing document for download..
    # loader
    # Don't want to wait? We'll email you a [file type] attachment when it's ready.
    # btn: OK
    # btn: Cancel
    #
    # to-do
    #

    #
    # Dashboard: Dashboad > Advertiser > Campaign
    # Get Report, Generate Tags, Duplicate, Delete
    #
    # Delete Ad
    # Ad Name
    # Number of Placements
    # Remove ad from delete list
    # Type delete to confirm (required)
    # btn: Delete
    # btn: Cancel
    #
    # to-do
    #





    #
    # Dashboard: Dashboard > Advertiser > Campaign > Ad
    # tool tip cases - hover and see more info on Impression Pixel and Progress Bar
    # to-do
    #

    #
    # Dashboard: Dashboad > Advertiser > Campaign > Ad
    #
    # Create a New Placement:
    # Enter Placement Name (required)
    # Enter Backup URL (required, auto-completed if one exists at ad level)
    # Enter Impression Pixel (auto-completed if one exists at ad level)
    # Enter Click Macro (auto-completed if one exists at Org level)
    # Enter Cache Buster (auto-completed if one exists at Org level)
    # Enter iFrame Buster (auto-completed if one exists at Org level)
    #
    # btn: Save
    # btn: Save and Review New Placement
    # btn: Cancel
    #
    # to-do
    #

    #
    # Dashboard: Dashboard > Advertiser > Campaign > Ad
    # editable fields
    # https://docs.google.com/a/adcade.com/document/d/1zBUvh0lOV-tsRnb0ce-FQqYTL1-YW--IKoKP7k3w2Fs/edit
    # overview: backup url (required), impression pixel
    # rows: placement name (required), backup url (inherited from ad, required), impression pixel (inherited from ad)
    # to-do
    #
    # Backup URL Update:
    # Enter NEw Backup URL (required)
    # Remove placement from update list
    # Are you sure you want to update the backup URL for these placements?
    # btn: Submit
    # btn: Cancel
    #

    #
    # Dashboard: Dashboard > Advertiser > Campaign > Ad
    # updated of backup URL on ad level, see warning that backup url will not be affecting existing ads and only the newly created ads
    # to-do
    #
    # Backup URL Update:
    # Enter NEw Backup URL (required)
    # Remove placement from update list
    # Are you sure you want to update the backup URL for these placements?
    # btn: Submit
    # btn: Cancel
    #

    #
    # Dashboard: Dashboad > Advertiser > Campaign > Ad
    # Get Report, Generate Tags, Preview Creative, Duplicate, Delete
    #
    # Generate Tags:
    # Campaign Name
    # Ad Name (removable from generate list)
    # Placements (removable from generate list)
    #    when expanded, select text for copy
    # btn: Download Tags
    # btn: Share Tags (see >>Share below)
    # btn: File Type Dropdown
    # btn: Cancel
    #
    # >>Share:
    # Paperclip attachment of file type
    # Enter Email Adresses (required, multiple addresses separated by comma)
    # Enter A Message
    # btn: Send
    # btn: Cancel
    #
    # Share Time Warning:
    # Preparnig document for sharing...
    # loader
    # Don't want to wait? We'll email you a confirmation when your file has sent.
    # btn: OK
    # btn: Cancel
    #
    # Share Confirmation:
    # Your tags/report have/has been shared successfully.
    # btn: Close
    #
    # Download Time Warning:
    # Preparing document for download..
    # loader
    # Don't want to wait? We'll email you a [file type] attachment when it's ready.
    # btn: OK
    # btn: Cancel
    #
    # to-do
    #


    #
    # Dashboard: Dashboad > Advertiser > Campaign > Ad
    # Get Report, Generate Tags, Preview Creative, Duplicate, Delete
    #
    # Delete Placement
    # Placement Name
    # Remove placement from delete list
    # Type delete to confirm (required)
    # btn: Delete
    # btn: Cancel
    #
    # to-do
    #




    #
    # Dashboard: Dashboard > Advertiser > Campaign > Ad > Placement
    # editable fields
    # https://docs.google.com/a/adcade.com/document/d/1zBUvh0lOV-tsRnb0ce-FQqYTL1-YW--IKoKP7k3w2Fs/edit
    # overview: backup url (inherited from ad, required), impression pixel (inherited from ad), click macro (inherited from org), cache buster (inherited from org), iframe buster (inherited from org), custom key name, custom key value
    # to-do
    #
    # Backup URL Update:
    # Enter New Backup URL (required)
    # Remove placement from update list
    # Are you sure you want to update the backup URL for these placements?
    # btn: Submit
    # btn: Cancel
    #




    #
    # Dashboard: Dashboard > Advertiser
    # checkboxes to view extra functions
    # to-do
    #

    #
    # Dashboard: Dashboard > Advertiser
    # editable fields
    # https://docs.google.com/a/adcade.com/document/d/1zBUvh0lOV-tsRnb0ce-FQqYTL1-YW--IKoKP7k3w2Fs/edit
    # overview: vertical (required)
    # rows: campaign name (required), start date (required), end date (required)
    # to-do
    #



    #
    # Dashboard: Dashboard > Advertiser
    #
    # to-do
    #

    #
    # Dashboard: Dashboard > Advertiser
    # extra function acted on Advertiser duplicate / arhive
    # to-do
    #









    #
    # Dashboard: Adcade (Organization) > Billing
    # editable fields
    # https://docs.google.com/a/adcade.com/document/d/1zBUvh0lOV-tsRnb0ce-FQqYTL1-YW--IKoKP7k3w2Fs/edit
    # overview: CPM (only Adcade super user, required), test impressions (only Adcade super user, required), platform agreement upload (only Adcade super user, required)
    # company info: company name (required), phone (required), address (required), city (required), state (required), zip (required), country (required)
    # billing contact: first name (required), last name (required), email (required)
    # to-do
    #






    #
    # Dashboard: Adcade (Organization) > Users
    #
    # Create a User:
    # Enter User Email Address (required)
    #    Display loader while searching db for a match
    # Enter User First Name (required, auto-completed after email field blur if match is returned)
    # Enter User Last Name (required, auto-completed after email field blur if match is returned)
    # Select User's Role Dropdown (required)
    #    Admin
    #    User
    # CTA Add To Another Organization (display only if admin belongs to other orgs at the admin level)
    #    Select Organization (from what admin also belongs to)
    #    Select User's Role
    #
    # btn: Save
    # btn: Add Another User
    # btn: Cancel
    #
    # to-do
    #


    #
    # Dashboard: Adcade (Organization) > Users
    # editable fields
    # https://docs.google.com/a/adcade.com/document/d/1zBUvh0lOV-tsRnb0ce-FQqYTL1-YW--IKoKP7k3w2Fs/edit
    # rows: first name (required), last name (required), role (required)
    # to-do
    #








    #
    # Dashboard: Reporting
    # default to Visualizations
    # https://docs.google.com/a/adcade.com/document/d/1riWBRdoRZ2YfiW9q5lpYCtr3SDxImm6AqM_anawIrQw/edit
    #
    # to-do
    #


    #
    # Dashboard: Reporting > Visualizations
    # to-do
    #


    #
    # Dashboard: Reporting > Reports
    # to-do
    #

    #
    # Dashboard: Reporting > Reports
    # - download report format - excel, pdf, plain text
    # to-do
    #




    #
    # Dashboard: header & footer
    # - consistent throughout site - Help, Feedback, copyright
    # to-do
    #
    # Feedback:
    # Bug/Feature Request/General Feedback radio buttons (require)
    # Enter Summary line (required)
    # Please provide a detailed description of your feedback message box (required)
    # btn: Submit
    # btn: Cancel
    #
    # Feedback Confirmation:
    # We've received your feedback, thanks!
    # btn: Close
    #





    #
    # Dashboard: Content width 1280 fixed and centered
    # to-do
    #



#
# Dashboard: Type of Users
# Regular Users / Admin / Super Users
# to-do
#

#
# Dashboard: Type of Users
# Regular Users / Admin / Super Users
# - log in as each and what they should see
# to-do
#

#
# Dashboard: Type of Users
# Regular Users / Admin / Super Users
# - verify special features NOT accessible to each
# e.g. regular users do not see billing
# to-do
#

#
# Dashboard: Type of Users
# Regular Users / Admin / Super Users
# - execute action specific to each
# e.g. admin can add users
# to-do
#







#
# Dashboard: Roles and Permissions
# Regular Users / Admin / Super Users
# to-do
#



















#
# MANUAL TESTING REQUIRED
# - Sync with Prakash to set up for testing
#

    #
    # Scenario: Session Expire
    #
    # Set Up: Get Prakash to set up session expire after 10 seconds instead of the default 60 minutes
    #
    # Expected pop up:
    # You still there?
    # Your session is about to expire. Do you want to continue working?
    # btn Yes
    # btn No
    #
    @manual
    Scenario: Session Expire
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 5 seconds
      Then I should not see "Your session is about to expire"
      When I wait for 7 seconds
      Then I should see "Your session is about to expire"
      When I press "Yes"
      Then I should be on "https://adstack-stage.adcade.com/dashboard"
      When I wait for 12 seconds
      Then I should see "Your session is about to expire"
      When I press "No"
      Then I should be on "https://adstack-stage.adcade.com/login"


    #
    # Dashboard: Unexpected error handling
    #
    # Set Up: Get Prakash to throw some random error that gets caught to show this message after your account is logged in
    #
    # Expected pop up:
    # Oops. Something went wrong. Our engineers have been notified and are working to resolve the problem.
    # btn Close
    #
    @manual
    Scenario: Session Expire
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      Then I should see "something went wrong"
      When I press "Close"
      Then I should be on "https://adstack-stage.adcade.com/dashboard"




#
# TEST
#
    @thisworks @javascript @dashboardUpdateProfile
    Scenario: Testing Gherkin code
      Given I am on dashboard stage
      When I authenticate as "sl@adcade.com" using "Qwerty!23"
      And I wait for 2 seconds
      Then I should see "Sylvia"
      When I visit drop down link of item "Profile"
      And I wait for 1 seconds
      Then I should see "Profile Information"
      When I set browser window size to "1280" x "800"
      And I wait for 2 seconds
#      And I enter value "1234567890" into csspath field "body > div.container.ng-scope > div > div > div:nth-child(2) > div > div > div:nth-child(1) > div:nth-child(2) > div > form > div:nth-child(4) > div.col-sm-10.value > input"
And I enter value "1234567890" into xpath field "/html/body/div[2]/div/div/div[2]/div/div/div[1]/div[2]/div/form/div[4]/div[2]/input"
      And I wait for 1 seconds
      Then I should see "1234567890"
