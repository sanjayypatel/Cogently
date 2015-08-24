class OrganizationPolicy < ApplicationPolicy

  def show?
    record.users.are_confirmed_members.include?(user)
  end

  def edit?
    record.moderator == user
  end

  def update?
    edit?
  end

end