Feature: I want to test the help-center

  As a tester
  I want to test the help-center
  So all features and functionality behave as expected

#HELP CENTER FRONT END

    @javascript @regression @helpCenter @home
    Scenario Outline: I want to make requests as an unauthenticated user
      Given I am on help center
      Then the response should contain "<expectedObject>"

    Examples:
    | expectedObject |
    | Adcade Help Center |
    | /favicon.ico |
    | /styles/styles.min.css |
    | /images/adcade.svg |
    | Sign In |
    | Epoch |
    | AdScript API |
    | Downloads |
    | Resources |

    @javascript @regression @helpCenter @404
    Scenario Outline: I want to make requests as an unauthenticated user and view "please log in message"
      Given I am on help center
      When I go to "<url>"
      Then I should see "Adcade Help Center"
      And I should see "Sign in"

    Examples:
    | url |
    | https://help-stage.adcade.com/login?url=/downloads |
    | https://help-stage.adcade.com/login?url=/resources |
    | https://help-stage.adcade.com/login |
    | https://help-stage.adcade.com/login?url=/feedback |

    @javascript @regression @helpCenter @invalidLogin
    Scenario Outline: I want to log in as an unauthenticated user
      Given I am on help center
      And I am authenticated on help center as "<un>" using "<pw>"
      Then I should see "<expectedResult>"

    Examples:
    | un | pw | expectedResult |
    | slappass@adcade.com | adcade42 | Sorry, the email or password is incorrect. |
    | slappass | adcade42 | Sorry, the email or password is incorrect. |
    | apappas@adcade.com | adcade4@ | Sorry, the email or password is incorrect. |

    @javascript @regression @helpCenter @home
    Scenario Outline: I want to log in as an authenticated user
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on help center
      Then the response should contain "<expectedObject>"
      And I should see help center header and footer components

    Examples:
    | expectedObject |
    | Adcade Help Center |
    | /favicon.ico |
    | /styles/styles.min.css |
    | /images/adcade.svg |
    | Lightspeed |
    | Epoch |
    | Epoch |
    | AdScript |
    | Resources |
    | View Guide |
    | Get Started |
    | Go To API Reference |

    @javascript @regression @helpCenter @navigation
    Scenario Outline: I want to follow links via the dashboard
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on help center
      When I follow "<link>"
      Then I should see "<expectedText>"
      And I should be on "<expectedURL>"
      And I should see help center header and footer components

    Examples:
    | link | expectedText | expectedURL |
    | Epoch | Introduction to the Visual Editor | https://help-stage.adcade.com/editor |
    | AdScript API | AdScript API | https://help-stage.adcade.com/adscript |
    | Downloads | Powered by AdScript | https://help-stage.adcade.com/downloads |
    | Resources | Webinars | https://help-stage.adcade.com/resources |

    @javascript @regression @helpCenter @search
    Scenario Outline: I want to search via help center
      Given I am authenticated on help center as "apappas@adcade.com" using "adcade42"
      And I am on help center
      When I fill in "search" with "<searchValue>"
      And I press "home-search-button"
      Then I should be on "<expectedURL>"
      And I should see "<expectedResult>"

    Examples:
    | searchValue | expectedURL | expectedResult |
    | test | https://help-stage.adcade.com/search?search=test | Search Results for: test |
    | adscript | https://help-stage.adcade.com/search?search=adscript | Search Results for: adscript |
    | dashboard | https://help-stage.adcade.com/search?search=dashboard | Search Results for: dashboard |
    | tween | https://help-stage.adcade.com/search?search=tween | Search Results for: tween |
    | nothingShouldExistForThisLongAssQuery | https://help-stage.adcade.com/search?search=nothingShouldExistForThisLongAssQuery | NO RESULTS FOUND. |
    | !!@@##$$%%^^é | https://help-stage.adcade.com/search?search=%21%21%40%40%23%23%24%24%25%25%5E%5Eé | NO RESULTS FOUND. |


