class OrganizationPolicy < ApplicationPolicy

  def new?
    !user.nil?
  end

  def create?
    user.moderated_organization.nil?
  end

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