require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    
    before { FactoryGirl.build(:user)}

    it{ should validate_presence_of(:name) }  
    it{ should validate_presence_of(:email) }
    it{ should validate_presence_of(:password) }
    
    it "is invalid without a name" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("Name can't be blank")
    end
    
    it "is invalid without an email address" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("Please enter a valid email id")
    end

    it "is invalid with a duplicate email address" do
      User.create(
        name: "Joe Tribbyani",
        email:"tester@example.com",
        password:"dottle-nouveau-pavilion-tights-furze",
      )
      user = User.new(
        name: "Ross Gellar",
        email:"tester@example.com",
        password:"dottle-nouveau-pavilion-tights-furze",
      )
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end  
      
  context 'association' do

    it {
    should have_many(:groups) }
    it { should have_many(:posts) }
    it { should have_many(:events) }
    it { should belong_to(:role) }
    it "should belong to group" do                 #Checking association user belongs to group
      t = User.reflect_on_association(:group)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  it "returns a user's full name as a string" do
    user = User.new(
      name: "Chandler Bing",
      email:"johndoe@example.com",
    )
    expect(user.name).to eq "Chandler Bing"
  end

end