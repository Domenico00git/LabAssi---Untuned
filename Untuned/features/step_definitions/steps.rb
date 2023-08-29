Given('there is a guest on the sign-up page') do
    visit new_user_registration_path
end

When('the guest enters credential and information') do
    find('.field input[type="text"][id="name"]').set('test_name')
    find('.field input[type="text"][id="lastname"]').set('test_lastname')
    find('.field input[type="date"]').set('26/07/2000')
    find('.field input[type="text"][id="username"]').set('test_username')
    find('.field input[type="email"]').set('user@test.com')
    find('.field input[type="password"][id="password"]').set('password')
    find('.field input[type="password"][id="password_confirmation"]').set('password')
end

And('the guest submits the sign-up form') do
    click_button('Sign up')
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
end


And('the user confirms its profile') do
    sleep 5
    # Verifica che l'email di conferma sia stata inviata
    expect(ActionMailer::Base.deliveries.count).to eq(1)

    # Estrai il token dalla mail (estrai ultima email e da questa il token per la verifica dell'account)
    confirmation_email = ActionMailer::Base.deliveries.last
    confirmation_token = confirmation_email.body.raw_source.match(/confirmation_token=([^'"]+)/)[1]

    # Conferma l'account utilizzando il token
    visit user_confirmation_path(confirmation_token: confirmation_token)
end

Then('the user should sees a confirmation message') do
    expect(page).to have_content("Your email address has been successfully confirmed.")
end 

When('the user goes to the login page') do
    visit new_user_session_path
end 

And('the user enters credential') do
    expect(User.exists?(email: "user@test.com")).to be true
    find('.field input[type="email"]').set('user@test.com')
    find('.field input[type="password"]').set('password')
end

And('the user submits the sign-in form') do
    click_button('Log in')
end

Then('the user should sees a welcome message') do
    expect(page).to have_content("Signed in successfully.")
end

Given('the user goes to the posts page') do
    visit posts_path
end

When('the user clicks on the New post button') do
    visit new_post_path
end

And('the user fills in the information to create a new post') do
  fill_in 'label', with: 'This is the topic of the post'
  fill_in 'content', with: 'This is the content of the post'
end

And('the user submits the post') do
    click_button "Submit Post"
end

Then('the user should sees a notice and the new post') do
    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("This is the topic of the post")
    expect(page).to have_content("This is the content of the post")
end

When('the user clicks on the Edit post button') do
    visit edit_post_path(Post.last.id)
end
  
When('the user changes the post\'s content') do
    fill_in 'content', with: 'This is the modified content of the post'
end
  
Then('the user should sees a notice') do
    expect(page).to have_content("Post was successfully updated.")
end

When('the user clicks on the Delete post button') do
    click_button "Delete post"
end
  
Then('User should sees the notice: Post was successfully destroyed.') do
    expect(page).to have_content("Post was successfully destroyed.")
end

When('the user does not fill out the form to create a new post') do 
end
  
Then('the user should sees a notice with an error') do
    expect(page).to have_content("Content can't be blank")
    expect(page).to have_content("Label can't be blank")
end

Given('the old user logs out') do
    click_button "Log out"
end
  
Given('a new user logs in') do
    visit new_user_registration_path
    find('.field input[type="text"][id="name"]').set('test_name')
    find('.field input[type="text"][id="lastname"]').set('test_lastname')
    find('.field input[type="date"]').set('26/07/2000')
    find('.field input[type="text"][id="username"]').set('test_username1')
    find('.field input[type="email"]').set('user1@test.com')
    find('.field input[type="password"][id="password"]').set('password')
    find('.field input[type="password"][id="password_confirmation"]').set('password')
    click_button('Sign up')
    sleep 5

    # Verifica che l'email di conferma sia stata inviata
    expect(ActionMailer::Base.deliveries.count).to eq(2)
    # Estrai il token dalla mail (estrai ultima email e da questa il token per la verifica dell'account)
    confirmation_email = ActionMailer::Base.deliveries.last
    confirmation_token = confirmation_email.body.raw_source.match(/confirmation_token=([^'"]+)/)[1]
    # Conferma l'account utilizzando il token
    visit user_confirmation_path(confirmation_token: confirmation_token)
    sleep 1
    expect(page).to have_content("Your email address has been successfully confirmed.")
    sleep 1

    visit new_user_session_path
    sleep 1
    expect(User.exists?(email: "user1@test.com")).to be true
    find('.field input[type="email"]').set('user1@test.com')
    find('.field input[type="password"]').set('password')
    click_button('Log in')
    expect(page).to have_content("Signed in successfully.")
end

When('the user likes the last post') do
    visit like_post_path(Post.last)
end

Then('the user should sees a like post notice') do
    expect(page).to have_content('You successfully liked a post')
end

When('the user unlikes the last post') do
    visit unlike_post_path(Post.last)
end

Then('the user should sees an unlike post notice') do
    expect(page).to have_content('You successfully unliked a post')
end

When('the user dislikes the last post') do
    visit dislike_post_path(Post.last.id)
end

Then('the user should sees a dislike post notice') do
    expect(page).to have_content('You successfully disliked a post')
end

When('the user undislikes the last post') do
    visit undislike_post_path(Post.last.id)
end

Then('the user should sees an undislike post notice') do
    expect(page).to have_content('You successfully undisliked a post')
end

When('the user goes to the last post page') do
    visit post_path(Post.last)
end

And('the user fills the comment form') do
    fill_in 'comment_body', with: 'This is a comment example'
end
  
And('the user submits the comment') do
    click_button('Submit Comment')
end

Then('the user should sees the comment on the post\'s detail page') do
    expect(page).to have_content("comment was successfully created.")
    expect(page).to have_content("This is a comment example")
end

Given('the user is in the posts\' details page') do
end
  
When('the user clicks the disable comments buttons') do
    visit disable_comments_post_path(Post.last)
end
  
Then('the user should sees a notice and no one can comment that post') do
    expect(page).to have_content("Comments are disabled")
end
  
When('the user clicks on Enable comments button') do
    visit enable_comments_post_path(Post.last)
end
  
Then('all the users can comment that post again') do
    expect(page).to have_content("New comment")
end

When('the user clicks the follow button') do
    visit followpost_post_path(Post.last)
end
  
Then('the user starts to follow that post and he should sees a notice') do
    expect(page).to have_content("Successfully followed this post")
end
  
When('the user clicks the following button') do
    visit unfollowpost_post_path(Post.last)
end
  
Then('the user stops to follow that post and he should sees a notice') do
    expect(page).to have_content("Successfully unfollowed this post")
end

Given('the user goes to his profile page') do
    visit user_path(User.last.username)
end
  
When('user clicks on Edit my account button') do
    visit edit_user_registration_path
end
  
When('the user changes some information and he updates it') do
    find('.field input[type="text"][id="name"]').set('modified_test_name')
    find('.field input[type="text"][id="lastname"]').set('modified_test_lastname')
    find('.field input[type="password"][id="current_password"]').set('password')
    click_button "Update"
end
  
Then('the user should sees a modified account notice') do
    expect(page).to have_content("Your account has been successfully updated")
end

Given('the user is in any page') do
end

When('current user searches for another user and goes on his profile page') do
    visit user_path(User.find_by(username:"test_username").username)
end
  
When('the user clicks on Follow button') do
    visit follow_user_path(User.find_by(username:"test_username").username)
end
  
Then('the user should sees the following button') do
    expect(page).to have_content("Following")
end
  
When('the user clicks on Following button') do
    visit following_path()
end
  
Then('the user should sees the account that he followed') do
    expect(page).to have_content("test_username")
end

When('the user clicks on Following button to unfollow someone') do
    visit unfollow_user_path(User.find_by(username:"test_username").username)
end
  
Then('the user should sees the Follow button') do
    expect(page).to have_content("Follow")
end

When('user clicks on the Sign up here button') do
    visit new_user_registration_path
end
  
When('user does not enter all the credential and information') do
    find('.field input[type="text"][id="name"]').set('test_name')
    find('.field input[type="text"][id="lastname"]').set('test_lastname')
    find('.field input[type="date"]').set('26/07/2000')
    find('.field input[type="text"][id="username"]').set('test_username')
    find('.field input[type="password"][id="password"]').set('password')
    find('.field input[type="password"][id="password_confirmation"]').set('password')
end

And('the guest submits the sign up form') do
    click_button('Sign up')
end
  
Then('user should sees a notice and he can tries again to sign up') do
    expect(page).to have_content("Email can't be blank")
end
  
When('the user enters wrong credential') do
    expect(User.exists?(email: "user@test.com")).to be true
    find('.field input[type="email"]').set('user@test.com')
    find('.field input[type="password"]').set('wrong_password')
end

Then('the user has to try again to sign-in') do
    expect(page).to have_content("Login")
end