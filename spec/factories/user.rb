# user.rb

FactoryGirl.define do
  factory :user do
    name "Douglas Adams"
    email "douglas@example.com"
    password "helloworld"
    confirmed_at Time.now
  end
end