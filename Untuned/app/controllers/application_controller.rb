class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_notifications, if: :current_user

    def access_denied(exception)
        redirect_to root_path, alert: exception_message
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
