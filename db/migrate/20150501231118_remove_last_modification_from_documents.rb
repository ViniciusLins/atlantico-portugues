class RemoveLastModificationFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :last_modification, :string
  end
end
