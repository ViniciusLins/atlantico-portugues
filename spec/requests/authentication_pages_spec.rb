require 'spec_helper'

describe "Authentication" do
  subject { page }
  let(:signin) { I18n.t('signin_title') }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1', text: I18n.t('signin_title')) }
    it { should have_title( I18n.t('signin_title')) }
  end

  describe "signin" do
    before { visit signin_path }

    describe "as admin user" do
      let(:user) { FactoryGirl.create(:user, admin: true) }
      before { sign_in user } 

      describe "should have right links" do
        it { should have_link(I18n.t('pages_link'), href: pages_path) }
        it { should have_link(I18n.t('users_link'),        href: users_path) }
        it { should have_link(I18n.t('profile'),      href: user_path(user)) }
        it { should have_link(I18n.t('config'),     href: edit_user_path(user)) }
        it { should have_link(I18n.t('signout_title'),     href: signout_path) }
        it { should_not have_link(I18n.t('signin_title'),  href: signin_path) }
      end
    end

    describe "with invalid information" do
      before { click_button signin }

      it { should have_title(I18n.t('signin_title')) }
      it { should have_error_message(I18n.t('autentication_failed')) }

      describe "after visiting another page" do
        before { click_link I18n.t('home_page') }

        it { should_not have_error_message(I18n.t('autentication_failed')) }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user } 

      it { should have_title(user.name) }
        
      describe "should have right links" do
        it { should_not have_link(I18n.t('pages_link'), href: pages_path) }
        it { should have_link(I18n.t('users_link'),        href: users_path) }
        it { should have_link(I18n.t('profile'),      href: user_path(user)) }
        it { should have_link(I18n.t('config'),     href: edit_user_path(user)) }
        it { should have_link(I18n.t('signout_title'),     href: signout_path) }
        it { should_not have_link(I18n.t('signin_title'),  href: signin_path) }
      end

      describe "followed by sign out" do
        before { click_link I18n.t('signout_title') }
        it { should have_link(I18n.t('signin_title')) }
      end

    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "when attempting to visit create user page" do
          before { visit signup_path }
          it { should have_title(I18n.t('signin_title')) }
        end

        describe "when attempting to visit a protected page" do
          before { visit edit_user_path(user) }
          it { should have_title(I18n.t('signin_title')) }

          describe "after signing in" do
            before do
              fill_in I18n.t(:email),      with: user.email
              fill_in I18n.t(:password),   with: user.password
              click_button I18n.t('signin_title')
            end

            it "should render the desired protected page" do
              should have_title(I18n.t(:update_profile))
            end
          end
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the users index" do
          before { visit users_path }
          it { should have_title(I18n.t('signin_title')) }
        end
      end

      describe "in the documents controller" do
        let!(:document) { FactoryGirl.create(:document) }

        describe "visiting index" do
          before { visit documents_path }

          it { should have_title(I18n.t('documents.title')) }
          it { should_not have_link(I18n.t('documents.new')) }
          it { should_not have_link(I18n.t('documents.edit')) }
          it { should_not have_link(I18n.t('documents.destroy')) }
        end

        describe "visiting show" do
          before { visit document_path(document) }
          it { should have_title(document.title) }
          it { should_not have_link(I18n.t('documents.edit')) }
        end

        describe "visiting new" do
          before { visit new_document_path }
          it { should have_title(I18n.t(:signin_title)) }
        end

        describe "visiting edit" do
          before { visit edit_document_path(document) }
          it { should have_title(I18n.t(:signin_title)) }
        end

        describe "when try destroy a document" do
          before { delete document_path(document) }
          specify "should redirect to signin" do
           response.should redirect_to(signin_path) 
          end
        end

        describe "when try create action a document" do
          before { post documents_path }
          specify "should redirect to signin" do
           response.should redirect_to(signin_path) 
          end
        end

        describe "when try update a document" do
          before { put document_path(document) }
          specify "should redirect to signin" do
           response.should redirect_to(signin_path) 
          end
        end
      end

      describe "in the pages controller" do
        let(:mypage) { FactoryGirl.create(:page) }

        describe "when visiting paginas page" do
          before { visit pages_path }
          it "should redirect to home" do
            should_not have_title(I18n.t('pages_title'))
          end

        end

        describe "when visiting edit page" do
          before { visit edit_page_path(mypage) }
          it "should redirect to home" do
            should_not have_title(I18n.t('pages.edit.title'))
          end
        end

        describe "when try update a page" do
          before { put page_path(mypage) }
          specify "should redirect to home" do
           response.should redirect_to(signin_path) 
          end
        end
     
      describe "in the documents controller" do

        describe "when searching documents" do
          before do
            FactoryGirl.create(:document, is_private: true)
            visit root_path 
            click_button I18n.t('home.btn-search')
          end
         
          it "should not show private documents" do
            should have_selector('h2', text: /^0 #{I18n.t('home.results.result')} #{I18n.t('home.results.found')}/)
          end
        end

        describe "when seeing index of documents" do
          before do
            FactoryGirl.create(:document, is_private: true)
            visit documents_path 
          end
         
          it "should not exhibit in the list the private documents" do
            should have_selector('tr', count: 1)
          end
        end
       
        describe "when trying to access a private document without log in" do
          before do
            FactoryGirl.create(:document, is_private: true, id:1)
            visit '/documents/1' 
          end
         
          it "should not exhibit nothing about private documents" do
            should have_selector('h1', text: I18n.t('signin_title'))
          end
        end
 
      end
    end
  end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting the Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title(full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end

      describe "in the pages controller" do
        let(:mypage) { FactoryGirl.create(:page) }

        describe "when visiting paginas page" do
          before { visit pages_path }
          it "should redirect to home" do
            should_not have_title(I18n.t('pages_title'))
          end
        end

        describe "when visiting edit page" do
          before { visit edit_page_path(mypage) }
          it "should redirect to home" do
            should_not have_title(I18n.t('pages.edit.title'))
          end
        end

        describe "when try update a page" do
          before { put page_path(mypage) }
          specify "should redirect to home" do
           response.should redirect_to(root_path) 
          end
        end
      end
    end
  end

  describe "errors" do
    let(:non_admin) { FactoryGirl.create(:user) }
    before { sign_in non_admin }

    describe "GET 'file_not_found'" do
      it "returns http success" do
        visit "/1"
        page.should have_content(I18n.t('not_found'))
      end
    end

    describe "GET 'internal_server_error''" do
      it "returns http success" do
        visit 'documents#index'
        DocumentsController.any_instance.stub(:index).and_raise(ArgumentError)
        page.should have_content(I18n.t('internal_server_error'))
#        response.body.should have_json_path("error")
      end
    end


    RSpec.describe ApplicationController, :type => :controller do

      controller do
        def index
          render :text => "index called", :status => 422
        end
      end

      describe "GET 'unprocessable'" do
        it "returns http success" do
        response.code.should eq("200")
        end
      end
    end
  end
end
