# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:name => "admin", :username => "admin", :password => "admin", :email => "root@localhost.localdomain" )
Account.create(:name => "openescalardemo", :email => "openescalar@gmail.com" )
a = User.find_by_username("openescalardemo")
a.password = "demo"
a.save
