# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(email: 'liangwitz@tfbnw.net', password: '12341234')

tasks = ['grape', 'ice', 'pill', 'work', 'night', 'soul'].each

2.times do |number|
  project = user.projects.create!(name: "project_#{number}")
  3.times do |task|
    project.tasks.create!(name: tasks.next)
  end
end
