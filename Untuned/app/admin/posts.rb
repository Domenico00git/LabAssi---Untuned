ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  #permit_params do
    #permitted = [:user_id, :content, :label]
    #permitted << :other if params[:action] == 'create' && current_user.admin?
    #permitted
  #end

  permit_params :label, :content, :comments_enabled

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :label
      f.input :content
      f.input :comments_enabled
    end
    f.actions
  end
  
end
