class InvitationsController < Devise::InvitationsController
  private
  def invite_resource
    resource_class.invite!(invite_params, current_inviter) do |u|
      @organization = current_inviter.organization
      @membership = Membership.new(organization: @organization, user: u, confirmed: false)
      @membership.save
    end
  end

  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    @membership = resource.membership
    @membership.update_attribute(:confirmed, true)
    resource
  end

end