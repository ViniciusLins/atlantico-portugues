require 'spec_helper'

describe "Authentication" do
  subject { page }
  let(:signin) { "Sign in" }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',     text: 'Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "as admin user" do
      let(:user) { FactoryGirl.create(:user, admin: true) }
      before { sign_in user } 

      describe "should have right links" do
        it { should have_link('Páginas', href: pages_path) }
        it { should have_link('Users',        href: users_path) }
        it { should have_link('Profile',      href: user_path(user)) }
        it { should have_link('Settings',     href: edit_user_path(user)) }
        it { should have_link('Sign out',     href: signout_path) }
        it { should_not have_link('Sign in',  href: signin_path) }
      end
    end

    describe "with invalid information" do
      before { click_button signin }

      it { should have_title('Sign in') }
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }

        it { should_not have_error_message('Invalid') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user } 

      it { should have_title(user.name) }
        
      describe "should have right links" do
        it { should_not have_link('Páginas', href: pages_path) }
        it { should have_link('Users',        href: users_path) }
        it { should have_link('Profile',      href: user_path(user)) }
        it { should have_link('Settings',     href: edit_user_path(user)) }
        it { should have_link('Sign out',     href: signout_path) }
        it { should_not have_link('Sign in',  href: signin_path) }
      end

      describe "followed by sign out" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end

    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "when attempting to visit create user page" do
          before { visit signup_path }
          it { should have_title('Sign in') }
        end

        describe "when attempting to visit a protected page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }

          describe "after signing in" do
            before do
              fill_in "Email",      with: user.email
              fill_in "Password",   with: user.password
              click_button "Sign in"
            end

            it "should render the desired protected page" do
              should have_title('Edit user')
            end
          end
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the users index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
      end

      describe "in the pages controller" do
        let(:mypage) { FactoryGirl.create(:page) }

        describe "when visiting paginas page" do
          before { visit pages_path }
          it "should redirect to home" do
            should_not have_title('Páginas')
          end

        end

        describe "when visiting edit page" do
          before { visit edit_page_path(mypage) }
          it "should redirect to home" do
            should_not have_title('Editar Página')
          end
        end

        describe "when try destroy a page" do
          before { delete page_path(mypage) }
          specify "should redirect to home" do
           response.should redirect_to(signin_path) 
          end
        end

        describe "when try create action a page" do
          before { post pages_path }
          specify "should redirect to home" do
           response.should redirect_to(signin_path) 
          end
        end

        describe "when try update a page" do
          before { put page_path(mypage) }
          specify "should redirect to home" do
           response.should redirect_to(signin_path) 
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
            should_not have_title('Páginas')
          end
        end

        describe "when visiting edit page" do
          before { visit edit_page_path(mypage) }
          it "should redirect to home" do
            should_not have_title('Editar Página')
          end
        end

        describe "when try destroy a page" do
          before { delete page_path(mypage) }
          specify "should redirect to home" do
           response.should redirect_to(root_path) 
          end
        end

        describe "when try create action a page" do
          before { post pages_path }
          specify "should redirect to home" do
           response.should redirect_to(root_path) 
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
    
end
