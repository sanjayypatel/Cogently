class OrganizationPolicy < ApplicationPolicy

  def new?
    !user.is_confirmed_member?
  end

  def create?
    new?
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