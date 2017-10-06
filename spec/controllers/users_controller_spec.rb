require 'rails_helper'
require 'support/controller_macros'
RSpec.describe  UsersController, :type => :controller do 
  before :each do  
    role = FactoryGirl.create(:role)  
    @user = FactoryGirl.create(:user, email: 'todelete@gmaail.com', role_id: 1)  
    allow(request.env['warden']).to receive(:authenticate!).and_return(@user)  
    allow(controller).to receive(:current_user).and_return(@user)
  end
  # describe 'GET #new' do
  #   it "requires login" do
  #     FactoryGirl.create(:group)
  #     get :new
  #     expect(response).to redirect_to new_user_session_path
  #   end
  # end

  # describe "GET #index" do
  #   login_user
  # 	it "renders the index template" do
  #     get :index
  #     expect(response).to have_http_status(200)
  #   end
    
  #   it "matches the index of users" do
  #     expect(:get => '/admin/users').to route_to("controller"=>"users", "action"=>"index")
  #   end
  # end

  # describe 'POST #create' do
  #   it 'is database authenticable' do
  #     user = FactoryGirl.create(:user)
  #     expect(user.valid_password?('password')).to be_truthy
  #   end
  # end

  context 'DELETE #destroy' do 
    #comment loadandauthorise in users controller to make it pass    
    login_user    
    it ' delete user' do
      expect { delete :destroy, :id => @user.id }.to change(User, :count).by(-1)            
      expect(controller).to set_flash[:notice].to("User was successfully destroyed.")      
      # expect(flash[:notice]).to eq 'User was successfully deleted.'    
    end  
  end

  context 'PUT #update' do    
    let(:new_attributes) { FactoryGirl.attributes_for(:user, name: 'Maverick',email:"newemail@abc.com") }
    let(:valid_attributes) { FactoryGirl.attributes_for(:user, email: 'newemail@abc.com',name: 'Superadmin') }
    login_user      
    it "updates the requested user" do        
      user = User.create! valid_attributes        
      put :update, {:id => user.to_param, :user => new_attributes}        
      user.reload        
      expect(assigns(:user).attributes['name']).to match(new_attributes[:name])        
      expect(assigns(:user).attributes['email']).to match(new_attributes[:email])      
    end  
  end
end    