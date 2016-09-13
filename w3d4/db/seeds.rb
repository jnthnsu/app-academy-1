# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a = User.create!(user_name: "XslayerX")
b = User.create!(user_name: "The TRUMP")
c = User.create!(user_name: "Bob.rogers")

p1 = c.make_poll("what's wrong with this country?")

q1 = p1.add_question("Why?")
q2 = p1.add_question("Who?")
q3 = p1.add_question("What?")

a1 = q1.add_choice("Why not?")
a2 = q1.add_choice("Because.")
a3 = q2.add_choice("everyone.")
a4 = q3.add_choice("everything.")

a.respond(a1)
b.respond(a2)
a.respond(a3)
a.respond(a4)
