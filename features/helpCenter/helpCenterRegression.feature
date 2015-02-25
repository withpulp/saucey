Feature: I want to test the help-center

  As a tester
  I want to test the help-center
  So all features and functionality behave as expected

#HELP CENTER FRONT END

    @javascript @regression @helpCenter @unauthorizedHC
    Scenario Outline: I want make requests as an unauthenticated user
      Given I am on help center
      Then I should see "<link>"
      When I follow "<link>"
      And I should be on "<expectedUrl>"
      And the response should contain "<expectedText>"

    Examples:
    | link | expectedUrl | expectedText |
    | Visual Editor | https://help-stage.adcade.com/login?url=/editor | Please login to access this page. |
    | Dashboard | https://help-stage.adcade.com/login?url=/dashboard | Please login to access this page. |
    | AdScript | https://help-stage.adcade.com/login?url=/adscript | Please login to access this page. |

    @javascript @regression @helpCenter @authorizedHC
    Scenario Outline: I want to log in as an authenticated user
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on help center
      Then I should see "<expectedText>"
      And I should see help center header and footer components

    Examples:
    | expectedText |
    | VISUAL EDITOR |
    | DASHBOARD |
    | ADSCRIPT |
    | Download the Visual Editor |
    | View the Visual Editor Guide |
    | View the Dashboard Guide |
    | Use the Dashboard |
    | View the API Reference |
    | Download Templates & Components |

    @javascript @regression @helpCenter @helpCenterLinksTop
    Scenario Outline: I want to follow links via the dashboard
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on help center
      When I follow "<link>"
      Then I should see "<expectedText>"
      And I should be on "<expectedURL>"
      And I should see help center header and footer components

    Examples:
    | link | expectedText | expectedURL |
    | Download | Visual Editor | https://help-stage.adcade.com/downloads |

    @javascript @regression @helpCenter @helpCenterLinksBottom
    Scenario Outline: I want to follow links via the dashboard
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on help center
      And I scroll to the bottom
      When I follow "<link>"
      Then I should see "<expectedText>"
      And I should be on "<expectedURL>"
      And I should see help center header and footer components

    Examples:
    | link | expectedText | expectedURL |
    | Download the Visual Editor | VISUAL EDITOR | https://help-stage.adcade.com/downloads |
    | View the Dashboard Guide | INTRODUCTION | https://help-stage.adcade.com/editor |
    | View the API Reference | ADSCRIPT | https://help-stage.adcade.com/adscript |
    | Download Templates & Components | DOWNLOAD | https://help-stage.adcade.com/downloads#templates |

    @javascript @regression @helpCenter @helpCenterDashboard
    Scenario Outline: I want to follow links via the dashboard
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on help center
      And I scroll to the bottom
      When I follow "<link>"
      And I should be on "<expectedURL>"
      Then I should see "<expectedText>"

    Examples:
    | link | expectedText | expectedURL |
    | Use the Dashboard | Powered By | https://adstack.adcade.com/login |

    @javascript @regression @helpCenter @helpCenterSearch
    Scenario Outline: I want to search via help center
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on help center
      When I fill in "search" with "<searchValue>"
      And I press "sidebar-search-button"
      Then I should be on "<expectedURL>"

    Examples:
    | searchValue | expectedURL |
    | test | https://help-stage.adcade.com/search?search=test |
    | adscript | https://help-stage.adcade.com/search?search=adscript |
    | dashboard | https://help-stage.adcade.com/search?search=dashboard |
    | tween | https://help-stage.adcade.com/search?search=tween |

    @javascript @regression @helpCenter @helpCenterFeedback
    Scenario Outline: I want to send feedback from help center
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on help center feedback
      And I fill in "email" with "<email>"
      And I fill in "subject" with "<subject>"
      And I select "<option>" from "type"
      And I fill in "desc" with "<description>"
      And I press "Send"
      And I wait for 1 seconds
      Then I should see "<expectedOutcome>"
      And I should see help center header and footer components

    Examples:
    | email | subject | option | description | expectedOutcome |
    | apappas@adcade.com | Some context for feedback !@#$%^&*() | Bug | Some context for description !@#$%^&*() | Thanks for your feedback! |
    | marcus@adcade.com | More context for feedback !@#$%^&*() | Bug | More context for description !@#$%^&*() | Thanks for your feedback! |
    | sl@adcade.com | MOAR context for feedback !@#$%^&*() | Bug | MOAR context for description !@#$%^&*() | Thanks for your feedback! |

    @javascript @regression @helpCenter @helpCenterDownloads
    Scenario Outline: I want to view components and templates from help center
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      When I go to "https://help-stage.adcade.com/downloads"
      And I follow "<link>"
      Then I should see "<expectedText>"
      And I should see "<expectedContent>"
      And I should see "<expectedContent2>"
      And I should see help center header and footer components

    Examples:
    | link | expectedText | expectedContent | expectedContent2 |
    | Components | COMPONENTS | COMPONENTS | JavaScript files that extend AdScript, allowing easy use and reuse of custom functionality |
    | Templates | TEMPLATES | VISUAL EDITOR | Powered by AdScript |

