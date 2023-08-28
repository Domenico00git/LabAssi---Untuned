Feature: User sign in, goes to the posts page, like last post uploaded and follows it 

    Scenario: Another User signs up and then signs in
        Given there is another user on the sign-up page
        When the other user enter credential and information
        And the other user submits the sign-up form
        And the other user confirm its profile
        Then the other user go to the login page
        And the other user enter credential
        And the other user submit the sign-in form
        Then the other user should see a welcome message

    Scenario: User likes a post
        Given there is the new logged user on the posts page
        When the user clicks on the like button of the last post
        Then the user should see a noticed message
    
    Scenario: User add a comment
        Given the new user is on the post's detail page
        When the user fills in the information to add a comment
        And the user submits the comment
        Then the user should see the comment on the post's detail page

    Scenario: User follows the post
        Given the new user is on the post's detail page
        When the user clicks on the follow button
        Then the user should see a bell and a noticed message

