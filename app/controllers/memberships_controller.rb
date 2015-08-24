class MembershipsController < ApplicationController

  def create
    @organization = Organization.find(params[:organization_id])
    @membership = Membership.new(membership_params)
    @membership.update_attribute(:organization_id, params[:organization_id])
    if @membership.save
      flash[:notice] = "Member invited."
    else
      flash[:error] = "There was an error inviting user."
    end
    redirect_to edit_organization_path(@organization)
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id)
  end

end