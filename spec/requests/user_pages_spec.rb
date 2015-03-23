require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title(I18n.t('users.index.title')) }
    it { should have_selector('h1', text: I18n.t('users.index.title')) }
    it { should_not have_link(I18n.t('users.new.create'), href: signup_path) } 

    describe "pagination" do
      it "should list each user for first page" do
        User.paginate(page: 1).each do |user|
          should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link(I18n.t('users.user.delete')) }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link(I18n.t('users.user.delete'), href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link(I18n.t('users.user.delete')) }.to change(User, :count).by(-1)
        end
        it { should_not have_link(I18n.t('users.user.delete'), href: user_path(admin)) }

      end
    end
    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit users_path
      end
      it { should have_link(I18n.t('users.index.create'), href: signup_path) } 
    end
  end


  describe "signup page" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    before do
      sign_in admin
      visit signup_path 
    end

    it { should have_selector('h1',     text: I18n.t('users.new.create')) }
    it { should have_selector('title',  text: I18n.t('users.new.create')) }

  end

  describe "signup" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let(:submit) { I18n.t('users.new.submit') }
    before do
      sign_in admin
      visit signup_path 
    end

    describe "when visit page " do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "when submit an blank form" do
      before { click_button submit }

      it "should not create a user" do
        expect {}.not_to change(User, :count)
      end

      it { should have_selector('title', text: I18n.t('users.new.create') ) }
      it { should have_error_message('') }
    end

    describe "when submit valid information" do
      before do
        fill_in I18n.t('.name'),         with: "Example User"
        fill_in I18n.t('.email'),        with: "user@example.com"
        fill_in I18n.t('.password'),     with: "foobar"
        fill_in I18n.t('.password_confirmation'),   with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        let(:user) { User.find_by_email("user@example.com") }
        before { click_button submit }

        it { should have_title(full_title('')) }
        it { should_not have_title('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: "Usuário criado com sucesso!") }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it{ should have_selector('h1',    text: user.name) }
    it{ should have_selector('title', text: user.name) }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',     text: I18n.t(:update_profile)) }
      it { should have_title(I18n.t(:update_profile)) }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button I18n.t(:save_changes) }

      it { should have_error_message('') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_with_valid_information user
        fill_in I18n.t(:name),     with: new_name
        fill_in I18n.t(:email),    with: new_email
        click_button I18n.t(:save_changes) 
      end

      it { should have_title(new_name) }
      it { should have_message('') }
      it { should have_link('Sair', href: signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "when attempt to do a mass assignment in admin" do
    let(:user) { FactoryGirl.create(:user, admin: false) }
    before do
      put "/users/#{user.id}?admin=1"
    end

    it "user should not be a admin" do
      user.reload.should_not be_admin
    end
  end
end
