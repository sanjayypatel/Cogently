class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.string :content
      t.references :document, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
