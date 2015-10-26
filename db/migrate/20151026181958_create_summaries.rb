class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.text :body
      t.references :document

      t.timestamps null: false
    end
  end
end