#HELP CENTER BACK END -- KEYSTONE

    @javascript @regression @helpCenter @keystone @keystoneLogin
    Scenario Outline: I want to log in to Keystone
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      Then I should see "<expectedContent>"
      And I should see Keystone header and footer components

    Examples:
    | expectedContent |
    | manage |
    | Types |
    | Shapes |
    | Properties |
    | Methods |
    | Utilities |
    | Sections |
    | Pages |
    | Downloads |
    | Download Filters |
    | Editor Downloads |
    | Users |

  #KEYSTONE -- TYPES

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTypes
    Scenario Outline: I want to create type documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      When I press "Create Type"
      Then I should see create type view elements
      When I press "cancel"
      And I fill in "search" with "<typeName>"
      Then I should not see "<typeName>"
      When I press "Create Type"
      And I fill in "name" with "<typeName>"
      And I press "Create"
      Then I should see "New Type <typeName> created."
      And I should see edit type view elements
      When I press "Save"
      Then I should see "Your changes have been saved."
      And I should see Keystone header and footer components

    Examples:
    | typeName |
    | testType1 |
    | testType2 |
    | testType3 |
    | testType4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTypes
    Scenario Outline: I want to delete type documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      When I fill in "search" with "<typeName>"
      And I press "Search"
      Then I should see "<typeName>"
      And I should see edit type view elements
      When I follow "delete type"
      Then I should see "Are you sure you want to delete this type?" in popup
      When I confirm the popup
      And I go to "https://help-stage.adcade.com/keystone/types"
      And I fill in "search" with "<typeName>"
      And I press "Search"
      Then I should see "No types found"
      And I should see Keystone header and footer components

    Examples:
    | typeName |
    | testType1 |
    | testType2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTypes
    Scenario Outline: I want to update type documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      When I fill in "search" with "<typeName>"
      And I press "Search"
      Then I should see "<typeName>"
      And I should see edit type view elements
      When I fill in "name" with "<typeNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/types"
      And I fill in "search" with "<typeName>"
      And I press "Search"
      Then I should see "No types found"
      When I go to "https://help-stage.adcade.com/keystone/types"
      And I fill in "search" with "test"
      Then I should not see "<typeName>"
      And I should see "<typeNameUpdate>"
      And I should see Keystone header and footer components

    Examples:
    | typeName | typeNameUpdate |
    | testType3 | testTypeUpdate3 |
    | testType4 | testTypeupdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTypes
    Scenario Outline: I want to filter type documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      Then I should see "<typeName>"
      When I click on the element with xpath '<filter>'
      Then I should see filter type view elements
      When I click on the element with xpath '<name>'
      Then I should see add filter elements
      When I click on the element with xpath '<column>'
      Then I should see filter type view elements
      When I click on the element with xpath '<download>'
      And I confirm the popup
      Then I should be on "https://help-stage.adcade.com/keystone/types"
      And I should see Keystone header and footer components

    Examples:
    | filter | name | column | download | typeName |
    | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div/div/div[3]/ul/li/a | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[2]/div[1]/a | testTypeUpdate3 |
    | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div/div/div[3]/ul/li/a | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[2]/div[1]/a | testTypeUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTypes
    Scenario Outline: I want to search type documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      Then I should see "<typeName>"
      And the response should contain "search"
      When I fill in "search" with "<typeName>"
      And I press "Search"
      Then I should see "<typeName>"
      And I should see Keystone header and footer components

    Examples:
    | sort | typeName |
    | //*[@id="body"]/div/div[2]/h1/div/span[4]/a | testTypeUpdate3 |
    | //*[@id="body"]/div/div[2]/h1/div/span[4]/a | testTypeUpdate4 |

  #KEYSTONE -- SHAPES

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneShapes
    Scenario Outline: I want to create shapes documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      When I press "Create Shape"
      Then I should see "New Shape"
      When I press "cancel"
      Then I should not see "<shapeName>"
      And I should see "Create Shape"
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
      And I should see Keystone header and footer components

    Examples:
    | shapeName | description |
    | testShape1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testShape2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testShape3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testShape4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneShapes
    Scenario Outline: I want to delete shape documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      When I fill in "search" with "<shapeName>"
      And I press "Search"
      Then I should see "<shapeName>"
      And I follow "delete shape"
      Then I should see "Are you sure you want to delete this shape?" in popup
      When I confirm the popup
      And I go to "https://help-stage.adcade.com/keystone/shapes"
      Then I should not see "<shapeName>"
      And I should see Keystone header and footer components

    Examples:
    | shapeName |
    | testShape1 |
    | testShape2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneShapes
    Scenario Outline: I want to update shapes documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      When I fill in "search" with "<shapeName>"
      Then I should see "<shapeName>"
      When I fill in "title" with "<shapeNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/shapes"
      And I fill in "search" with "test"
      Then I should not see "<shapeName>"
      And I should see "<shapeNameUpdate>"
      And I should see Keystone header and footer components

    Examples:
    | shapeName | shapeNameUpdate |
    | testShape3 | testShapeUpdate3 |
    | testShape4 | testShapeUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneShapes
    Scenario Outline: I want to filter shapes documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      Then I should see "<shapeName>"
      When I click on the element with xpath '<filter>'
      Then I should see filter shape view elements
      When I click on the element with xpath '<title>'
      Then I should see add filter elements
      When I click on the element with xpath '<column>'
      Then I should see filter shape view elements
      When I click on the element with xpath '<download>'
      And I confirm the popup
      Then I should be on "https://help-stage.adcade.com/keystone/shapes"
      And I should see Keystone header and footer components

    Examples:
    | filter | title | column | download | shapeName |
    | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/ul/li[1]/a | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[2]/div[1]/a | testShapeUpdate3 |
    | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/ul/li[1]/a | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[2]/div[1]/a | testShapeUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneShapes
    Scenario Outline: I want to search shapes documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      Then I should see "<shapeName>"
      And the response should contain "search"
      When I fill in "search" with "<shapeName>"
      And I press "Search"
      Then I should see "<shapeName>"
      And I should see Keystone header and footer components

    Examples:
    | sort | shapeName |
    | //*[@id="body"]/div/div[2]/h1/div/span[4]/a | testShapeUpdate3 |
    | //*[@id="body"]/div/div[2]/h1/div/span[4]/a | testShapeUpdate4 |

  #KEYSTONE -- PROPERTIES

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneProperties
    Scenario Outline: I want to create properties documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/properties"
      When I press "Create Property"
      Then I should see "New Property"
      And I should see "Create"
      And I should see "cancel"
      When I press "cancel"
      Then I should not see "<propName>"
      And I should see "Create Property"
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
      And I should see Keystone header and footer components

    Examples:
    | propName | description |
    | testProp1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testProp2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testProp3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testProp4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneProperties
    Scenario Outline: I want to delete properties documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/properties"
      When I fill in "search" with "<propName>"
      And I press "Search"
      Then I should see "<propName>"
      When I follow "delete property"
      Then I should see "Are you sure you want to delete this property?" in popup
      When I confirm the popup
      And I go to "https://help-stage.adcade.com/keystone/properties"
      Then I should not see "<propName>"
      And I should see Keystone header and footer components

    Examples:
    | propName |
    | testProp1 |
    | testProp2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneProperties
    Scenario Outline: I want to update properties documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/properties"
      When I fill in "search" with "<propName>"
      And I press "Search"
      Then I should see "<propName>"
      When I fill in "title" with "<propNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/properties"
      And I fill in "search" with "test"
      Then I should not see "<propName>"
      And I should see "<propNameUpdate>"
      And I should see Keystone header and footer components

    Examples:
    | propName | propNameUpdate |
    | testProp3 | testPropUpdate3 |
    | testProp4 | testPropUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneProperties
    Scenario Outline: I want to filter properties documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      Then I should see "<shapeName>"
      When I click on the element with xpath '<filter>'
      Then I should see filter property view elements
      When I click on the element with xpath '<title>'
      Then I should see add filter elements
      When I click on the element with xpath '<column>'
      Then I should see filter property view elements
      When I click on the element with xpath '<download>'
      And I confirm the popup
      Then I should be on "https://help-stage.adcade.com/keystone/shapes"
      And I should see Keystone header and footer components

    Examples:
    | filter | title | column | download | shapeName |
    | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/ul/li[1]/a | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[2]/div[1]/a | testPropUpdate3 |
    | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/ul/li[1]/a | //*[@id="list-filters"]/div[1]/div[1]/div/div[3]/button | //*[@id="list-filters"]/div[1]/div[2]/div[1]/a | testPropUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneProperties
    Scenario Outline: I want to search properties documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/properties"
      Then I should see "<propName>"
      And the response should contain "search"
      When I fill in "search" with "<propName>"
      And I press "Search"
      Then I should see "<propName>"
      And I should see Keystone header and footer components

    Examples:
    | sort | propName |
    | //*[@id="body"]/div/div[2]/h1/div/span[4]/a | testPropUpdate3 |
    | //*[@id="body"]/div/div[2]/h1/div/span[4]/a | testPropUpdate4 |

  #KEYSTONE -- METHODS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneMethods
    Scenario Outline: I want to create methods documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "/keystone/methods"
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
      And I should see Keystone header and footer components

    Examples:
    | methodName | description |
    | testMethod1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testMethod2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testMethod3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testMethod4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSDMethods
    Scenario Outline: I want to delete methods documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/methods"
      Then I should see "<methodName>"
      When I follow "<methodName>"
      And I follow "delete method"
      Then I should see "Are you sure you want to delete this method?" in popup
      When I confirm the popup
      And I go to "https://help-stage.adcade.com/keystone/methods"
      Then I should not see "<methodName>"
      And I should see Keystone header and footer components

    Examples:
    | methodName |
    | testMethod1 |
    | testMethod2 |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSUMethods
    Scenario Outline: I want to update methods documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/methods"
      And I wait for 2 seconds
      Then I should see "<methodName>"
      When I follow "<methodName>"
      And I fill in "title" with "<methodNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/methods"
      Then I should see "<methodNameUpdate>"
      And I should see Keystone header and footer components

    Examples:
    | methodName | methodNameUpdate |
    | testMethod3 | testMethod3Update |
    | testMethod4 | testMethod4update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSFilterMethods
    Scenario Outline: I want to filter methods documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/methods"
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
#      Then I should see "Download a .csv of 2 methods?" in popup
      And I confirm the popup
      Then I should be on "https://help-stage.adcade.com/keystone/methods"
      And I should see Keystone header and footer components

    Examples:
    | methodName |
    | testMethod3Update |
    | testMethod4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSSearchMethods
    Scenario Outline: I want to search methods documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/methods"
      And I wait for 2 seconds
      Then I should see "<methodName>"
      And the response should contain "search"
      When I fill in "search" with "<methodName>"
