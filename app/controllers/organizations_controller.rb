class OrganizationsController < ApplicationController

  def show
    @organization = Organization.find(params[:id])
    @moderator = @organization.moderator
  end

  def edit
    @organization = Organization.find(params[:id])
    @moderator = @organization.moderator
    @members = @organization.users
    @membership = Membership.new
    if params[:search]
      @found_users = User.search(params[:search])
      @query = params[:search]
    else
      @found_users = nil
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(organization_params)
      flash[:notice] = "Organization updated."
      redirect_to organization_path
    else
      flash[:error] = "There was an error updating organization. Try again."
      render :edit
    end
  end

  private

  def organization_params
    params.require(:organization).permit([:name, :moderator_id])
  end

end
