Feature: I want to test the help-center

  As a tester
  I want to test the help-center
  So all features and functionality behave as expected

    @regression @helpCenter @javascript @unauthorizedHC
    Scenario Outline: I want make requests as an unauthenticated user
      Given I am on help center
      And I wait for 2 seconds
      Then I should see "<link>"
      When I follow "<link>"
      And I should be on "<expectedUrl>"
      And the response should contain "<expectedText>"

    Examples:
    | link | expectedUrl | expectedText |
    | Help Center | http://localhost:3000/login?url= | Please login to access this page. |
    | Visual Editor | http://localhost:3000/login?url=/editor | Please login to access this page. |
    | Dashboard | http://localhost:3000/login?url=/dashboard | Please login to access this page. |
    | AdScript | http://localhost:3000/login?url=/adscript | Please login to access this page. |
    | Resource Center | http://localhost:3000/login?url=/downloads | Please login to access this page. |


    @regression @helpCenter @javascript @HC
    Scenario Outline: I want to log in as an authenticated user
      Given I am on help center
      And I am authenticated as "sajjad@adcade.com" using "Knight22"
      Then I should see "<expectedText>"
      And I should see help center header and footer components
      When I follow "Sign out"
      Then I should be on help center
      And I should see "Login"

    Examples:
    | expectedText |
    | Get Started |
    | Creating with the Visual Editor |
    | Using the Dashboard |
    | View AdScript Reference |
    | Download Components |
    | Download Templates |
    | What are you waiting for? |
    | Get Started with your tutorials by downloading the Visual Builder and logging into the Ad Manager.|


    @regression @helpCenter @javascript @HCLinks
    Scenario: I want to follow links via the dashboard
      Given I am on help center
      And I am authenticated as "sajjad@adcade.com" using "Knight22"
      When I follow "editor-download"
      Then I should see "Visual Editor Download"
      When I move backward one page
      And I follow "dashboard-login"
      Then I should be on "https://adstack.adcade.com/login"
      And I should see "Login"
      When I move backward one page
      Then the response should contain "What are you looking for?"
      When I follow "Creating with the Visual Editor"
      Then I should see "Visual Editor"
      When I move backward one page
      And I follow "Using the Dashboard"
      Then I should see "Dashboard"
      When I move backward one page
      And I follow "Download Components"
      Then I should see "COMPONENTS"
      And I should see "TEMPLATES"
      When I move backward one page
      And I follow "Download Templates"
      Then I should see "COMPONENTS"
      And I should see "TEMPLATES"
      When I follow "Feedback"
      Then I should see "Provide Feedback"
      And I should see help center header and footer components

    @regression @helpCenter @javascript @HCSearch
    Scenario Outline: I want to search via help center
      Given I am on "http://localhost:3000/"
      And I am authenticated as "sajjad@adcade.com" using "Knight22"
      When I fill in "search" with "<searchValue>"
      And I press "search-button"
      Then I should be on "<expectedURL>"

      Examples:
        | searchValue | expectedURL |
        | test | http://localhost:3000/search?search=test |
        | adscript | http://localhost:3000/search?search=adscript |
        | dashboard | http://localhost:3000/search?search=dashboard |
        | tween | http://localhost:3000/search?search=tween |

    @regression @helpCenter @javascript @HCFeedback
    Scenario Outline: I want to send feedback from help center
      Given I am on "http://localhost:3000/"
      And I am authenticated as "sajjad@adcade.com" using "Knight22"
      When I go to "http://localhost:3000/feedback"
      And I fill in "email" with "<email>"
      And I fill in "subject" with "<subject>"
