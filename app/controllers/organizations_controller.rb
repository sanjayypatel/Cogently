class OrganizationsController < ApplicationController

  def show
    @organization = Organization.find(params[:id])
    authorize @organization
    @members = @organization.users
    @moderator = @organization.moderator
    @documents = @organization.documents
    if user_signed_in?
      @membership = current_user.membership
    end
  end

  def edit
    @organization = Organization.find(params[:id])
    authorize @organization
    @moderator = @organization.moderator
    @members = @organization.users
    @invited_users = @organization.invitees
    if params[:search]
      @found_users = @organization.search_for_invitable_users(params[:search])
      @query = params[:search]
    else
      @found_users = nil
    end
  end

  def update
    @organization = Organization.find(params[:id])
    authorize @organization
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
