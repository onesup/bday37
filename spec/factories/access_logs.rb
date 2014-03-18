# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_log do
    user ""
    device "MyString"
    ip "MyString"
    referer "MyString"
  end
end
