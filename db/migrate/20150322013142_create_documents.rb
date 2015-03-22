class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :author
      t.text :description
      t.string :keywords
      t.integer :published_year
      t.string :publisher

      t.timestamps null: false
    end
  end
end
