
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

Then('the user should see ca confirmation message') do
    expect(page).to have_content("Your email address has been successfully confirmed.")
end 

When('the user go to the login page') do
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

Then('the user should see a welcome message') do
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

Then('the user should see a notice and the new post') do
    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("This is the topic of the post")
    expect(page).to have_content("This is the content of the post")
end


Given('the user visits the posts page') do
    visit posts_path
end

When('the user likes the last post') do
    visit like_post_path(Post.last.id)
end

Then('the user should see a like post notice') do
    expect(page).to have_content('You successfully liked a post')
end

When('the user unlikes the last post') do
    visit unlike_post_path(Post.last.id)
end

Then('the user should see an unlike post notice') do
    expect(page).to have_content('You successfully unliked a post')
end

When('the user dislikes the last post') do
    visit dislike_post_path(Post.last.id)
end

Then('the user should see a dislike post notice') do
    expect(page).to have_content('You successfully disliked a post')
end

When('the user undislikes the last post') do
    visit undislike_post_path(Post.last.id)
end

Then('the user should see an undislike post notice') do
    expect(page).to have_content('You successfully undisliked a post')
end

When('the user goes to the last post page') do
    visit post_path(Post.last.id)
end

And('the user fill the comment form') do
    fill_in 'comment_body', with: 'This is a comment example'
end
  
And('the user submits the comment') do
    click_button('Submit Comment')
end

Then('the user should see the comment on the post\'s detail page') do
    expect(page).to have_content("comment was successfully created.")
    expect(page).to have_content("This is a comment example")
end
