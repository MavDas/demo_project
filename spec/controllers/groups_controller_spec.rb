require 'rails_helper'
require 'support/controller_macros'
RSpec.describe  GroupsController, :type => :controller do 
  before :each do  
    role = FactoryGirl.create(:role)  
    user = FactoryGirl.create(:user) 
    @group = FactoryGirl.create(:group) 
    allow(request.env['warden']).to receive(:authenticate!).and_return(@user)  
    allow(controller).to receive(:current_user).and_return(@user)
  end
	# describe 'GET #new' do
 #    it "requires login" do
 #    	get :new
 #      expect(response).to redirect_to new_user_session_path
 #    end
 #  end
  describe "POST create" do
    login_user
    it "sets a flash[:notice] message" do
      expect(controller).to set_flash[:notice].to("Group was successfully created.")
    end
    it "should redirect" do
      expect(response).to redirect_to(groups_path)
    end
  end
 #  describe "POST #create" do
 #    it "requires login" do
 #      post :create, post: FactoryGirl.attributes_for(:post)
 #      expect(response).to redirect_to new_user_session_path
 #    end
 #  end

 #  describe "GET #index" do
 #  	login_user
 #  	it "responds successfully with an HTTP 200 status code" do
 #      get :index
 #      expect(response).to be_success
 #      expect(response).to have_http_status(200)
 #    end
  	
 #  	it "renders the index template" do
 #      get :index
 #      expect(response).to render_template("index")
 #    end
    
 #    it "matches the index of groups" do
 #      expect(:get => '/groups').to route_to(:controller => "groups", :action => "index")
 #    end

 #    context "with invalid attributes" do
    
 #      it "does not save the new group" do
 #        expect{
 #          post :create, group: FactoryGirl.attributes_for(:invalid_group)
 #        }.to_not change(Group, :count)
 #      end
     
 #      it "re-renders the new method" do
 #        post :create, group: FactoryGirl.attributes_for(:invalid_group)
 #        expect(response).to render_template("new")
 #      end
 #    end

 #  end

 #  describe "GET #show" do
 #    login_user
 #    it "assigns the requested group to @group" do
 #      group = FactoryGirl.create(:group)
 #      get :show, id: group
 #    end
    
 #    it "renders the #show view" do
 #      get :show, id: FactoryGirl.create(:group)
 #      expect(response).to render_template("show")
 #    end
 #  end

 #  describe 'DELETE destroy' do
 #    login_user
 #    context "success" do
 #      it "deletes the group" do
 #        group = FactoryGirl.create(:group,name: "delete")
 #        Group.destroy((Group.find_by name: "delete").id)
 #        expect(response).to have_http_status(200)
 #      end
 #    end
 #  end

end