Feature: Cool ass functionality

  As a saucey developer
  I want to showcase the big bang of saucey
  So that I can automate continuous integration and regression tests using it

  @saucey @javascript @game @start
  Scenario: Start the app
    Given I am in "/Users/EnderWiggin/Sites/saucey" directory
    When I run "ls -a game"
    Then I should see:
    """
    .
    ..
    battle.php
    css
    functions.php
    index.php
    js
    lib
    """

  @saucey @javascript @game @play
  Scenario: Play the app
    Given I set my browser window size to MacBook Standard
    And I am on "http://demo.adcade.com/demo/yahoo/testtags/160x600_expandable/index.html"
    And I run "./bin/xy/cliclick c:80,420 w:1000"
    And I run "./bin/xy/cliclick dd:300,420 w:1000"
    And I run "./bin/xy/cliclick dd:420,420 w:1000"
    And I run "./bin/xy/cliclick dd:420,300 w:1000"
    And I run "./bin/xy/cliclick dd:300,300 w:1000"
    And I run "./bin/xy/cliclick dd:300,420 w:1000"
    And I run "./bin/xy/cliclick du:300,420 w:1000"
    And I run "./bin/xy/cliclick c:200,200 w:1000"
    And I run "./bin/xy/cliclick kd:cmd,w w:1000"



