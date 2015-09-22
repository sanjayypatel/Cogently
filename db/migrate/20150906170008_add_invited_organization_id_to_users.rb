class AddInvitedOrganizationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invited_organization_id, :integer
  end
end
