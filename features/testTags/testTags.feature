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

    @javascript @GapSpringIsWeird
    Scenario Outline: I want to make sure Gap test tags are up and running
      Given I am on "<url>"
      Then the response should contain "Adcade"
      And the response should contain "<adId>"

    Examples:
      | url | adId |
      | http://adcade.com/demo/refinery29/gap/marquee_v1/index.html | dfd29f67-5a17-4736-b5d7-0ac799a6f787 |
      | http://adcade.com/demo/refinery29/gap/marquee_v2/index.html | bee1eb66-e92d-4b7c-bd0e-7713c03aaf62 |
      | http://adcade.com/demo/refinery29/gap/marquee_v3/index.html | 3e09dfe4-ef07-40c7-8493-959a000740b2 |

    @javascript @GapSpringIsWeird
    Scenario Outline: I want to make sure Gap click through functions as expected
      Given I am on "<url>"
      Then the response should contain "<clickThrough>"
      When I go to "<clickThrough>"
      Then I should be on "<expectedURL>"

    Examples:
      | url | clickThrough | expectedURL |
      | http://adcade.com/demo/refinery29/gap/marquee_v1/index.html | http://ad.doubleclick.net/ddm/clk/288141568%3B115107671%3Bh | http://www.gap.com/?tid=gpme000033 |
      | http://adcade.com/demo/refinery29/gap/marquee_v2/index.html | http://ad.doubleclick.net/ddm/clk/288141671%3B115107671%3Bc | http://gap.secondfunnel.com/springisweird?utm_source=N2949.Refinery29&utm_medium=dfa&utm_campaign=2015q1brand&utm_content=115107671 |
      | http://adcade.com/demo/refinery29/gap/marquee_v3/index.html | http://ad.doubleclick.net/ddm/clk/288255429%3B115107671%3Bj | http://www.gap.com/browse/subDivision.do?cid=5646&tid=gpme000068 |
