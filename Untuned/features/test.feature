Feature: User sign up, sign in and add a post

    Background:
        Given there is a guest on the sign-up page

        When the guest enters credential and information
        And the guest submits the sign-up form
        And the user confirms its profile
        Then the user should see ca confirmation message

        When the user go to the login page
        And the user enters credential
        And the user submits the sign-in form
        Then the user should see a welcome message

    Scenario: User creates a new post
        Given the user goes to the posts page

        When the user clicks on the New post button
        And the user fills in the information to create a new post
        And the user submits the post
        Then the user should see a notice and the new post
    
    Scenario: The user likes/unlikes/dislikes/undislikes the post and comments on it 
        Given the user visits the posts page

        When the user likes the last post
        Then the user should see a like post notice

        When the user unlikes the last post
        Then the user should see an unlike post notice

        When the user dislikes the last post
        Then the user should see a dislike post notice

        When the user undislikes the last post
        Then the user should see an undislike post notice

        When the user goes to the last post page
        And the user fill the comment form
        And the user submits the comment
        Then the user should see the comment on the post's detail page


