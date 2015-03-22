# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string
#  remember_token  :string
#  admin           :boolean
#

require 'spec_helper'

describe User do
  before do 
    @user = FactoryGirl.create(:user) 
  end 

  subject{ @user }

  # test by requiring attributes
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  
  # test by requiring methods 
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before { @user.toggle!(:admin) }

    it { should be_admin }
  end

  describe "when name is not present" do
    before { @user.name = "  " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = "  " }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = "  " }
    it { should_not be_valid }
  end

  describe "when password doesn't match the confirmationp" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      invalid_email_addresses.each do |invalid_address|
        @user.should_not have_valid_email(invalid_address) 
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      valid_email_addresses.each do |valid_address|
        @user.should have_valid_email(valid_address)
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_that_taken_mail = User.new(name: "Foo Bar", email: "foobar@foo.com")
      @user_with_same_email = user_that_taken_mail.dup
      user_that_taken_mail.save 
    end

    it { @user_with_same_email.should_not be_valid }

    describe "with case insensitive check" do
      before do
        @user_with_same_email.email.upcase!
      end

      it { @user_with_same_email.should_not be_valid }
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAmPLe.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "with a password that's too short" do
    before{ @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "when remember token is nil" do
    let(:find) { User.find_by_remember_token(nil) }
    it { find.should be_nil }
  end

end
