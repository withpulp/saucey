Feature: Shell Functionality

  As a tester
  I want to make sure shell features are up and running
  So that I can automate continuous integration and regression tests using it

    @shell @ls
    Scenario: Run 'ls -a' and verify output
      Given I am in "/Users/EnderWiggin/Sites/saucey/run" directory
      When I run "ls -a"
      Then I should see:
      """
      .
      ..
      git.sh
      saucey.sh
      saucey.txt
      start_selenium.sh
      """

    @shell @saucey
    Scenario: Run './saucey test' and verify output
      Given I am in "/Users/EnderWiggin/Sites/saucey" directory
      When I run "./saucey test"
      Then I should see:
      """
      Yo, you try'na get saucey?
      """

    @shell @git
    Scenario: Run 'git remote' and verify output
      Given I am in "/Users/EnderWiggin/Sites/saucey" directory
      When I run "git remote"
      Then I should see:
      """
      origin
      sajjad
      saucey
      withpulp
      """
