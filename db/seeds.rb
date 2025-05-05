# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Cleaning database...'
# User.destroy_all


# puts 'Creating users...'
# (1..10).each do |i|
#   user = User.create!(
#     email_address: "user_#{i}@example.com",
#     password: 'password',
#     name: Faker::Name.name
#   )

#   puts "Created user: #{user.email_address}"
# end

# users = User.all
# puts 'Creating tasks...'
# users.each do |user|
#   rand(100..1000).times do |i|
#     task = user.tasks.create!(
#       title: "Task #{i} for #{user.name}",
#       priority: Task.priorities.keys.sample
#     )

#     puts "Created task: #{task.title} for user: #{user.email_address}"
#   end

#   rand(50..300).times do |i|
#     task = user.tasks.create!(
#       title: "Task #{i} for #{user.name}",
#       priority: Task.priorities.keys.sample,
#       done: true,
#       done_at: Time.current + rand(1..10).days
#     )

#     puts "Created task: #{task.title} for user: #{user.email_address}"
#   end
# end

tasks = Task.all
puts 'Creating task time logs...'
tasks.each do |task|
  rand(1..10).times do |i|
    task.time_logs.create!(
      recorded_at: Time.current - rand(1..10).days,
      duration_in_minutes: rand(40..200),
      user_id: task.user_id
    )
  end
end

puts "Stats: #{User.count} users, #{Task.count} tasks, #{TaskTimeLog.count} task time logs"
puts 'Done!'