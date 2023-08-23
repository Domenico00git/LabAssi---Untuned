class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'rest-client'
  require 'json'


  def show
    @user = User.find_by(username: params[:username])

    if @user.provider == "spotify"
      @currently_playing = currently_playing_info
      @top_tracks = top_tracks_info
      @top_artists = top_artists_info
      @following_artists = following_artists_info
      @album_library = album_library_info
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

  def top_tracks_info
    response = RestClient.get(
      'https://api.spotify.com/v1/me/top/tracks?time_range=medium_term',
      { Authorization: "Bearer #{@user.access_token}" }
    )

    begin
      JSON.parse(response.body)
    rescue JSON::ParserError => e
      # In caso di errore nella lettura del JSON, restituisci un hash vuoto o un messaggio di errore
      {}
    end
  end

  def top_artists_info
      response = RestClient.get(
      "https://api.spotify.com/v1/me/top/artists?time_range=medium_term",
      { Authorization: "Bearer #{@user.access_token}" }
    )
    
    begin
      JSON.parse(response.body)
    rescue JSON::ParserError => e
      # In caso di errore nella lettura del JSON, restituisci un hash vuoto o un messaggio di errore
      {}
    end
  end

  def following_artists_info
      response = RestClient.get(
      "https://api.spotify.com/v1/me/following?type=artist&limit=50",
      { Authorization: "Bearer #{@user.access_token}" }  
    )

    begin
      JSON.parse(response.body)
    rescue JSON::ParserError => e
      # In caso di errore nella lettura del JSON, restituisci un hash vuoto o un messaggio di errore
      {}
    end
  end


  def album_library_info
      response = RestClient.get(
      "https://api.spotify.com/v1/me/albums?limit=50",
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
