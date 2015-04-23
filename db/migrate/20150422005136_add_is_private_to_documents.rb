class AddIsPrivateToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :is_private, :boolean
  end
end
