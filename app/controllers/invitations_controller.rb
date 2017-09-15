class InvitationsController < Devise::InvitationsController
  
  authorize_resource :class => false, :only => :new
  
  def new
    self.resource = resource_class.new
    render :layout => false
  end

end