require 'faker'

FactoryGirl.define do

  factory :user do
    email "amanvimal@gmail.com"
    password "password"
    password_confirmation "password"
    name "Aman"
    confirmed_at Date.today
    approved 'true'
    role_id "1"
  end

end
