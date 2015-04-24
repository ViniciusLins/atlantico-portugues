# == Schema Information
#
# Table name: documents
#
#  id             :integer         not null, primary key
#  title          :string
#  author         :string
#  description    :text
#  keywords       :string
#  published_year :integer
#  publisher      :string
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class Document < ActiveRecord::Base
  # Paperclip configurations
  has_attached_file :file


  validates_attachment :file, content_type: { content_type: "application/pdf" }
  validates :file, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :file
  validates_with AttachmentSizeValidator, :attributes => :file, :less_than => 50.megabytes

  validates :title,   presence: true
  validates :author,  presence: true
  validates :keywords, presence: true


  searchable do
    text :keywords, boost: 3
    text :title, boost: 4 
    text :author 
    text :description
    text :publisher
    boolean :is_private

    integer :published_year
  end

  #def self.search(query)
  #  if !query.blank?
  #    where("title ILIKE ?", "%#{query}%")
  #  else
  #    all()
  #  end
  #end
end
