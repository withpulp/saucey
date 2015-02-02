Feature: I want to maintain an ongoing list of test tags that are expected to retain

  As a tester
  I want to make sure test tags are up and running
  So that they remain functional after delivery

    @javascript @WSJTestTags
    Scenario Outline: I want to make sure WSJ test tags are up and running
      Given I am on "<url>"
      Then the response should contain "Adcade"
      And the response should contain "<adId>"

    Examples:
      | url | adId |
      | http://adcade.com/demo/wsj/testtags/300x250_inpage/index.html | WSJPBN10TT300250IP |
      | http://adcade.com/demo/wsj/testtags/320x50_inpage/index.html | WSJPBN10TT32050IP |
      | http://adcade.com/demo/wsj/testtags/300x250_fs/index.html | WSJPBN10TT300250EXP |
      | http://adcade.com/demo/wsj/testtags/320x50_fs/index.html | WSJPBN10TT32050EXP |
      | http://adcade.com/demo/wsj/testtags/300x250_inter/index.html | WSJPBN10TT300250INTER |
      | http://adcade.com/demo/wsj/testtags/1024x90_inpage/index.html | WSJPBN10TT102490IP |
      | http://adcade.com/demo/wsj/testtags/1024x768_inter/index.html | WSJPBN10TT1024768INTER |

    @javascript @rxGlamour
    Scenario Outline: I want to make sure rxGlamour test tags are up and running
      Given I am on "<url>"
      Then the response should contain "Adcade"
      And the response should contain "<adId>"

    Examples:
      | url | adId |
      | http://adcade.com/demo/time/rx/tablet/index.html | PFRFGD1411521392TAB |
      | http://adcade.com/demo/time/rx/desktop/index.html | PFRFGD14GFOLD10321100DESK |

    @javascript @EOnline
    Scenario Outline: I want to make sure eOnline test tags are up and running
      Given I am on "<url>"
      Then the response should contain "Adcade"
      And the response should contain "<adId>"

    Examples:
      | url | adId |
      | http://adcade.com/demo/E/testtags/320x50_inpage/index.html | EPUB1201ETT32050IP |
      | http://adcade.com/demo/E/testtags/320x50_expandable/index.html | EPUB1201ETT32050EXP |
      | http://adcade.com/demo/E/testtags/300x250_inpage/index.html | EPUB1201ETT300250IP |
      | http://adcade.com/demo/E/testtags/300x250_expandable/index.html | EPUB1201ETT300250EXP |
      | http://adcade.com/demo/E/testtags/300x250_interstitial/index.html | EPUB1201ETT300250INTER |
      | http://adcade.com/demo/E/testtags/320x460_inpage/index.html | EPUB1201ETT320460IP |
      | http://adcade.com/demo/fandndo/320x50_inpage/index.html | EPUB1201FANTT32050IP |
      | http://adcade.com/demo/fandndo/320x50_expandable/index.html | EPUB1201FANTT32050EXP |
      | http://adcade.com/demo/fandndo/320x100_inpage/index.html | EPUB1201FANTT320100IP |
      | http://adcade.com/demo/fandndo/320x100_expandable/index.html | EPUB1201FANTT320100EXP |
