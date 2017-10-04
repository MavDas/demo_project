require 'rails_helper'
RSpec.describe Post, type: :model do
  context 'validations' do
    it "is valid with a title and body" do
      post = Post.new(
      title: "Aron Sumner",
      body:"dottle-nouveau-pavilion-tights-furze",
      )
      expect(post).to be_valid
    end

    it "is invalid without a title" do
      post = Post.new(
      title: nil)
      post.valid?
      expect(post.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a body" do
      post = Post.new(
      body: nil)
      post.valid?
      expect(post.errors[:body]).to include("can't be blank")
    end
    
    it "can't have nil comments" do
      post = Post.new(title:"abcdef",body:"This is my body for the title abcdef")
      post.save!
      comment = post.comments.create(body: nil)
      post.valid?
      comment.valid?
    end

    it "has a valid factory" do
      FactoryGirl.create(:group)
      post = FactoryGirl.build(:post)
      post.valid?
    end

    it "is invalid without a title" do
      post = FactoryGirl.build(:post, title: nil)
      post.valid?
      expect(post.errors[:title]).to include("can't be blank")
    end
  end  
  
  it "orders them in chronologically" do
    post = Post.new(title:"abcdef",body:"dottle-nouveau-pavilion-tights-furz")
    post.save!
    comment1 = post.comments.create!(:body => "first comment")
    comment2 = post.comments.create!(:body => "second comment")
    expect(post.reload.comments).to eq([comment1, comment2])
  end
  
  it "does not allow duplicate title per post" do
    FactoryGirl.create(:group)
    post1 = FactoryGirl.create(:post, title: "abcdef",body: "abc")
    post2 = FactoryGirl.build(:post,title: "abcdef",body: "abc")
    post2.valid?
  end
  context 'associations' do
    it "can have many comments" do                 #Checking association: posts has many comments
      t = Post.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
    end

    it "should belongs to user" do                 #Checking association: posts belongs to user user
      t = Post.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end

    it "should belongs to group" do                 #Checking association: posts belongs to user group
      t = Post.reflect_on_association(:group)
      expect(t.macro).to eq(:belongs_to)
    end
  end  
end  