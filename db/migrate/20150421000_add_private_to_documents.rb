class AlterDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.boolean :is_private
    end
  end

  def self.down
    remove_attachment :documents, :is_private
  end

