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
organization.update_attribute(:moderator_id, user.id)
5.times do |n|
  user = User.new(
    name: "Member #{n}",
    email: "member#{n}@example.com",
    password: 'helloworld'
  )
  user.skip_confirmation!
  user.save!
end

puts "Finished Seeding"
puts "#{User.count} users created."
puts "#{Organization.count} organizations created."