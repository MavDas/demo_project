class Group < ActiveRecord::Base
	validates :name, presence: true
	validates :description, presence: true
	
	has_many :users, through: :memberships
	has_many :memberships, :dependent => :destroy
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :memberships, :allow_destroy => true
end
