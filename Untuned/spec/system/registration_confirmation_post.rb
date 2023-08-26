require 'rails_helper'

RSpec.describe "User registration, confirmation via email, post creation", type: :system do
   
    it "register a new user, confirms the account and create a new post" do

        # creazione nuovo utente 
        visit new_user_registration_path

        find('.field input[type="text"][id="name"]').set('example_name')
        sleep 1
        find('.field input[type="text"][id="lastname"]').set('example_lastname')
        sleep 1
        find('.field input[type="date"]').set('26/07/2000')
        sleep 1
        find('.field input[type="text"][id="username"]').set('example_username')
        sleep 1
        find('.field input[type="email"]').set('user@example.com')
        sleep 1
        find('.field input[type="password"][id="password"]').set('password')
        sleep 1
        find('.field input[type="password"][id="password_confirmation"]').set('password')
        sleep 1
        click_button('Sign up')
        
        sleep 5
        # Verifica che l'email di conferma sia stata inviata
        expect(ActionMailer::Base.deliveries.count).to eq(1)

        # Estrai il token dalla mail
        confirmation_email = ActionMailer::Base.deliveries.last
        #confirmation_token = confirmation_email.body.raw_source.match(/confirmation_token=(\w+)/)[1]
        confirmation_token = confirmation_email.body.raw_source.match(/confirmation_token=([^'"]+)/)[1]

        
        # Conferma l'account utilizzando il token
        visit user_confirmation_path(confirmation_token: confirmation_token)
        sleep 5

        # Login nuovo utente
        visit new_user_session_path
        expect(User.exists?(email: "user@example.com")).to be true
        find('.field input[type="email"]').set('user@example.com')
        find('.field input[type="password"]').set('password')
        click_button('Log in')
        sleep 5

        # creazione post
        visit posts_path
        sleep 5
        visit new_post_path

        # Riempire il campo "Topic"
        fill_in 'label', with: 'This is the topic of the post'
        sleep 1
        # Riempire il campo "Content"
        fill_in 'content', with: 'This is the content of the post'
        sleep 1
        click_button "Submit Post"
        sleep 5

        # Controllo che il post sia stato creato correttamente
        expect(page).to have_content("Post was successfully created.")
        expect(page).to have_content("This is the topic of the post")
        expect(page).to have_content("This is the content of the post")
    end
end