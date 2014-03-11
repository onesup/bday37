# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coupon do
    user nil
    code "MyString"
    status "MyString"
    used_at "2014-03-11 16:05:54"
  end
end
