require 'rubygems'
require 'pdf/reader'
require 'uri'

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
    organization: first_organization
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

#Seed Documents and summaries

5.times do |n|
  document = Document.new(
    name: "document#{n + 1}",
    user: first_user,
    organization: first_organization
  )
  document.file.store!(File.open(File.join(Rails.root, 'test/fixtures/test.pdf')))
  io = open(document.path_to_file)
  reader = PDF::Reader.new(io)
  document.content = document.process_new_document(reader.to_html)
  document.save!
  first_organization.tag(document, on: :tags, with: "tag#{n}")
  summary = Summary.new(
    body: "Summary for document#{n + 1}",
    document: document
  )
  summary.save!
end

5.times do |n|
  document = Document.new(
    name: "document#{n + 6}",
    user: second_user,
    organization: second_organization
  )
  document.file.store!(File.open(File.join(Rails.root, 'test/fixtures/test.pdf')))
  io = open(document.path_to_file)
  reader = PDF::Reader.new(io)
  document.content = document.process_new_document(reader.to_html)
  document.save!
  second_organization.tag(document, on: :tags, with: "tag#{n + 6}")
  summary = Summary.new(
    body: "Summary for document#{n + 6}",
    document: document
  )
  summary.save!
end

# Seed Events

5.times do |n|
  event = Event.new(
    title: "Event#{n + 1}",
    organization: first_organization,
    start_time: Date.today + n
  )
  event.users << first_user
  event.summaries << first_organization.documents.first.summary
  event.save!
end

5.times do |n|
  event = Event.new(
    title: "Event#{n + 6}",
    organization: second_organization,
    start_time: Date.today + n
  )
  event.users << second_user
  event.summaries << second_organization.documents.first.summary
  event.save!
end

#Seed Feeds
tags = ActsAsTaggableOn::Tag.all
tags.each_with_index do |tag, index|
  feed = Feed.new(
    tag: tag.name,
    user: User.find(1)
  )
  feed.save!
end

puts "Finished Seeding"
puts "#{User.count} users created."
puts "#{Organization.count} organizations created."
puts "#{Membership.count} memberships created."
puts "#{Document.count} documents created."
puts "#{Summary.count} summaries created."
puts "#{Event.count} events created."
puts "#{ActsAsTaggableOn::Tag.count} tags created."
puts "#{Feed.count} feeds created."