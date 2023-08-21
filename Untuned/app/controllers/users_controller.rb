class UsersController < ApplicationController
  require 'rest-client'
  require 'json'


  def show
    @user = User.find_by(username: params[:username])

    if @user.provider == "spotify"
      @currently_playing = currently_playing_info
    end
  end  


  
  private

  def user_params
    params.require(:user).permit(:name, :lastname, :birthdate, :image, :password, :password_confirmation, :current_password)
  end


  def currently_playing_info
    response = RestClient.get(
      'https://api.spotify.com/v1/me/player/currently-playing',
      { Authorization: "Bearer #{@user.access_token}" }

    )
    begin
      JSON.parse(response.body)
    rescue JSON::ParserError => e
      # In caso di errore nella lettura del JSON, restituisci un hash vuoto o un messaggio di errore
      {}
    end
  end
end
