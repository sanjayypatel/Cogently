# Seed Organizations
first_organization = Organization.new(
  name: 'New Organization 1'
)
first_organization.save!

second_organization = Organization.new(
  name: 'New Organization 2'
)
second_organization.save!
organizations = Organization.all

# Seed First Moderator
first_user = User.new(
  name: 'First User',
  email: 'first@example.com',
  password: 'helloworld',
  role: 'manager'
)
first_user.skip_confirmation!
first_user.save!
# Seed Member User
second_user = User.new(
  name: 'Second User',
  email: 'second@example.com',
  password: 'helloworld',
  role: 'manager'
)
second_user.skip_confirmation!
second_user.save!
# Set moderator for seeded organizations
first_organization.update_attribute(:moderator_id, first_user.id)
second_organization.update_attribute(:moderator_id, second_user.id)
#Seed Membership
membership = Membership.new(
  user: first_user,
  organization: first_organization
)
membership.save!
membership = Membership.new(
  user: second_user,
  organization: second_organization
)
membership.save!
# Seed more Users with memberships
5.times do |n|
  user = User.new(
    name: "Member#{n + 1}",
    email: "member#{n + 1}@example.com",
    password: 'helloworld',
    role: 'staff'
  )
  user.skip_confirmation!
  user.save!
  membership = Membership.new(
    user: user,
    organization: organizations.sample
  )
  membership.save!
end

# Seed unaffiliated Users
5.times do |n|
  user = User.new(
    name: "User#{n + 1}",
    email: "user#{n + 1}@example.com",
    password: 'helloworld',
    role: 'staff'
  )
  user.skip_confirmation!
  user.save!
end

puts "Finished Seeding"
puts "#{User.count} users created."
puts "#{Organization.count} organizations created."
puts "#{Membership.count} memberships created."