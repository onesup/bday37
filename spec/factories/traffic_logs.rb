# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :traffic_log do
    ip "MyString"
    device "MyString"
    referer "MyString"
  end
end
