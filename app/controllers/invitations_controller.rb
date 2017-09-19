class InvitationsController < Devise::InvitationsController
  
  authorize_resource :class => false, :only => [:new]
  
  def new
    self.resource = resource_class.new
    render :layout => false
  end

  def after_invite_path_for(resource)
    users_path
  end

end