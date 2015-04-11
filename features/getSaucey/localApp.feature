Feature: Cool ass functionality

  As a saucey developer
  I want to showcase the big bang of Saucey
  So that I can automate continuous integration and regression tests using it

  @javascript @game
  Scenario: Start the app
    Given I am in "/Users/EnderWiggin/Sites/saucey/game" directory
    When I run "ls -a"
    Then I should see:
    """
    .
    ..
    README.md
    _tuts
    battle.php
    css
    functions.php
    index.php
    js
    knpu
    lib
    play.php
    """
    When I start the app in the background
    And I go to "/"
    Then I should see "OO Battleships of Space"
