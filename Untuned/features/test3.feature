Feature: Registered user sign in. Another user edit his account, sees the followers list and then follow the previos user

    Background:
        Given there is a guest on the sign-up page

        When the guest enters credential and information
        And the guest submits the sign-up form
        And the user confirms its profile
        And the user goes to the login page
        And the user enters credential
        And the user submits the sign-in form
        Then the user should sees a welcome message

        Given the old user logs out
        When a new user logs in
        Then the user should sees a welcome message

    Scenario: the user edit his account

        Given the user goes to his profile page
        When user clicks on Edit my account button
        And the user changes some information and he updates it
        Then the user should sees a modified account notice
     
    Scenario: the user start follows another user, then he sees his own following list and at the end he stops following the previous user

        Given the user is in any page
        When current user searches for another user and goes on his profile page
        And the user clicks on Follow button
        Then the user should sees the following button

        When the user goes to his profile page
        And the user clicks on Following button
        Then the user should sees the account that he followed

        When current user searches for another user and goes on his profile page
        And the user clicks on Following button to unfollow someone
        Then the user should sees the Follow button