#      Then I should see "2 Methods"
      And I click on the element with xpath '//*[@id="body"]/div/div[2]/h1/div/span[2]/a'
      Then I should see "Title (descending)"
      And I should see "State"
      And I should see "Content Description"
      And I should see "<methodName>"
      And I should see Keystone header and footer components

    Examples:
    | methodName |
    | testMethod3Update |
    | testMethod4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSCRUtilities
    Scenario Outline: I want to create utilities documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
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
      And I should see Keystone header and footer components

    Examples:
    | utilityName | description |
    | testUtil1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testUtil2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testUtil3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testUtil4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSDUtilities
    Scenario Outline: I want to delete utilities documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
      And I wait for 2 seconds
      Then I should see "<utilityName>"
      When I follow "<utilityName>"
      And I follow "delete utility"
      Then I should see "Are you sure you want to delete this utility?" in popup
      When I confirm the popup
      And I go to "https://help-stage.adcade.com/keystone/utilities"
      Then I should not see "<utilityName>"
      And I should see Keystone header and footer components

    Examples:
    | utilityName |
    | testUtil1 |
    | testUtil2 |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSUUtilities
    Scenario Outline: I want to update utilities documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
      And I wait for 2 seconds
      Then I should see "<utilityName>"
      When I follow "<utilityName>"
      And I fill in "title" with "<utilityNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/utilities"
      Then I should see "<utilityNameUpdate>"
      And I should see Keystone header and footer components

    Examples:
    | utilityName | utilityNameUpdate |
    | testUtil3 | testUtil3Update |
    | testUtil4 | testUtil4update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSFilterUtilities
    Scenario Outline: I want to filter utilities documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
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
#      Then I should see "Download a .csv of 2 utilities?" in popup
      And I confirm the popup
      Then I should be on "https://help-stage.adcade.com/keystone/utilities"
      And I should see Keystone header and footer components

    Examples:
    | utilityName |
    | testUtil3Update |
    | testUtil4Update |

    @regression @helpCenter @helpCenterCMS @helpCenterCMSCRUD @javascript @HCCMSSearchUtilities
    Scenario Outline: I want to search utilities documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
      And I wait for 2 seconds
      Then I should see "<utilityName>"
      And the response should contain "search"
      When I fill in "search" with "<utilityName>"
