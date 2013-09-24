# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.find_by(username: 'admin')
  User.create!(username: 'admin', email: 'admin@flockr.com', password: 'flockr4lyf',
    password_confirmation: 'flockr4lyf')
end
