class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @membership = current_user.memberships.first
    if @membership && @membership.confirmed
      @organization = current_user.organizations.first
    else
      @organization = nil
    end
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
    else
      flash[:error] = "Invalid user information"
    end
    redirect_to edit_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end