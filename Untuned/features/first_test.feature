Feature: User sign up, add a post, and add a comment

  Scenario: User signs up and then signs in
    Given there is a new user on the sign-up page
    When the user enter credential and information
    And the user submits the sign-up form
    And the user confirm its profile
    Then the user go to the login page
    And the user enter credential
    And the user submit the sign-in form
    Then the user should see a welcome message

  Scenario: User add a post
    Given there is a logged user on the posts page
    When the user clicks on the New post button
    And the user fills in the information to create a new post
    And the user submits the post
    Then the user should see the post on the post's detail page

  Scenario: User add a comment
    Given the user is on the post's detail page
    When the user fills in the information to add a comment
    And the user submits the comment
    Then the user should see the comment on the post's detail page
