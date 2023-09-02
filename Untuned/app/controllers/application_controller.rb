class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    protect_from_forgery with: :null_session

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_notifications, if: :current_user

    def access_denied
        redirect_to root_path
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :lastname, :birthdate, :image])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :lastname, :birthdate, :image])
    end

    private

    def set_notifications
        notifications = Notification.where(recipient: current_user).newest_first.limit(9)
        @unread = notifications.unread
        @read = notifications.read

    end

end
