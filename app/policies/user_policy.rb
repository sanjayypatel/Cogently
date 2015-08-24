class UserPolicy < ApplicationPolicy

  def show?
    record.id == user.id
  end

  def edit?
    show?
  end

  def update?
    show?
  end

end