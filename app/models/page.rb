# == Schema Information
#
# Table name: pages
#
#  id         :integer         not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Page < ActiveRecord::Base
  include Bootsy::Container
  validates :title, presence: true
end
