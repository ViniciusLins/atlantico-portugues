class RemoveLastContributorFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :last_contributor, :string
  end
end
