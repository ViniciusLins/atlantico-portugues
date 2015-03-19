class Page < ActiveRecord::Base
  include Bootsy::Container
  validates :title, presence: true
end
