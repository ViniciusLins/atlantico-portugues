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

require 'spec_helper'

describe Document do

  before do
    @document = FactoryGirl.create(:document)
  end

  subject { @document }

  it { should respond_to(:title) }
  it { should respond_to(:author) }
  it { should respond_to(:description) }
  it { should respond_to(:keywords) }
  it { should respond_to(:published_year) }
  it { should respond_to(:publisher) }
  it { should respond_to(:file) }
  it { should respond_to(:is_private)}
  it { should respond_to(:user_id)}
  # Test validations
  describe "when title is not present" do
    before { @document.title = "  " }
    it { should_not be_valid }
  end

  describe "when author is not present" do
    before { @document.author = "  " }
    it { should_not be_valid }
  end

  describe "when keywords is not present" do
    before { @document.keywords = "  " }
    it { should_not be_valid }
  end

  describe "when file size is greather than 50 mb" do
    before { @document.file_file_size = 51.megabytes }
    it { should_not be_valid }
  end
 describe "when file type not is pdf" do
    before { @document.file_content_type = 'image/png' }
    it { should_not be_valid }
  end
# it is dispensable
=begin 
  describe "when flag to is private is not set  " do
    before {@document.is_private = false}
    it { should_not be_valid }
  end
=end
end
