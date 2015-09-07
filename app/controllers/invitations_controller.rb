class InvitationsController < Devise::InvitationsController
  private
  def invite_resource
    resource_class.invite!(invite_params, current_inviter) do |u|
      @organization = current_inviter.organization
      u.invited_organization = @organization
      u.save!
    end
  end

  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    @membership = Membership.new(organization: u.invited_organization, user: u, confirmed: true)
    @membership.save
    resource
  end

end