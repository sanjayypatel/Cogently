class AddUserToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :user, index: true, foreign_key: true
  end
end
