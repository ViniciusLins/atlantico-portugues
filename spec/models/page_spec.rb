require 'spec_helper'

describe Page do
  before do
    @page = FactoryGirl.create(:page)
  end

  subject { @page }

  it { should respond_to(:title) }
  it { should respond_to(:body) }

  it { should be_valid }

  describe "when title is not present" do
    before { @page.title = "  " }
    it { should_not be_valid }
  end
  
end
