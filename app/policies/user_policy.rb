class UserPolicy < ApplicationPolicy

  def show?
    record == user
  end

  def edit?
    show? || record.organizations.first.moderator == user
  end

  def update?
    show? || record.organizations.first.moderator == user
  end

end