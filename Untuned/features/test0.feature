Feature: User tries to sign up and but he fails, then he signs up but he tries to sign in but he fails

    Scenario: User tries to sign up and but he fails

        Given there is a guest on the sign-up page

        When user clicks on the Sign up here button
        And user does not enter all the credential and information 
        And the guest submits the sign up form
        Then user should sees a notice and he can tries again to sign up

    Scenario: User signs up and then tries to sign in but he 

        Given there is a guest on the sign-up page

        When user clicks on the Sign up here button
        And the guest enters credential and information
        And the guest submits the sign-up form
        And the user confirms its profile
        Then the user should sees a confirmation message

        When the user goes to the login page
        And the user enters wrong credential
        And the user submits the sign-in form
        Then the user has to try again to sign-in