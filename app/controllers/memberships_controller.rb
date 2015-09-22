class MembershipsController < ApplicationController

  def create
    @organization = Organization.find(params[:organization_id])
    @membership = Membership.new(membership_params)
    @membership.update_attribute(:organization, @organization)
    @user = User.find(membership_params[:user_id])
    if @membership.save
      @user.update_attribute(:invited_organization_id, nil)
      flash[:notice] = "Membership confirmed."
    else
      flash[:error] = "There was an error confirming membership."
    end
    redirect_to organization_path(@organization)
  end

  def update
    @membership = Membership.find(params[:id])
    @user = User.find(membership_params[:user_id])
    if @membership.update_attributes(membership_params)
      @user.update_attribute(:invited_organization_id, nil)
      flash[:notice] = "Membership updated."
    else
      flash[:error] = "There was an error updating membership."
    end
    redirect_to user_path(current_user)
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :organization_id)
  end

end