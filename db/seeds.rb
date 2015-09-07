# Seed Organization
organization = Organization.new(
  name: 'New Organization'
)
organization.save!

# Seed Member User
member_user = User.new(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld',
  role: 'manager'
)
member_user.skip_confirmation!
member_user.save!
# Set moderator for seeded organization
organization.update_attribute(:moderator_id, member_user.id)

# Seed more Users
5.times do |n|
  user = User.new(
    name: "Member #{n}",
    email: "member#{n}@example.com",
    password: 'helloworld',
    role: 'staff'
  )
  user.skip_confirmation!
  user.save!
end

#Seed Membership
membership = Membership.new(
  confirmed: true,
  user: member_user,
  organization: organization
)
membership.save!


puts "Finished Seeding"
puts "#{User.count} users created."
puts "#{Organization.count} organizations created."
puts "#{Membership.count} memberships created."