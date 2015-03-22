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
  has_attached_file :file, styles: {thumbnail: "60x60#"}


  validates_attachment :file, content_type: { content_type: "application/pdf" }
  validates :file, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :file
  validates_with AttachmentSizeValidator, :attributes => :file, :less_than => 50.megabytes

  validates :title,   presence: true
  validates :author,  presence: true
  validates :keywords, presence: true
end
