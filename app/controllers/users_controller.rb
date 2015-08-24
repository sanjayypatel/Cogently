class UsersController < ApplicationController

  def show
    @membership = current_user.memberships.first
    if @membership && @membership.confirmed
      @organization = current_user.organizations.first
    else
      @organization = nil
    end
  end

end
