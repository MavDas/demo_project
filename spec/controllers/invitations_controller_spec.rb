require 'rails_helper'
require 'support/controller_macros'
RSpec.describe  InvitationsController, :type => :controller do 

  describe "GET #new" do
  	login_user
    
  	it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  	
  	it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
    
  end
end 