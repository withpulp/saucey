Feature: SOAP & REST API Functionality

  As a tester
  I want to make sure api features are up and running
  So that I can automate continuous integration and regression tests using it

@saucey @api @get
Scenario: Make and validate a GET request
  Given send a GET request to "/comments?postId=1&id=1"
  Then  the response code should be 200
  And the response should contain json:
  """
    [
      {
        "postId": 1,
        "id": 1,
        "name": "id labore ex et quam laborum",
        "email": "Eliseo@gardner.biz",
        "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
      }
    ]
  """

@saucey @api @put
Scenario: Make and validate a PUT request
  Given send a PUT request to "/posts/1"
  Then  the response code should be 200
  And the response should contain json:
  """
    {
      "userId": 1,
      "id": 1,
      "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    }
  """

@saucey @api @delete
Scenario: Make and validate a DELETE request
  Given send a DELETE request to "/posts/1"
  Then  the response code should be 204
  And the response can not contain "id"

@saucey @api @getHeader
Scenario: Make and validate a GET request with a header
  Given send a GET request to "/posts/1" with values:
    | User-Agent | Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36 |
    | Origin | chrome-extension://hgmloofddffdnphfgcellkdfbfbjeloo |
    | Content-Type | multipart/form-data; boundary=ARCFormBoundaryritq1vvj7s6ecdi |
    | Accept | */* |
    | Accept-Encoding | gzip, deflate, sdch |
    | Accept-Language | en-US,en;q=0.8 |
    | Cookie | _ga=GA1.2.703163342.1427828201 |
  Then  the response code should be 200
  And the response should contain json:
  """
    {
      "userId": 1,
      "id": 1,
      "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    }
  """
