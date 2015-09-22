class OrganizationPolicy < ApplicationPolicy

  def show?
    record.users.include?(user)
  end

  def edit?
    record.moderator == user
  end

  def update?
    edit?
  end

end