class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    authorize @user
    if @user.has_pending_invitation?
      @invited_organization = Organization.find(@user.invited_organization_id)
    end
    if @user.membership.nil?
      @membership = Membership.new
      @organization = nil
    else
      @membership = @user.membership
      @organization = @user.organization
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(user_params)
      flash[:notice] = "User information updated"
    else
      flash[:error] = "Invalid user information"
    end
    redirect_to request.referer || edit_user_registration_path
  end

  def invite
    @user = User.find(params[:user][:id])
    authorize @user
    if @user.update_attributes(user_params)
      flash[:notice] = 'User invited.'
    else
      flash[:error] = 'Invalid user information'
    end
    redirect_to request.referer || edit_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :invited_organization_id)
  end
end
