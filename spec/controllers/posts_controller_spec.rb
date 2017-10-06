require 'rails_helper'

describe  PostsController do 

	describe 'GET #new' do
    it "requires login" do
    	group = FactoryGirl.create(:group)
    	post = FactoryGirl.create(:post)
    	get :new, {group_id: group.id}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "POST #create" do  

  	 it "requires login" do
  	 	group = FactoryGirl.create(:group)
      post :create, {contact: FactoryGirl.attributes_for(:post), group_id: group.id}
      expect(response).to redirect_to new_user_session_path
    end
    
    context "with valid attributes" do
    	login_user
      it "should redirect to index with notice on successful save" do
      	group = FactoryGirl.create(:group)
        post :create, {post: FactoryGirl.attributes_for(:post), group_id: group.id}
        expect(response).to redirect_to group_posts_path
       end  
    end  
  end  
      
  describe "GET #index" do
    it "matches the routes" do
    	group = FactoryGirl.create(:group)
    	post = FactoryGirl.create(:post)  	
      expect(:get => group_posts_path(group.id)).to route_to(:controller => "posts", :action => "index", :group_id => "#{group.id}")
    end
  end

  # describe "GET #show" do
  # 	login_user
  #   it "assigns the requested post to @post" do
  #     group = FactoryGirl.create(:group)
  #     post = FactoryGirl.create(:post)
  #     get :show, {group_id: group.id , post_id: post.id}
  #     expect
  #   end
  #   it "renders the #show view" do
  #   	group = FactoryGirl.create(:group)
  #   	post = FactoryGirl.create(:post)
  #     get :show, { group_id: group.id , post_id: post.id}
  #     expect(response).to render_template("show")
  #   end
  # end
end