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
  validates :title,   presence: true
  validates :author,  presence: true
  validates :keywords, presence: true
end
