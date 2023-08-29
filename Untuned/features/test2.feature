Feature: Registered user sign in and add a post, then the user can disables the comments. Another user likes the post and comments on it

    Background:
        Given there is a guest on the sign-up page

        When the guest enters credential and information
        And the guest submits the sign-up form
        And the user confirms its profile
        And the user goes to the login page
        And the user enters credential
        And the user submits the sign-in form
        And the user goes to the posts page
        And the user clicks on the New post button
        And the user fills in the information to create a new post
        And the user submits the post
        Then the user should sees a notice and the new post

    Scenario: The user disables the comment on his post and then rehabilitate it

        Given the user is in the posts' details page

        When the user clicks the disable comments buttons
        Then the user should sees a notice and no one can comment that post

        When the user clicks on Enable comments button
        Then all the users can comment that post again

    Scenario: Another user likes/unlikes/dislikes/undislikes the previous post
        
        Given the old user logs out
        And a new user logs in
        And the user goes to the posts page

        When the user likes the last post
        Then the user should sees a like post notice

        When the user unlikes the last post
        Then the user should sees an unlike post notice

        When the user dislikes the last post
        Then the user should sees a dislike post notice

        When the user undislikes the last post
        Then the user should sees an undislike post notice

    Scenario: Another user comments the post and then follows/unfollows it

        Given the old user logs out
        And a new user logs in
        And the user goes to the posts page

        When the user goes to the last post page
        And the user fills the comment form
        And the user submits the comment
        Then the user should sees the comment on the post's detail page

        When the user clicks the follow button
        Then the user starts to follow that post and he should sees a notice

        When the user clicks the following button
        Then the user stops to follow that post and he should sees a notice

