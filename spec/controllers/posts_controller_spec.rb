require 'rails_helper'

describe  PostsController do 

	# describe 'GET #new' do
 #    it "requires login" do
 #    	FactoryGirl.create(:group)
 #      get :new
 #      expect(response).to redirect_to new_user_session_path
 #    end
 #  end

 #  describe "POST #create" do  

 #  	 it "requires login" do
 #      post :create, contact: FactoryGirl.attributes_for(:post)
 #      expect(response).to redirect_to login_url
 #    end
    
 #    context "with valid attributes" do
 #      it "should redirect to index with notice on successful save" do
 #        expect{
 #        post :create, post: FactoryGirl.attributes_for(:post)
 #      }.to change(Post,:count).by(1)
 #      end  
 #    end  
 #  end  
      
 #  describe "GET #index" do
 #    it "matches the routes" do
 #    	FactoryGirl.create(:group)
 #    	FactoryGirl.create(:post)  	
 #      expect(:get => '/groups/:group_id/posts').to route_to(:controller => "posts", :action => "index", :group_id => ":group_id")
 #    end
 #  end

 #  describe "GET #show" do
 #  	login_user
 #    it "assigns the requested post to @post" do
 #      FactoryGirl.create(:group)
 #      post = FactoryGirl.create(:post)
 #      get :show, id: post
 #    end
 #    it "renders the #show view" do
 #    	FactoryGirl.create(:group)
 #      get :show, id: FactoryGirl.create(:post)
 #      expect(response).to render_template("show")
 #    end
 #  end
end