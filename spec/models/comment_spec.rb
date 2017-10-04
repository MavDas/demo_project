require 'rails_helper'

RSpec.describe Comment do
  
  it "is valid with a body" do
    comment = Comment.new(body: "This is test comment")
    expect(comment).to be_valid
  end
  it "is invalid without a body" do
    comment = Comment.new(body: nil)
    comment.valid?
    expect(comment.errors[:body]).to include("can't be blank")
  end
  it "should have many comments" do                 #Checking association 
    t = Comment.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end
  it "should belong to post or a comment" do                 #Checking association 
    t = Comment.reflect_on_association(:commentable)
    expect(t.macro).to eq(:belongs_to)
  end
  
end