ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  #permit_params do
    #permitted = [:email, :encrypted_password, :username, :admin]
    #permitted << :other if params[:action] == 'create' && current_user.admin?
    #permitted
  #end

  permit_params :email, :name, :lastname, :username, :admin

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :email
      f.input :username
      f.input :name
      f.input :lastname
      f.input :admin
    end
    f.actions
  end
  
  index do
    column :id
    column :email
    column :name
    column :lastname
    column :birthdate
    column :admin
    column :provider
    column :uid
    column :avatar_url
    column :access_token
    column :created_at
    column :confirmed_at
    column :updated_at
    actions
  end
end
