class AdminAuthorization < ActiveAdmin::AuthorizationAdapter

    # questo metodo server per definire l'autorizzazione per l'accesso all'admin area, solo gli utenti admin possono accedere
    # vedi in config -> initializers -> active_admin.rb (config.authorization_adapter = "AdminAuthorization")
    def authorized?(action, subject = nil)
        user && user.admin?
    end
end