class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true
      t.boolean :confirmed, :default => false

      t.timestamps null: false
    end
  end
end