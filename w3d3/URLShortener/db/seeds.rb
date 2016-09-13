# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a = User.create!(email: 'abc@gmail.com')
b = User.create!(email: 'abcdef@gmail.com')

short_1 = ShortenedUrl.create_for_user_and_long_url!(a, 'http:google.com')
short_2 = ShortenedUrl.create_for_user_and_long_url!(b, 'http:yahoo.com')
short_3 = ShortenedUrl.create_for_user_and_long_url!(b, 'www.food.com')
short_4 = ShortenedUrl.create_for_user_and_long_url!(b, 'www.bing.com')
short_5 = ShortenedUrl.create_for_user_and_long_url!(b, 'www.espn.com')
short_6 = ShortenedUrl.create_for_user_and_long_url!(b, 'www.bagel.com')

visit_1 = Visit.record_visit!(a, short_2)
visit_2 = Visit.record_visit!(a, short_1)
visit_3 = Visit.record_visit!(b, short_1)

topic_1 = TagTopic.create!(topic: 'food')
topic_2 = TagTopic.create!(topic: 'sports')
topic_3 = TagTopic.create!(topic: 'search')

Tagging.create_tagged_url(topic_1, short_3)
Tagging.create_tagged_url(topic_1, short_6)
Tagging.create_tagged_url(topic_2, short_5)
Tagging.create_tagged_url(topic_3, short_1)
Tagging.create_tagged_url(topic_3, short_2)
Tagging.create_tagged_url(topic_3, short_4)
Tagging.create_tagged_url(topic_2, short_1)
