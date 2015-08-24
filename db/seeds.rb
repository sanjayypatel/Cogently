organization = Organization.new(
  name: 'New Organization'
)
organization.save!
user = User.new(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld',
  organization: organization
)
user.skip_confirmation!
user.save!
5.times do |n|
  user = User.new(
    name: 'Member #{n}',
    email: Faker::Internet.email,
    password: 'helloworld'
  )
  user.skip_confirmation!
  user.save!
end

puts "Finished Seeding"
puts "#{User.count} users created."
puts "#{Organization.count} organizations created."