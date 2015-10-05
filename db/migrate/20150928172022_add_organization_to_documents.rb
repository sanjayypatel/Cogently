class AddOrganizationToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :organization, index: true, foreign_key: true
  end
end
