class Post < ActiveRecord::Base
  validates :title, presence: true,length: {minimum: 5}
  validates :body , presence: true
  
  belongs_to :user
  belongs_to :group
  has_many :comments, as: :commentable, dependent: :destroy
end
