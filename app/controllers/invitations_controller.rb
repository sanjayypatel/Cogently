class InvitationsController < Devise::InvitationsController
  private
  def invite_resource
    resource_class.invite!(invite_params, current_inviter) do |u|
      @organization = current_inviter.organization
      u.invited_organization = @organization
      u.skip_confirmation!
      u.save
    end
  end

  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    @membership = Membership.new(organization: resource.invited_organization, user: resource)
    resource.invited_organization = nil
    resource.save
    @membership.save
    resource
  end

end