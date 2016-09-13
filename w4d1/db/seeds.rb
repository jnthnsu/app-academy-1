# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(username: 'a')
User.create!(username: 'b')

Contact.create!(user_id: 1, name: 'foo', email: 'a@a.com')
Contact.create!(user_id: 2, name: 'bar', email: 'b@b.com')

ContactShare.create!(user_id: 1, contact_id: 2)
