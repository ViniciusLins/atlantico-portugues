class AddLastContributorToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :last_contributor, :string
  end
end
