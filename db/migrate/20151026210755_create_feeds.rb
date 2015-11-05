class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :tag
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