#HELP CENTER BACK END -- KEYSTONE

    @javascript @regression @helpCenter @keystone @keystoneLogin
    Scenario: I want to log in to Keystone
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on help center keystone
      Then I should see "manage"
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
      And I should see "Image"
      And I should see "Users"
      And I should see "Webinars"
      And I should see Keystone header and footer components

  #KEYSTONE -- TYPES

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTypes
    Scenario Outline: I want to create type documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      And I wait for 3 seconds
      When I press "Create Type"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I fill in "search" with "<typeName>"
      Then I should not see "<typeName>"
      When I press "Create Type"
      And I fill in "name" with "<typeName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
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
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      And I wait for 3 seconds
      When I fill in "search" with "<typeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<typeName>"
      And I should see edit type view elements
      When I click on the element with xpath '//*[@id="item-view"]/div/form/div[3]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/types"
      And I fill in "search" with "<typeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No types found"
      And I should see Keystone header and footer components

    Examples:
    | typeName |
    | testType1 |
    | testType2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTypes
    Scenario Outline: I want to update type documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      And I wait for 3 seconds
      When I fill in "search" with "<typeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<typeName>"
      And I should see edit type view elements
      When I fill in "name" with "<typeNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/types"
      And I fill in "search" with "<typeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
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
    Scenario Outline: I want to search type documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      And I wait for 3 seconds
      Then I should see "<typeName>"
      And the response should contain "search"
      When I fill in "search" with "<typeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<typeName>"
      And I should see Keystone header and footer components

    Examples:
    | typeName |
    | testTypeUpdate3 |
    | testTypeUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTypes
    Scenario Outline: I want to delete all changes made to the CMS
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/types"
      And I wait for 3 seconds
      When I fill in "search" with "<typeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<typeName>"
      When I click on the element with xpath '//*[@id="item-view"]/div/form/div[3]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/types"
      And I fill in "search" with "<typeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No types found"
      And I should see Keystone header and footer components

    Examples:
    | typeName |
    | testTypeUpdate3 |
    | testTypeUpdate4 |

  #KEYSTONE -- SHAPES

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneShapes
    Scenario Outline: I want to create shapes documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      And I wait for 3 seconds
      When I press "Create Shape"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I fill in "search" with "<shapeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No shapes found"
      When I press "Create Shape"
      And I fill in "title" with "<shapeName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Shape <shapeName> created."
      And I should see create shape view elements
      When I fill in "content.description.md" with "<description>"
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
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      And I wait for 3 seconds
      When I fill in "search" with "<shapeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<shapeName>"
      And I follow "delete shape"
      When I go to "https://help-stage.adcade.com/keystone/shapes"
      And I fill in "search" with "<shapeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No shapes found"
      And I should see Keystone header and footer components

    Examples:
    | shapeName |
    | testShape1 |
    | testShape2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneShapes
    Scenario Outline: I want to update shapes documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      And I wait for 3 seconds
      When I fill in "search" with "<shapeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
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
    Scenario Outline: I want to search shapes documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      And I wait for 3 seconds
      Then I should see "<shapeName>"
      And the response should contain "search"
      When I fill in "search" with "<shapeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<shapeName>"
      And I should see Keystone header and footer components

    Examples:
    | shapeName |
    | testShapeUpdate3 |
    | testShapeUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneShapes
    Scenario Outline: I want to delete all changes made to the CMS
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/shapes"
      And I wait for 3 seconds
      When I fill in "search" with "<shapeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<shapeName>"
      When I click on the element with xpath '//*[@id="item-view"]/div/form/div[6]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/shapes"
      And I fill in "search" with "<shapeName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No shapes found"
      And I should see Keystone header and footer components

    Examples:
    | shapeName |
    | testShapeUpdate3 |
    | testShapeUpdate4 |

  #KEYSTONE -- PROPERTIES

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneProperties
    Scenario Outline: I want to create properties documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/properties"
      And I wait for 3 seconds
      When I press "Create Property"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I fill in "search" with "<propName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No properties found"
      When I press "Create Property"
      And I fill in "title" with "<propName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Property <propName> created."
      And I should see create property view elements
      When I fill in "content.description.md" with "<description>"
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
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/properties"
      And I wait for 3 seconds
      When I fill in "search" with "<propName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<propName>"
      When I click on the element with xpath '//*[@id="item-view"]/div/form/div[6]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/properties"
      And I fill in "search" with "<propName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No properties found"
      And I should see Keystone header and footer components

    Examples:
    | propName |
    | testProp1 |
    | testProp2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneProperties
    Scenario Outline: I want to update properties documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/properties"
      And I wait for 3 seconds
      When I fill in "search" with "<propName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<propName>"
      When I fill in "title" with "<propNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/properties"
      And I fill in "search" with "test"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should not see "<propName>"
      And I should see "<propNameUpdate>"
      And I should see Keystone header and footer components

    Examples:
    | propName | propNameUpdate |
    | testProp3 | testPropUpdate3 |
    | testProp4 | testPropUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneProperties
    Scenario Outline: I want to search properties documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/properties"
      And I wait for 3 seconds
      When I fill in "search" with "<propName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<propName>"
      And I should see Keystone header and footer components

    Examples:
    | propName |
    | testPropUpdate3 |
    | testPropUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneProperties
    Scenario Outline: I want to delete all changes made to the CMS
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/properties"
      And I wait for 3 seconds
      When I fill in "search" with "<propName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<propName>"
      When I click on the element with xpath '//*[@id="item-view"]/div/form/div[6]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/properties"
      And I fill in "search" with "<propName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No properties found"
      And I should see Keystone header and footer components

    Examples:
    | propName |
    | testPropUpdate3 |
    | testPropUpdate4 |

  #KEYSTONE -- METHODS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneMethods
    Scenario Outline: I want to create methods documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/methods"
      And I wait for 3 seconds
      When I press "Create Method"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I fill in "search" with "<methodName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No methods found"
      And I press "Create Method"
      And I fill in "title" with "<methodName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Method <methodName> created."
      And I should see create method view elements
      When I fill in "content.description.md" with "<description>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      And I should see Keystone header and footer components

    Examples:
    | methodName | description |
    | testMethod1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testMethod2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testMethod3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testMethod4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneMethods
    Scenario Outline: I want to delete methods documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/methods"
      And I wait for 3 seconds
      And I fill in "search" with "<methodName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I follow "delete method"
      When I go to "https://help-stage.adcade.com/keystone/methods"
      And I fill in "search" with "<methodName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No methods found"
      And I should see Keystone header and footer components

    Examples:
    | methodName |
    | testMethod1 |
    | testMethod2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneMethods
    Scenario Outline: I want to update methods documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/methods"
      And I wait for 3 seconds
      When I fill in "search" with "<methodName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<methodName>"
      When I fill in "title" with "<methodNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/methods"
      And I fill in "search" with "test"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should not see "<methodName>"
      Then I should see "<methodNameUpdate>"
      And I should see Keystone header and footer components

    Examples:
    | methodName | methodNameUpdate |
    | testMethod3 | testMethodUpdate3 |
    | testMethod4 | testMethodUpdate4 |


    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneMethods
    Scenario Outline: I want to search methods documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/methods"
      And I wait for 3 seconds
      When I fill in "search" with "<methodName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<methodName>"
      And I should see Keystone header and footer components

    Examples:
    | methodName |
    | testMethodUpdate3 |
    | testMethodUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneMethods
    Scenario Outline: I want to delete all changes made to the CMS
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/methods"
      And I wait for 3 seconds
      When I fill in "search" with "<methodName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I click on the element with xpath '//*[@id="item-view"]/div/form/div[6]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/methods"
      And I fill in "search" with "<methodName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No methods found"
      And I should see Keystone header and footer components

    Examples:
    | methodName |
    | testMethodUpdate3 |
    | testMethodUpdate4 |

  #KEYSTONE -- UTILITIES

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneUtilities
    Scenario Outline: I want to create utilities documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
      And I wait for 3 seconds
      When I press "Create Utility"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I fill in "search" with "<utilityName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No utilities found"
      When I press "Create Utility"
      And I fill in "title" with "<utilityName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Utility <utilityName> created."
      And I should see create utility view elements
      When I fill in "content.description.md" with "<description>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      And I should see Keystone header and footer components

    Examples:
    | utilityName | description |
    | testUtil1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testUtil2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testUtil3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testUtil4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneUtilities
    Scenario Outline: I want to delete utilities documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
      And I wait for 3 seconds
      And I fill in "search" with "<utilityName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I follow "delete utility"
      When I go to "https://help-stage.adcade.com/keystone/utilities"
      And I fill in "search" with "<utilityName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No utilities found"
      And I should see Keystone header and footer components

    Examples:
    | utilityName |
    | testUtil1 |
    | testUtil2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneUtilities
    Scenario Outline: I want to update utilities documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
      And I wait for 3 seconds
      When I fill in "search" with "<utilityName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I fill in "title" with "<utilityNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/utilities"
      And I fill in "search" with "<utilityName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No utilities found"
      And I should see Keystone header and footer components

    Examples:
    | utilityName | utilityNameUpdate |
    | testUtil3 | testUtilUpdate3 |
    | testUtil4 | testUtilUpdate4 |


    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneUtilities
    Scenario Outline: I want to search utilities documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
      And I wait for 3 seconds
      When I fill in "search" with "<utilityName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<utilityName>"
      And I should see Keystone header and footer components

    Examples:
    | utilityName |
    | testUtilUpdate3 |
    | testUtilUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneUtilities
    Scenario Outline: I want to delete all changes made to the CMS
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/utilities"
      And I wait for 3 seconds
      When I fill in "search" with "<utilityName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I click on the element with xpath '//*[@id="item-view"]/div/form/div[5]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/utilities"
      And I fill in "search" with "<utilityName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No utilities found"
      And I should see Keystone header and footer components

    Examples:
    | utilityName |
    | testUtilUpdate3 |
    | testUtilUpdate4 |

  #KEYSTONE -- CHANGELOG ITEMS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneChangeLog
    Scenario Outline: I want to create change log documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/changelog-items"
      And I wait for 3 seconds
      When I press "Create Changelog Item"
      And I fill in "title" with "<changeLogName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Changelog Item <changeLogName> created."
      And I should see create changelog view elements
      When I fill in "details.md" with "<description>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      And I should see Keystone header and footer components

    Examples:
    | changeLogName | description |
    | testChangeLog1 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testChangeLog2 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testChangeLog3 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |
    | testChangeLog4 | #Testing md input *italic* **bold** ![Adcade Logo](http://sajjad.pw/files/adcade-logo.jpg) [Link to logo](http://sajjad.pw/files/adcade-logo.jpg) - list text here 1. list text here |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneChangeLog
    Scenario Outline: I want to delete change log documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/changelog-items"
      And I wait for 3 seconds
      And I fill in "search" with "<changeLogName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      When I click on the element with xpath '//*[@id="item-view"]/div/form/div[6]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/changelog-items"
      And I fill in "search" with "<changeLogName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No changelog items found"
      And I should see Keystone header and footer components

    Examples:
    | changeLogName |
    | testChangeLog1 |
    | testChangeLog2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneChangeLog
    Scenario Outline: I want to update change log documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/changelog-items"
      And I wait for 3 seconds
      When I fill in "search" with "<changeLogName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I fill in "title" with "<changeLogNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/changelog-items"
      And I fill in "search" with "<changeLogName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No changelog items found"
      And I should see Keystone header and footer components

    Examples:
    | changeLogName | changeLogNameUpdate |
    | testChangeLog3 | testChangeLogUpdate3 |
    | testChangeLog4 | testChangeLogUpdate4 |


    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneChangeLog
    Scenario Outline: I want to search change log documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/changelog-items"
      And I wait for 3 seconds
      When I fill in "search" with "<changeLogName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<changeLogName>"
      And I should see Keystone header and footer components

    Examples:
    | changeLogName |
    | testChangeLogUpdate3 |
    | testChangeLogUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneChangeLog
    Scenario Outline: I want to delete all changes made to the CMS
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/changelog-items"
      And I wait for 3 seconds
      When I fill in "search" with "<changeLogName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I click on the element with xpath '//*[@id="item-view"]/div/form/div[6]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/changelog-items"
      And I fill in "search" with "<changeLogName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No changelog items found"
      And I should see Keystone header and footer components

    Examples:
    | changeLogName |
    | testChangeLogUpdate3 |
    | testChangeLogUpdate4 |

  #KEYSTONE -- VERSIONS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneVersions
    Scenario Outline: I want to create versions documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/versions"
      And I wait for 3 seconds
      When I press "Create Version"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I fill in "search" with "<versionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No versions found"
      When I press "Create Version"
      And I fill in "name" with "<versionName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Version <versionName> created."
      And I should see create version view elements
      When I press "Save"
      Then I should see "Your changes have been saved."
      And I should see Keystone header and footer components

    Examples:
    | versionName |
    | testVersion 1.0.01212 |
    | testVersion 2.0.01212 |
    | testVersion 3.0.01212 |
    | testVersion 4.0.01212 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneVersions
    Scenario Outline: I want to delete versions documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/versions"
      And I wait for 3 seconds
      And I fill in "search" with "<versionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      When I click on the element with xpath '//*[@id="item-view"]/div/form/div[4]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/versions"
      And I fill in "search" with "<versionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No versions found"
      And I should see Keystone header and footer components

    Examples:
    | versionName |
    | testVersion 1.0.01212 |
    | testVersion 2.0.01212 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneVersions
    Scenario Outline: I want to update versions documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/versions"
      And I wait for 3 seconds
      When I fill in "search" with "<versionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I fill in "name" with "<versionNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/versions"
      And I fill in "search" with "<versionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No versions found"
      And I should see Keystone header and footer components

    Examples:
    | versionName | versionNameUpdate |
    | testVersion 3.0.01212 | testVersionUpdate 3.1.2009 |
    | testVersion 4.0.01212 | testVersionUpdate 4.1.2009 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneVersions
    Scenario Outline: I want to search versions documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/versions"
      And I wait for 3 seconds
      When I fill in "search" with "<versionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<key>"
      And I should see Keystone header and footer components

    Examples:
    | versionName | key |
    | testVersionUpdate 3.1.2009 | testversionupdate-312009 |
    | testVersionUpdate 4.1.2009 | testversionupdate-412009 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneVersions
    Scenario Outline: I want to delete all changes made to the CMS
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/versions"
      And I wait for 3 seconds
      When I fill in "search" with "<versionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I click on the element with xpath '//*[@id="item-view"]/div/form/div[4]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/versions"
      And I fill in "search" with "<versionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No versions found"
      And I should see Keystone header and footer components

    Examples:
    | versionName |
    | testVersionUpdate 3.1.2009 |
    | testVersionUpdate 4.1.2009 |

  #KEYSTONE -- TUTORIALS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTutorials
    Scenario Outline: I want to create and read tutorials documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/sections"
      And I wait for 3 seconds
      And I should see tutorial elements
      And I press "Create Section"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I press "Create Section"
      And I fill in "name" with "<sectionName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Section <sectionName> created."
      And I should see tutorial section editing elements
      When I go to "https://help-stage.adcade.com/keystone/sections"
      And I fill in "search" with "<sectionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<sectionName>"
      And I should see Keystone header and footer components

    Examples:
    | sectionName |
    | testSection1 |
    | testSection2 |
    | testSection3 |
    | testSection4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTutorials
    Scenario Outline: I want to update tutorials documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/sections"
      And I wait for 3 seconds
      And I should see tutorial elements
      When I fill in "search" with "<sectionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see tutorial section editing elements
      When I fill in "name" with "<sectionNameUpdate>"
      And I press "Save"
      And I go to "https://help-stage.adcade.com/keystone/sections"
      When I fill in "search" with "<sectionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No sections found"
      And I should see Keystone header and footer components

    Examples:
    | sectionName | sectionNameUpdate |
    | testSection3 | testSectionUpdate3 |
    | testSection4 | testSectionUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTutorials
    Scenario Outline: I want to delete tutorials documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/sections"
      And I wait for 3 seconds
      And I should see tutorial elements
      Then I should see "<sectionName>"
      When I follow "<sectionName>"
      Then I should see tutorial section editing elements
      And I should see Keystone header and footer components
      When I follow "delete section"
      And I go to "https://help-stage.adcade.com/keystone/sections"
      Then I should not see "<sectionName>"

    Examples:
    | sectionName |
    | testSection1 |
    | testSection2 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTutorials
    Scenario Outline: I want to delete all changes made to the CMS
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/sections"
      And I wait for 3 seconds
      When I fill in "search" with "<sectionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I click on the element with xpath '//*[@id="item-view"]/div/form/div[4]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/sections"
      And I fill in "search" with "<sectionName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No sections found"
      And I should see Keystone header and footer components

    Examples:
    | sectionName |
    | testSectionUpdate3 |
    | testSectionUpdate4 |

  #KEYSTONE -- TUTORIALS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTutorials
    Scenario Outline: I want to create and read tutorials documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/pages"
      And I wait for 3 seconds
      And I should see tutorial elements
      And I press "Create Page"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I fill in "search" with "<pageName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No pages found"
      When I press "Create Page"
      And I fill in "title" with "<pageName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Page <pageName> created."
      And I fill in "content.description.md" with "<description>"
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

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTutorials
    Scenario Outline: I want to update tutorials documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/pages"
      And I wait for 3 seconds
      And I should see tutorial elements
      And I fill in "search" with "<pageName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<pageName>"
      And I should see tutorial page editing elements
      When I fill in "title" with "<pageNameUpdated>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/pages"
      And I fill in "search" with "<pageName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No pages found"
      And I should see Keystone header and footer components

    Examples:
    | pageName | pageNameUpdated |
    | testPage3 | testPageUpdate3 |
    | testPage4 | testPageUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneTutorials
    Scenario Outline: I want to delete tutorials documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/pages"
      And I wait for 3 seconds
      And I should see tutorial elements
      And I fill in "search" with "<pageName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see tutorial page editing elements
      When I click on the element with xpath '//*[@id="item-view"]/div/form/div[8]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/pages"
      And I fill in "search" with "<pageName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No pages found"
      And I should see Keystone header and footer components

    Examples:
    | pageName |
    | testPage1 |
    | testPage2 |
    | testPageUpdate3 |
    | testPageUpdate4 |

  #KEYSTONE -- DOWNLOADS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneDownloads
    Scenario Outline: I want to create and read downloads documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/downloads"
      And I wait for 3 seconds
      And I should see download elements
      When I press "Create Download"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I press "Create Download"
      And I fill in "title" with "<downloadName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      And I should see download page editing elements
      Then I should see "New Download <downloadName> created."
      When I fill in "displayTitle" with "<title>"
      And I press "Save"
      And I go to "https://help-stage.adcade.com/keystone/downloads"
      And I fill in "search" with "<downloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<downloadName>"
      And I should see Keystone header and footer components

    Examples:
    | downloadName | title |
    | testDownload1 | testDownload1Title |
    | testDownload2 | testDownload2Title |
    | testDownload3 | testDownload3Title |
    | testDownload4 | testDownload4Title |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneDownloads
    Scenario Outline: I want to update downloads documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/downloads"
      And I wait for 3 seconds
      And I should see download elements
      And I fill in "search" with "<downloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      When I fill in "title" with "<downloadNameUpdate>"
      And I fill in "displayTitle" with "<title>"
      And I should see download page editing elements
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/downloads"
      Then I should not see "<downloadName>"
      And I fill in "search" with "<downloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I should see "No downloads found"
      And I should see Keystone header and footer components

    Examples:
    | downloadName | downloadNameUpdate | title |
    | testDownload3 | testDownloadUpdate3 | testDownload3TitleUpdate |
    | testDownload4 | testDownloadUpdate4 | testDownload4TitleUpdate |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneDownloads
    Scenario Outline: I want to delete downloads documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/downloads"
      And I wait for 3 seconds
      And I should see download elements
      And I fill in "search" with "<downloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<downloadName>"
      When I click on the element with xpath '//*[@id="item-view"]/div/form/div[8]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/downloads"
      And I fill in "search" with "<downloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No downloads found"
      And I should see Keystone header and footer components

    Examples:
    | downloadName |
    | testDownload1 |
    | testDownload2 |
    | testDownloadUpdate3 |
    | testDownloadUpdate4 |

  #KEYSTONE -- DOWNLOAD FILTERS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneDownloadFilters
    Scenario Outline: I want to create and read downloads filters documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/download-filters"
      And I wait for 3 seconds
      And I should see download elements
      When I press "Create Download Filter"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I press "Create Download Filter"
      And I fill in "name" with "<downloadFilterName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Download Filter <downloadFilterName> created."
      When I go to "https://help-stage.adcade.com/keystone/download-filters"
      And I fill in "search" with "<downloadFilterName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<downloadFilterName>"
      And I should see Keystone header and footer components

    Examples:
    | downloadFilterName |
    | testDownloadFilter1 |
    | testDownloadFilter2 |
    | testDownloadFilter3 |
    | testDownloadFilter4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneDownloadFilters
    Scenario Outline: I want to update downloads filter documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/download-filters"
      And I wait for 3 seconds
      And I should see download elements
      And I fill in "search" with "<downloadFilterName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I fill in "name" with "<downloadFilterNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/download-filters"
      And I fill in "search" with "<downloadFilterName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No download filters found"
      And I should see Keystone header and footer components

    Examples:
    | downloadFilterName | downloadFilterNameUpdate |
    | testDownloadFilter3 | testDownloadFilterUpdate3 |
    | testDownloadFilter4 | testDownloadFilterUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneDownloadFilters
    Scenario Outline: I want to delete downloads filter documentation
      Given I am on a new session
      And I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/download-filters"
      And I wait for 3 seconds
      And I should see download elements
      And I fill in "search" with "<downloadFilterName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I click on the element with xpath '//*[@id="item-view"]/div/form/div[3]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/download-filters"
      And I fill in "search" with "<downloadFilterName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No download filters found"
      And I should see Keystone header and footer components

    Examples:
    | downloadFilterName |
    | testDownloadFilter1 |
    | testDownloadFilter2 |
    | testDownloadFilterUpdate3 |
    | testDownloadFilterUpdate4 |

  #KEYSTONE -- EDITOR DOWNLOADS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneEditorDownloads
    Scenario Outline: I want to create and read editor downloads documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/editor-downloads"
      And I wait for 3 seconds
      And I should see download elements
      When I press "Create Editor Download"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I press "Create Editor Download"
      And I fill in "title" with "<editorDownloadName>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "New Editor Download <editorDownloadName> created."
      When I go to "https://help-stage.adcade.com/keystone/editor-downloads"
      And I fill in "search" with "<editorDownloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<editorDownloadName>"
      And I should see Keystone header and footer components

    Examples:
    | editorDownloadName |
    | testEditorDownload1 |
    | testEditorDownload2 |
    | testEditorDownload3 |
    | testEditorDownload4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneEditorDownloads
    Scenario Outline: I want to update editor downloads documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/editor-downloads"
      And I wait for 3 seconds
      And I should see download elements
      And I fill in "search" with "<editorDownloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I fill in "title" with "<editorDownloadNameUpdate>"
      And I press "Save"
      Then I should see "Your changes have been saved."
      When I go to "https://help-stage.adcade.com/keystone/editor-downloads"
      And I fill in "search" with "<editorDownloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No editor downloads found"
      And I should see Keystone header and footer components

    Examples:
    | editorDownloadName | editorDownloadNameUpdate |
    | testEditorDownload3 | testEditorDownloadUpdate3 |
    | testEditorDownload4 | testEditorDownloadUpdate4 |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneEditorDownloads1
    Scenario Outline: I want to delete editor downloads documentation
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/editor-downloads"
      And I wait for 3 seconds
      And I should see download elements
      And I fill in "search" with "<editorDownloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I click on the element with xpath '//*[@id="item-view"]/div/form/div[8]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/editor-downloads"
      And I fill in "search" with "<editorDownloadName>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No editor downloads found"
      And I should see Keystone header and footer components

    Examples:
    | editorDownloadName |
    | testEditorDownload1 |
    | testEditorDownload2 |
    | testEditorDownloadUpdate3 |
    | testEditorDownloadUpdate4 |

  #KEYSTONE -- USERS

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneUsers
    Scenario Outline: I want to create and read users
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/users"
      And I wait for 3 seconds
      When I press "Create User"
      Then I should see create user elements
      When I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[2]'
      And I press "Create User"
      And I fill in "name.first" with "<firstName>"
      And I fill in "name.last" with "<lastName>"
      And I fill in "email" with "<email>"
      When I fill in "password" with "<password>"
      And I fill in "password_confirm" with "<confirmPassword>"
      And I click on the element with xpath '//*[@id="list-view"]/div/div[2]/div[1]/div/form/div[3]/button[1]'
      Then I should see "<expectedResult1>"
      When I go to "https://help-stage.adcade.com/keystone/users"
      And I fill in "search" with "<username>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "<expectedResult2>"
      And I should see Keystone header and footer components

    Examples:
    | firstName | lastName | email | password | confirmPassword | username | expectedResult1 |expectedResult2 |
    | sam | wise | samwise@lotr.com | gandalf | gandalf | sam wise | New User sam wise created. | sam wise |
    | jon | snow | jonsnow@got.com | stark | stark | jon snow | New User jon snow created. | jon snow |
    | goku | kakarot | gokukakarot@dbz-thisEmailShouldFail | vageta | vageta | goku | Please enter a valid email address in the Email field | No users found matching goku |
    | ron | swanson | ronswanson@p&c.com |  |  | ron swanson | Password is required | No users found matching ron swanson |
    |  |  | walterwhite@methlab.com | meth | meth | walter white | Name is required. | No users found matching walter white |
    | dead |  | zombie@deadmail.com | bodies | bodies | dead zombie | New User dead created. | dead |
    |  | zombie | zombie@deadmail.com | bodies | bodies | dead zombie | New User zombie created. | zombie |
    | ender | wiggin | ewiggin@battleschool.net | hoEnder | theenemysgateisdown | ender wiggin | Passwords must match | Buzz Wiggin |
    | ender | wiggin |  | hoEnder | hoEnder | ender wiggin | Email is required | Buzz Wiggin |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneUsers
    Scenario Outline: I want to update users
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/users"
      And I wait for 3 seconds
      And I fill in "search" with "<username>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I should see edit user elements
      When I press "Change Password"
      Then the response should contain "New password"
      And the response should contain "Confirm new password"
      When I check "isAdmin"
      And I fill in "name.first" with "<updateFName>"
      And I fill in "name.last" with "<updateLName>"
      And I fill in "email" with "<updateEmail>"
      And I fill in "password" with "<updatePassword>"
      And I fill in "password_confirm" with "<confirmUpdatePassword>"
      And I click on the element with xpath '//*[@id="item-view"]/div/form/div[6]/div/button'
      Then I should see "Your changes have been saved."

    Examples:
    | username | updateFName | updateLName | updateEmail | updatePassword | confirmUpdatePassword |
    | sam wise | frodo | baggins | frodobaggins@lotr.com | ring | ring |
    | jon snow | khal | drogo | khaldrogo@got.com | khaleesi | khaleesi |
    | dead | rick | grimes | cantkillme@wd.com | lauri | lauri |
    | zombie | spongebob | squarepants | spongebob@krustykrabs.com | pinapple | pinapple |

    @javascript @regression @helpCenter @keystone @keystoneCRUD @keystoneUsers
    Scenario Outline: I want to delete all new users
      Given I am authenticated on keystone as "apappas@adcade.com" using "adcade42"
      And I am on "https://help-stage.adcade.com/keystone/users"
      And I wait for 3 seconds
      And I fill in "search" with "<username>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      And I click on the element with xpath '//*[@id="item-view"]/div/form/div[6]/div/a[2]'
      When I go to "https://help-stage.adcade.com/keystone/users"
      And I fill in "search" with "<username>"
      And I click on the element with xpath '//*[@id="list-filters"]/div[1]/div[1]/div/div[2]/div[2]/button/span[2]'
      Then I should see "No users found"
      And I should see Keystone header and footer components

    Examples:
    | username |
    | frodo baggins |
    | rick grimes |
    | khal drogo |
    | spongebob squarepants |
