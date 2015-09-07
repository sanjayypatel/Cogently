class UserPolicy < ApplicationPolicy

  def show?
    record == user
  end

  def edit?
    show? || record.organization.moderator == user
  end

  def update?
    show? || record.organization.moderator == user
  end

  def invite?
    true
  end

end