# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.find_by_email("admin@admin.com").nil?
  User.create!(email:"admin@admin.com", password:"aaabbb", name:"관리자", phone:"010-9999-9999", birthday: Time.now) 
end