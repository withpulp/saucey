Feature: Shell Functionality

  As a tester
  I want to make sure shell features are up and running
  So that I can automate continuous integration and regression tests using it

    @shell @ls
    Scenario: Run 'ls -a' and verify output
      Given I am in a directory "/Users/EnderWiggin/Sites/saucey"
      When I run "ls -a"
      Then I should see:
      """
      .
      ..
      .DS_Store
      .git
      .gitignore
      README.md
      behat.yml
      bin
      composer.json
      composer.lock
      composer.phar
      config
      features
      gitty
      images
      reports
      run
      saucey
      start_selenium
      vendor
      """

    @shell @saucey
    Scenario: Run './saucey test' and verify output
      Given I am in a directory "/Users/EnderWiggin/Sites/saucey"
      When I run "./saucey test"
      Then I should see:
      """
      Yo, you try'na get saucey?
      """

    @shell @git
    Scenario: Run 'git remote' and verify output
      Given I am in a directory "/Users/EnderWiggin/Sites/saucey"
      When I run "git remote"
      Then I should see:
      """
      origin
      sajjad
      saucey
      withpulp
      """
