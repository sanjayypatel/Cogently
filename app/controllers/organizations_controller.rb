class OrganizationsController < ApplicationController

  def new
    @organization = Organization.new
    authorize @organization
  end

  def create
    @organization = Organization.new(organization_params)
    authorize @organization
    if @organization.save
      @membership = current_user.membership
      if @membership.nil?
        @membership = Membership.new(
          organization: @organization,
          user: current_user
        )
        @membership.save
      else
        @old_organization = @membership.organization
        @membership.update_attribute(:organization, @organization)
        @events = current_user.events
        @events.each do |event|
          event.users.delete(current_user)
        end
        @documents = current_user.documents
        @documents.each do |document|
          document.update_attribute(:user, @old_organization.moderator)
        end
      end
      flash[:notice] = "Organization created."
      redirect_to edit_organization_path(@organization)
    else
      flash[:error] = "There was an error creating organization. Try again."
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:id])
    authorize @organization
    @members = @organization.users
    @moderator = @organization.moderator
    @documents = @organization.documents.by_recently_updated
    @tags = @organization.owned_tags
    @trending_tags = @organization.owned_tags.most_used(5)
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
