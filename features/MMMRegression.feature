Feature: I want to automate continuous integration and regression tests for Music Makes Music API and End Points

  As a tester
  I want to evaluate API and end-points
  So that regression tests pass

    @javascript @regression @smoke @GETRequests
    Scenario Outline: GET 200 Requests for assets and Production
      Given I am on "<requestURL>"
      Then the response should contain "<expectedOutcome>"

    Examples:
      | requestURL | expectedOutcome |
      | http://musicmakesmusic.org/ | Music Makes Music |
      | http://musicmakesmusic.org/donate/ | Support the future generation! |
      | http://musicmakesmusic.org/about/ | Our Mission |
      | http://musicmakesmusic.com/events/ | UPCOMING EVENTS! |
      | http://m3.projectlab.me/wp-content/uploads/2014/06/musicmakesmusicabout.jpg | musicmakesmusicabout.jpg |
      | http://m3.projectlab.me/wp-content/uploads/2014/06/musicmakesmusicteamthumb.jpg | musicmakesmusicteamthumb.jpg |
      | http://m3.projectlab.me/wp-content/uploads/2014/06/musicmakesmusicfaqthumb.jpg | musicmakesmusicfaqthumb.jpg |
      | http://m3.projectlab.me/wp-content/uploads/2014/07/infographic01-m3.png | infographic01-m3.png |
      | http://m3.projectlab.me/wp-content/uploads/2014/07/infographic03-m3.png | infographic03-m3.png |
      | http://m3.projectlab.me/wp-content/uploads/2014/07/infographic02-m3.png | infographic02-m3.png |
      | http://musicmakesmusic.com/wp-content/uploads/2014/03/Mike.jpg | Mike.jpg |
      | http://musicmakesmusic.com/wp-content/uploads/2014/03/Nik.jpg | Nik.jpg |
      | http://musicmakesmusic.com/wp-content/uploads/2014/03/Nik.jpg | Nik.jpg |
      | http://m3.projectlab.me/wp-content/uploads/2014/07/M3-Thomas-Sienko.jpg | M3-Thomas-Sienko.jpg |
      | http://m3.projectlab.me/wp-content/uploads/2014/07/M3-Ferril-Trevor-Davis.jpg | M3-Ferril-Trevor-Davis.jpg |
      | http://m3.projectlab.me/wp-content/uploads/2014/07/M3-Chris-Saul.jpg | M3-Chris-Saul.jpg |
      | http://musicmakesmusic.com/wp-content/uploads/2014/07/groupphotokids.jpg | groupphotokids.jpg |
