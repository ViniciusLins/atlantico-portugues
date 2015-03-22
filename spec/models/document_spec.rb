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

end
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