#      Then I should see "2 Utilities"
      And I click on the element with xpath '//*[@id="body"]/div/div[2]/h1/div/span[2]/a'
      Then I should see "Title (descending)"
      And I should see "State"
      And I should see "Content Description"
      And I should see "<utilityName>"
      And I should see Keystone header and footer components

    Examples:
    | utilityName |
    | testUtil3Update |
    | testUtil4Update |

    @regression @helpCenter @helpCenterCMS @javascript @TutorialsCR @Tutorials
    Scenario Outline: I want to create and read tutorials documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/sections"
      And I should see tutorial elements
      And I press "Create Section"
      Then I should see "New Section"
      When I fill in "name" with "<sectionName>"
      And I press "cancel"
      Then I should not see "<sectionName>"
      When I press "Create Section"
      And I fill in "name" with "<sectionName>"
      And I press "Create"
      Then I should see "New Section <sectionName> created."
      Then I should see "<sectionName>"
      And I should see Keystone header and footer components
      When I go to "https://help-stage.adcade.com/keystone/sections"
      And I follow "<sectionName>"
      Then I should see tutorial section editing elements
      And I should see Keystone header and footer components

    Examples:
    | sectionName |
    | testSection1 |
    | testSection2 |
    | testSection3 |
    | testSection4 |

    @regression @helpCenter @helpCenterCMS @javascript @TutorialsU @Tutorials
    Scenario Outline: I want to update tutorials documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/sections"
      And I should see tutorial elements
      Then I should see "<sectionName>"
      When I follow "<sectionName>"
      Then I should see tutorial section editing elements
      And I should see Keystone header and footer components
      When I fill in "name" with "<sectionNameUpdated>"
      And I press "Save"
      And I go to "https://help-stage.adcade.com/keystone/sections"
      Then I should see "<sectionNameUpdated>"

    Examples:
    | sectionName | option | sectionNameUpdated |
    | testSection3 | Editor | testSection3Update |
    | testSection4 | Dashboard | testSection4Update |

    @regression @helpCenter @helpCenterCMS @javascript @TutorialsD @Tutorials
    Scenario Outline: I want to delete tutorials documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/sections"
      And I should see tutorial elements
      Then I should see "<sectionName>"
      When I follow "<sectionName>"
      Then I should see tutorial section editing elements
      And I should see Keystone header and footer components
      When I follow "delete section"
      Then I should see "Are you sure you want to delete this section?" in popup
      When I confirm the popup
      And I go to "https://help-stage.adcade.com/keystone/sections"
      Then I should not see "<sectionName>"

    Examples:
    | sectionName |
    | testSection1 |
    | testSection2 |

    @regression @helpCenter @helpCenterCMS @javascript @TutorialsPagesCR @Tutorials
    Scenario Outline: I want to create and read tutorials documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/pages"
      And I should see tutorial elements
      And I press "Create Page"
      Then I should see "New Page"
      When I fill in "title" with "<pageName>"
      And I press "cancel"
      Then I should not see "<pageName>"
      When I press "Create Page"
      And I fill in "title" with "<pageName>"
      And I press "Create"
      Then I should see "New Page <pageName> created."
      And I should see Keystone header and footer components
      When I go to "https://help-stage.adcade.com/keystone/pages"
      And I follow "<pageName>"
      And I fill in "content.description" with "<description>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      And I should see tutorial page editing elements
      And I should see Keystone header and footer components

    Examples:
    | pageName | description |
    | testPage1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testPage2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testPage3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testPage4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @regression @helpCenter @helpCenterCMS @javascript @TutorialsPagesU @Tutorials
    Scenario Outline: I want to update tutorials documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/pages"
      And I should see tutorial elements
      Then I should see "<pageName>"
      When I follow "<pageName>"
      Then I should see tutorial page editing elements
      And I should see Keystone header and footer components
      When I fill in "title" with "<pageNameUpdated>"
      And I press "Save"
      And I go to "https://help-stage.adcade.com/keystone/pages"
      Then I should see "<pageNameUpdated>"

    Examples:
    | pageName | option | pageNameUpdated |
    | testPage3 | Editor | testPage3Update |
    | testPage4 | Dashboard | testPage4Update |

    @regression @helpCenter @helpCenterCMS @javascript @TutorialsPagesD @Tutorials
    Scenario Outline: I want to delete tutorials documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/pages"
      And I should see tutorial elements
      Then I should see "<pageName>"
      When I follow "<pageName>"
      Then I should see tutorial page editing elements
      When I follow "delete page"
      Then I should see "Are you sure you want to delete this page?" in popup
      When I confirm the popup
      And I go to "https://help-stage.adcade.com/keystone/pages"
      Then I should not see "<pageName>"
      And I should see Keystone header and footer components

    Examples:
    | pageName |
    | testPage1 |
    | testPage2 |

    @regression @helpCenter @helpCenterCMS @javascript @DownloadsCR @Downloads
    Scenario Outline: I want to create and read downloads documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/downloads"
      And I should see download elements
      When I press "Create Download"
      Then I should see "New Download"
      When I fill in "title" with "<downloadName>"
      And I press "cancel"
      Then I should not see "<downloadName>"
      When I press "Create Download"
      And I fill in "title" with "<downloadName>"
      And I press "Create"
      Then I should see "New Download <downloadName> created."
      When I go to "https://help-stage.adcade.com/keystone/downloads"
      And I follow "<downloadName>"
      And I fill in "displayTitle" with "<title>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      And I should see download page editing elements
      And I should see Keystone header and footer components

    Examples:
    | downloadName | title |
    | testDownload1 | testDownload1Title |
    | testDownload2 | testDownload2Title |
    | testDownload3 | testDownload3Title |
    | testDownload4 | testDownload4Title |

    @regression @helpCenter @helpCenterCMS @javascript @DownloadsFiltersCR @Downloads
    Scenario Outline: I want to create and read downloads filters documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/download-filters"
      And I should see download elements
      When I press "Create Download"
      Then I should see "New Download"
      When I fill in "name" with "<downloadFilterName>"
      And I press "cancel"
      Then I should not see "<downloadFilterName>"
      When I press "Create Download"
      And I fill in "name" with "<downloadFilterName>"
      And I press "Create"
      Then I should see "New Download Filter <downloadFilterName> created."
      When I go to "https://help-stage.adcade.com/keystone/download-filters"
      Then I should see "<downloadFilterName>"
      And I should see Keystone header and footer components

    Examples:
    | downloadFilterName |
    | testDownloadFilter1 |
    | testDownloadFilter2 |
    | testDownloadFilter3 |
    | testDownloadFilter4 |

    @regression @helpCenter @helpCenterCMS @javascript @DownloadsU @Downloads
    Scenario Outline: I want to update downloads documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/downloads"
      And I should see download elements
      Then I should see "<downloadName>"
      When I follow "<downloadName>"
      And I fill in "title" with "<downloadNameUpdate>"
      And I fill in "displayTitle" with "<title>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/downloads"
      Then I should not see "<downloadName>"
      And I should see "<downloadNameUpdate>"
      And I should see download page editing elements
      And I should see Keystone header and footer components

    Examples:
    | downloadName | downloadNameUpdate | title |
    | testDownload3 | testDownloadUpdate3 | testDownload3TitleUpdate |
    | testDownload4 | testDownloadUpdate4 | testDownload4TitleUpdate |

    @regression @helpCenter @helpCenterCMS @javascript @DownloadsFiltersU @Downloads
    Scenario Outline: I want to update downloads filter documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/download-filters"
      And I should see download elements
      When I follow "<downloadFilterName>"
      Then I should see "<downloadFilterName>"
      When I fill in "name" with "<downloadFilterNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/download-filters"
      Then I should see "<downloadFilterNameUpdate>"
      And I should see Keystone header and footer components

    Examples:
    | downloadFilterName | downloadFilterNameUpdate |
    | testDownloadFilter3 | testDownloadFilter3Update |
    | testDownloadFilter4 | testDownloadFilter4Update |

    @regression @helpCenter @helpCenterCMS @javascript @DownloadsD @Downloads
    Scenario Outline: I want to update downloads documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/downloads"
      And I should see download elements
      Then I should see "<downloadName>"
      When I follow "<downloadName>"
      And I follow "delete download"
      Then I should see "Are you sure you want to delete this download?" in popup
      When I confirm the popup
      And I go to "https://help-stage.adcade.com/keystone/downloads"
      Then I should not see "<downloadName>"
      And I should see Keystone header and footer components

    Examples:
    | downloadName |
    | testDownload1 |
    | testDownload2 |

    @regression @helpCenter @helpCenterCMS @javascript @DownloadsFiltersD @Downloads
    Scenario Outline: I want to update downloads filter documentation
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/download-filters"
      And I should see download elements
      When I follow "<downloadFilterName>"
      And I follow "delete download filter"
      Then I should see "Are you sure you want to delete this download filter?" in popup
      When I confirm the popup
      And I go to "https://help-stage.adcade.com/keystone/download-filters"
      Then I should not see "<downloadFilterName>"
      And I should see Keystone header and footer components

    Examples:
    | downloadFilterName |
    | testDownloadFilter1 |
    | testDownloadFilter2 |
