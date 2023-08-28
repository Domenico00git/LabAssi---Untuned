Feature: Registered user sign in and try to add, modify and delete a post

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

    Scenario: User creates a new post, edit it and delete it

        Given the user goes to the posts page

        When the user clicks on the New post button
        And the user fills in the information to create a new post
        And the user submits the post
        Then the user should see a notice and the new post

        When the user clicks on the Edit post button
        And the user change the post's content
        And the user submits the post
        Then the user should see a notice

        When the user clicks on the Delete post button
        Then User should see the notice: Post was successfully destroyed.


    Scenario: User creates a new post but he does not fill out the form

        Given the user goes to the posts page

        When the user clicks on the New post button
        And the user does not fill out the form to create a new post
        And the user submits the post
        Then the user should see a notice with an error
    
    


