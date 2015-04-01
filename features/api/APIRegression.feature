Feature: I want to make sure api features are up and running

  As a tester
  I want to make sure api features are up and running
  So that I can automate continuous integration and regression tests using it

    @guzzle @check @api
    Scenario: Make and validate request
      Given I called "posts"
      And I get a response with a status code of "200"
      And the response contains 100 resources with the following data:
        | userId | id | title | body |
        | 1 | 1 | sunt aut facere repellat provident occaecati excepturi optio reprehenderit | quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto |
