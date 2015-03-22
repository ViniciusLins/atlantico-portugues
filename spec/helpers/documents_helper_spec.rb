require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the DocumentsHelper. For example:
#
# describe DocumentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe DocumentsHelper do
  describe "limit_string" do
    describe "with a bigger string" do
      let(:mystr) { "a" * 500 }
      it "should not be greater than 258 characters" do
        limit_string(mystr).size.should == 258 
      end
      it "should append ..." do
        limit_string(mystr).should =~ /\.\.\./
      end
    end

    describe "with a small string" do
      let(:mystr) { "a" * 20 }
      it "should have same size" do
        limit_string(mystr).size.should == 20
      end
      it "should_not append ..." do
        limit_string(mystr).should_not =~ /\.\.\./
      end
    end
  end
end
