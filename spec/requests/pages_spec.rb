require 'spec_helper'

describe "Pages" do
  subject { page }

  describe "index" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let!(:mypage) { FactoryGirl.create(:page) }

    before do
      sign_in admin
      visit pages_path
    end 

    it { should have_title( I18n.t('pages.index.title')) }
    it { should have_selector('h1', text: I18n.t('pages.index.title')) }
    it { should_not have_link(I18n.t('pages.page.view'))} 
    it { should have_link(I18n.t('pages.page.edit'),     href: edit_page_path(mypage)) } 
    it { should have_content(mypage.title) }
    it { should_not have_content(mypage.body) }

  end

  describe "edit page" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let!(:mypage) { FactoryGirl.create(:page) }
    let(:btn_save) { I18n.t('pages.edit.button')}

    before do
      sign_in admin
      visit edit_page_path(mypage)
    end 

    it { should have_title( I18n.t('pages.edit.title') ) }
    it { should have_selector('h1', text: I18n.t('pages.edit.title') ) }
    it { should have_button(btn_save) } 

    describe "with invalid information" do
      before do
        fill_in I18n.t('pages.form.title'),  with: "  "
        click_button btn_save
      end

      it { should have_title(I18n.t('pages.edit.title')) }
      it { should have_error_message('') }
    end

    describe "when submitting a valid form" do
      let(:new_title) { "Help" }
      let(:new_body) { "a" * 50 }
      before do
        fill_in I18n.t('pages.form.title'),      with: new_title 
        click_button btn_save
      end

      specify { mypage.reload.title == new_title}
      specify { mypage.reload.title == new_body}
      it "should be redirect to show page" do 
        should have_title(new_title) 
      end
      it "should show a success message" do
        should have_message('')
      end
    end
  end
end
