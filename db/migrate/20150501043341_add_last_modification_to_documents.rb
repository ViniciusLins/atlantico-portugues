class AddLastModificationToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :last_modification, :datetime
  end
end