#      And I select "<option>" from "feedback-field"
      And I fill in "description" with "<description>"
      When I press "Send"
      Then I should see "<expectedOutcome>"
      And I should see help center header and footer components

      Examples:
        | email | subject | option | description | expectedOutcome |
        | sajjad@adcade.com | Testing Feedback, Regression | Bug | Some text describing feedback context | Thanks for your feedback! |
        | sajjad@adcade.com | Testing Feedback, Regression | Feature Request | Some text describing feedback context | Thanks for your feedback! |
        | sajjad@adcade.com | Testing Feedback, Regression | General Feedback | Some text describing feedback context | Thanks for your feedback! |

    @regression @helpCenter @javascript @HCDownloads
    Scenario: I want to view components and templates from help center
      Given I am on "http://localhost:3000/"
      And I am authenticated as "sajjad@adcade.com" using "Knight22"
      When I go to "http://localhost:3000/downloads"
      Then I should see "Components"
      And I should see "Templates"
      When I follow "cmpt-btn"
      And I wait for 2 seconds
      Then I should see "Component Instructions"
      And I should see "How to Use"
      When I follow "tmpl-btn"
      And I wait for 2 seconds
      Then I should see "Template Instructions"
      And I should see "How to Use"

    @regression @helpCenterCMS @javascript @HCCMSLogin
    Scenario: I want to log in to help center CMS
      Given I am on "http://localhost:3000/keystone"
      Then I should see "Please login to access this page. "
      When I authenticate as "apappas@adcade.com" using "adcade42"
      And I wait for 2 seconds
      Then I should see "Manage"
      And I should see "Types"
      And I should see "Shapes"
      And I should see "Properties"
      And I should see "Methods"
      And I should see "Utilities"
      And I should see "Sections"
      And I should see "Pages"
      And I should see "Downloads"
      And I should see "Download Filters"
      And I should see "Editor Downloads"
      And I should see "Users"
      And I should see help center CMS header and footer components

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSCRTypes
    Scenario Outline: I want to create type documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/types"
      And I wait for 2 seconds
      When I press "Create Type"
      Then I should see "New Type"
      And I should see "Create"
      And I should see "cancel"
      When I press "cancel"
      Then I should see "Create Type"
      When I press "Create Type"
      And I fill in "name" with "<typeName>"
      And I press "Create"
      Then I should see "New Type <typeName> created."
      And I should see create type view elements
      When I press "Save"
      Then I should see "Your changes have been saved."
      And I should see help center CMS header and footer components

    Examples:
      | typeName |
      | testType1 |
      | testType2 |
      | testType3 |
      | testType4 |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSDTypes
    Scenario Outline: I want to delete type documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/types"
      And I wait for 2 seconds
      Then I should see "<typeName>"
      When I follow "<typeName>"
      And I follow "delete type"
      Then I should see "Are you sure you want to delete this type?" in popup
      When I confirm the popup
      And I go to "http://localhost:3000/keystone/types"
      Then I should not see "<typeName>"
      And I should see help center CMS header and footer components

    Examples:
      | typeName |
      | testType1 |
      | testType2 |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSUTypes
    Scenario Outline: I want to update type documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/types"
      And I wait for 2 seconds
      Then I should see "<typeName>"
      When I follow "<typeName>"
      And I fill in "name" with "<typeNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "http://localhost:3000/keystone/types"
      Then I should see "<typeNameUpdate>"
      And I should see help center CMS header and footer components

    Examples:
      | typeName | typeNameUpdate |
      | testType3 | testType3Update |
      | testType4 | testType4update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSFilterTypes
    Scenario Outline: I want to filer type documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/types"
      And I wait for 2 seconds
      Then I should see "<typeName>"
      And the response should contain "Search types"
      And the response should contain "Add Filter "
      And the response should contain "Columns "
      And the response should contain "Download"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button'
      Then I should see "Name"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[2]/button'
      Then I should see "Name"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[1]/a'
      Then I should see "Download a .csv of 2 types?" in popup
      When I confirm the popup
      Then I should be on "http://localhost:3000/keystone/types"
      And I should see help center CMS header and footer components

    Examples:
      | typeName |
      | testType3 |
      | testType4 |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSSearchTypes
    Scenario Outline: I want to search type documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/types"
      And I wait for 2 seconds
      Then I should see "<typeName>"
      And the response should contain "search"
      When I fill in "search" with "testType"
      Then I should see "2 Types"
      When I click on the element with xpath '//*[@id="body"]/div/div[2]/h1/div/span[2]/a'
      Then I should see "Display Order (inverted)"
      And I should see "Name"
      And I should see "<typeName>"
      And I should see help center CMS header and footer components

    Examples:
      | typeName |
      | testType3Update |
      | testType4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSCRShapes
    Scenario Outline: I want to create shapes documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/shapes"
      And I wait for 2 seconds
      When I press "Create Shape"
      Then I should see "New Shape"
      And I should see "Create"
      And I should see "cancel"
      When I press "cancel"
      Then I should see "Create Shape"
      When I press "Create Shape"
      And I fill in "title" with "<shapeName>"
      And I press "Create"
      Then I should see "New Shape <shapeName> created."
      And I should see create shape view elements
      When I click on the element with xpath '//*[@id="s2id_autogen1"]/a'
      And I click on the element with xpath '//*[@id="select2-drop"]/ul/li[2]/div'
      And I fill in "content.description" with "<description>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      And I should see help center CMS header and footer components

    Examples:
      | shapeName | description |
      | testShape1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testShape2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testShape3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testShape4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSDShapes
    Scenario Outline: I want to delete type documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/shapes"
      And I wait for 2 seconds
      Then I should see "<shapeName>"
      When I follow "<shapeName>"
      And I follow "delete shape"
      Then I should see "Are you sure you want to delete this shape?" in popup
      When I confirm the popup
      And I go to "http://localhost:3000/keystone/shapes"
      Then I should not see "<shapeName>"
      And I should see help center CMS header and footer components

    Examples:
      | shapeName |
      | testShape1 |
      | testShape2 |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSUShapes
    Scenario Outline: I want to update shapes documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/shapes"
      And I wait for 2 seconds
      Then I should see "<shapeName>"
      When I follow "<shapeName>"
      And I fill in "title" with "<shapeNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "http://localhost:3000/keystone/shapes"
      Then I should see "<shapeNameUpdate>"
      And I should see help center CMS header and footer components

    Examples:
      | shapeName | shapeNameUpdate |
      | testShape3 | testShape3Update |
      | testShape4 | testShape4update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSFilterShapes
    Scenario Outline: I want to filer shapes documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/shapes"
      And I wait for 2 seconds
      Then I should see "<typeName>"
      And the response should contain "Search shapes"
      And the response should contain "Add Filter "
      And the response should contain "Columns "
      And the response should contain "Download"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button'
      Then I should see "Title"
      And I should see "State"
      And I should see "Type"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[2]/button'
      Then I should see "Title"
      And I should see "State"
      And I should see "Type"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[1]/a'
      Then I should see "Download a .csv of 2 shapes?" in popup
      When I confirm the popup
      Then I should be on "http://localhost:3000/keystone/shapes"
      And I should see help center CMS header and footer components

    Examples:
      | typeName |
      | testShape3Update |
      | testShape4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSSearchShapes
    Scenario Outline: I want to search shapes documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/shapes"
      And I wait for 2 seconds
      Then I should see "<shapeName>"
      And the response should contain "search"
      When I fill in "search" with "<shapeName>"
      Then I should see "2 Shapes"
      When I click on the element with xpath '//*[@id="body"]/div/div[2]/h1/div/span[2]/a'
      Then I should see "Title (descending)"
      And I should see "State"
      And I should see "Content Description"
      And I should see "<shapeName>"
      And I should see help center CMS header and footer components

    Examples:
      | shapeName |
      | testShape3Update |
      | testShape4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSCRProperties
    Scenario Outline: I want to create properties documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/properties"
      And I wait for 2 seconds
      When I press "Create Property"
      Then I should see "New Property"
      And I should see "Create"
      And I should see "cancel"
      When I press "cancel"
      Then I should see "Create Property"
      When I press "Create Property"
      And I fill in "title" with "<propName>"
      And I press "Create"
      Then I should see "New Property <propName> created."
      And I should see create property view elements
      When I click on the element with xpath '//*[@id="s2id_autogen1"]/a'
      And I click on the element with xpath '//*[@id="select2-drop"]/ul/li[2]/div'
      And I fill in "content.description" with "<description>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      And I should see help center CMS header and footer components

    Examples:
      | propName | description |
      | testProp1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testProp2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testProp3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testProp4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSDProperties
    Scenario Outline: I want to delete properties documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/properties"
      And I wait for 2 seconds
      Then I should see "<propName>"
      When I follow "<propName>"
      And I follow "delete property"
      Then I should see "Are you sure you want to delete this property?" in popup
      When I confirm the popup
      And I go to "http://localhost:3000/keystone/properties"
      Then I should not see "<shapeName>"
      And I should see help center CMS header and footer components

    Examples:
      | propName |
      | testProp1 |
      | testProp2 |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSUProperties
    Scenario Outline: I want to update properties documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/properties"
      And I wait for 2 seconds
      Then I should see "<propName>"
      When I follow "<propName>"
      And I fill in "title" with "<propNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "http://localhost:3000/keystone/properties"
      Then I should see "<propNameUpdate>"
      And I should see help center CMS header and footer components

    Examples:
      | propName | propNameUpdate |
      | testProp3 | testProp3Update |
      | testProp4 | testProp4update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSFilterProperties
    Scenario Outline: I want to filer properties documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/properties"
      And I wait for 2 seconds
      Then I should see "<propName>"
      And the response should contain "Search properties"
      And the response should contain "Add Filter "
      And the response should contain "Columns "
      And the response should contain "Download"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button'
      Then I should see "Title"
      And I should see "State"
      And I should see "Type"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[2]/button'
      Then I should see "Title"
      And I should see "State"
      And I should see "Type"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[1]/a'
      Then I should see "Download a .csv of 2 properties?" in popup
      When I confirm the popup
      Then I should be on "http://localhost:3000/keystone/properties"
      And I should see help center CMS header and footer components

    Examples:
      | propName |
      | testProp3Update |
      | testProp4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSSearchProperties
    Scenario Outline: I want to search properties documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/properties"
      And I wait for 2 seconds
      Then I should see "<propName>"
      And the response should contain "search"
      When I fill in "search" with "<propName>"
      Then I should see "2 Properties"
      When I click on the element with xpath '//*[@id="body"]/div/div[2]/h1/div/span[2]/a'
      Then I should see "Title (descending)"
      And I should see "State"
      And I should see "Content Description"
      And I should see "<propName>"
      And I should see help center CMS header and footer components

    Examples:
      | propName |
      | testProp3Update |
      | testProp4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSCRMethods
    Scenario Outline: I want to create methods documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/methods"
      And I wait for 2 seconds
      When I press "Create Method"
      Then I should see "New Method"
      And I should see "Create"
      And I should see "cancel"
      When I press "cancel"
      Then I should see "Create Method"
      When I press "Create Method"
      And I fill in "title" with "<methodName>"
      And I press "Create"
      Then I should see "New Method <methodName> created."
      And I should see create method view elements
      When I click on the element with xpath '//*[@id="s2id_autogen1"]/a'
      And I click on the element with xpath '//*[@id="select2-drop"]/ul/li[2]/div'
      And I fill in "content.description" with "<description>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      And I should see help center CMS header and footer components

    Examples:
      | methodName | description |
      | testMethod1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testMethod2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testMethod3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testMethod4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSDMethods
    Scenario Outline: I want to delete methods documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/methods"
      And I wait for 2 seconds
      Then I should see "<methodName>"
      When I follow "<methodName>"
      And I follow "delete method"
      Then I should see "Are you sure you want to delete this method?" in popup
      When I confirm the popup
      And I go to "http://localhost:3000/keystone/methods"
      Then I should not see "<methodName>"
      And I should see help center CMS header and footer components

    Examples:
      | methodName |
      | testMethod1 |
      | testMethod2 |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSUMethods
    Scenario Outline: I want to update methods documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/properties"
      And I wait for 2 seconds
      Then I should see "<methodName>"
      When I follow "<methodName>"
      And I fill in "title" with "<methodNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "http://localhost:3000/keystone/properties"
      Then I should see "<methodNameUpdate>"
      And I should see help center CMS header and footer components

    Examples:
      | methodName | methodNameUpdate |
      | testMethod3 | testMethod3Update |
      | testMethod4 | testMethod4update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSFilterMethods
    Scenario Outline: I want to filer methods documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/methods"
      And I wait for 2 seconds
      Then I should see "<methodName>"
      And the response should contain "Search methods"
      And the response should contain "Add Filter "
      And the response should contain "Columns "
      And the response should contain "Download"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button'
      Then I should see "Title"
      And I should see "State"
      And I should see "Type"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[2]/button'
      Then I should see "Title"
      And I should see "State"
      And I should see "Type"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[1]/a'
      Then I should see "Download a .csv of 2 methods?" in popup
      When I confirm the popup
      Then I should be on "http://localhost:3000/keystone/methods"
      And I should see help center CMS header and footer components

    Examples:
      | methodName |
      | testMethod3Update |
      | testMethod4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSSearchMethods
    Scenario Outline: I want to search methods documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/methods"
      And I wait for 2 seconds
      Then I should see "<methodName>"
      And the response should contain "search"
      When I fill in "search" with "<methodName>"
      Then I should see "2 Methods"
      When I click on the element with xpath '//*[@id="body"]/div/div[2]/h1/div/span[2]/a'
      Then I should see "Title (descending)"
      And I should see "State"
      And I should see "Content Description"
      And I should see "<methodName>"
      And I should see help center CMS header and footer components

    Examples:
      | methodName |
      | testMethod3Update |
      | testMethod4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSCRUtilities
    Scenario Outline: I want to create utilities documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/utilities"
      And I wait for 2 seconds
      When I press "Create Utility"
      Then I should see "New Utility"
      And I should see "Create"
      And I should see "cancel"
      When I press "cancel"
      Then I should see "Create Utility"
      When I press "Create Utility"
      And I fill in "title" with "<utilityName>"
      And I press "Create"
      Then I should see "New Utility <utilityName> created."
      And I should see create utility view elements
      When I click on the element with xpath '//*[@id="s2id_autogen1"]/a'
      And I click on the element with xpath '//*[@id="select2-drop"]/ul/li[2]/div'
      And I fill in "content.description" with "<description>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      And I should see help center CMS header and footer components

    Examples:
      | utilityName | description |
      | testUtil1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testUtil2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testUtil3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
      | testUtil4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSDUtilities
    Scenario Outline: I want to delete utilities documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/utilities"
      And I wait for 2 seconds
      Then I should see "<utilityName>"
      When I follow "<utilityName>"
      And I follow "delete utility"
      Then I should see "Are you sure you want to delete this utility?" in popup
      When I confirm the popup
      And I go to "http://localhost:3000/keystone/utilities"
      Then I should not see "<utilityName>"
      And I should see help center CMS header and footer components

    Examples:
      | utilityName |
      | testUtil1 |
      | testUtil2 |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSUUtilities
    Scenario Outline: I want to update utilities documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/utilities"
      And I wait for 2 seconds
      Then I should see "<utilityName>"
      When I follow "<utilityName>"
      And I fill in "title" with "<utilityNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "http://localhost:3000/keystone/utilities"
      Then I should see "<utilityNameUpdate>"
      And I should see help center CMS header and footer components

    Examples:
      | utilityName | utilityNameUpdate |
      | testUtil3 | testUtil3Update |
      | testUtil4 | testUtil4update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSFilterUtilities
    Scenario Outline: I want to filer utilities documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/utilities"
      And I wait for 2 seconds
      Then I should see "<utilityName>"
      And the response should contain "Search utilities"
      And the response should contain "Add Filter "
      And the response should contain "Columns "
      And the response should contain "Download"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button'
      Then I should see "Title"
      And I should see "State"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[2]/button'
      Then I should see "Title"
      And I should see "State"
      When I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[2]/div[1]/a'
      Then I should see "Download a .csv of 2 utilities?" in popup
      When I confirm the popup
      Then I should be on "http://localhost:3000/keystone/utilities"
      And I should see help center CMS header and footer components

    Examples:
      | utilityName |
      | testUtil3Update |
      | testUtil4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSSearchUtilities
    Scenario Outline: I want to search methods documentation
      Given I authenticate as "apappas@adcade.com" using "adcade42"
      And I am on "http://localhost:3000/keystone/utilities"
      And I wait for 2 seconds
      Then I should see "<utilityName>"
      And the response should contain "search"
      When I fill in "search" with "<utilityName>"
      Then I should see "2 Utilities"
      When I click on the element with xpath '//*[@id="body"]/div/div[2]/h1/div/span[2]/a'
      Then I should see "Title (descending)"
      And I should see "State"
      And I should see "Content Description"
      And I should see "<utilityName>"
      And I should see help center CMS header and footer components

    Examples:
      | utilityName |
      | testUtil3Update |
      | testUtil4Update |
