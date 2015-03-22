require 'spec_helper'

describe "Documents" do
  describe "index page" do
    let!(:document) { FactoryGirl.create(:document) }
    before { visit documents_path }
    
  end

end
