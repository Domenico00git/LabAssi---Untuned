
Given('there is a new user on the sign-up page') do
    visit new_user_registration_path
end

When('the user enter credential and information') do
    find('.field input[type="text"][id="name"]').set('example_name')
    find('.field input[type="text"][id="lastname"]').set('example_lastname')
    find('.field input[type="date"]').set('26/07/2000')
    find('.field input[type="text"][id="username"]').set('example_username1')
    find('.field input[type="email"]').set('user1@example.com')
    find('.field input[type="password"][id="password"]').set('password')
    find('.field input[type="password"][id="password_confirmation"]').set('password')
    sleep 1
end

When('the user submits the sign-up form') do
    click_button('Sign up')
    sleep 10
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
end

When('the user confirm its profile') do
    sleep 3
    # Verifica che l'email di conferma sia stata inviata
    expect(ActionMailer::Base.deliveries.count).to eq(1)

    # Estrai il token dalla mail (estrai ultima email e da questa il token per la verifica dell'account)
    confirmation_email = ActionMailer::Base.deliveries.last
    confirmation_token = confirmation_email.body.raw_source.match(/confirmation_token=([^'"]+)/)[1]

    # Conferma l'account utilizzando il token
    visit user_confirmation_path(confirmation_token: confirmation_token)
    expect(page).to have_content("Your email address has been successfully confirmed.")

    sleep 5
end

Then('the user go to the login page') do
    visit new_user_session_path
end

Then('the user enter credential') do
    expect(User.exists?(email: "user1@example.com")).to be true
    find('.field input[type="email"]').set('user1@example.com')
    find('.field input[type="password"]').set('password')
end

Then('the user submit the sign-in form') do
    click_button('Log in')
end

Then('the user should see a welcome message') do
    expect(page).to have_content("Signed in successfully.")
end

Given('there is a logged user on the posts page') do
    visit new_user_session_path
    expect(User.exists?(email: "user@example.com")).to be true
    find('.field input[type="email"]').set('user@example.com')
    find('.field input[type="password"]').set('password')
    click_button('Log in')
    expect(page).to have_content("Signed in successfully.")
    visit posts_path
    sleep 2
end

When('the user clicks on the New post button') do
    visit new_post_path
    sleep 2
end

When('the user fills in the information to create a new post') do
  # Riempire il campo "Topic"
  fill_in 'label', with: 'This is the topic of the post'
  sleep 1
  # Riempire il campo "Content"
  fill_in 'content', with: 'This is the content of the post'
  sleep 1
end

When('the user submits the post') do
    click_button "Submit Post"
end

Then('the user should see the post on the post\'s detail page') do
    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("This is the topic of the post")
    expect(page).to have_content("This is the content of the post")
    sleep 5
end

Given('the user is on the post\'s detail page') do
    visit new_user_session_path
    expect(User.exists?(email: "user@example.com")).to be true
    find('.field input[type="email"]').set('user@example.com')
    find('.field input[type="password"]').set('password')
    click_button('Log in')
    expect(page).to have_content("Signed in successfully.")
    visit post_path(Post.last.id)
end

When('the user fills in the information to add a comment') do
  fill_in 'comment_body', with: 'This is a comment example'
end

When('the user submits the comment') do
    click_button('Submit Comment')
end

Then('the user should see the comment on the post\'s detail page') do
    expect(page).to have_content("comment was successfully created.")
end


