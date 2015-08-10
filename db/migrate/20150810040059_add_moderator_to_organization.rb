class AddModeratorToOrganization < ActiveRecord::Migration
  def change
    add_reference :organizations, :moderator, index: true, foreign_key: true
  end
end
