class Group < ActiveRecord::Base
	validates :name, presence: true
	validates :description, presence: true
	
	has_many :memberships, :dependent => :destroy
  has_many :users, through: :memberships
  has_many :posts, dependent: :destroy
end
