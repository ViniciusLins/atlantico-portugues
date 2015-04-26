require 'spec_helper'

describe "Static pages" do

  subject{ page }

  before(:all) do
    @home_page = FactoryGirl.create(:page, title: I18n.t('home_page')) 
    @help_page = FactoryGirl.create(:page, title: I18n.t('help_page')) 
    @about_page = FactoryGirl.create(:page, title: I18n.t('about_page'))
#    @contact_page = FactoryGirl.create(:page, title: I18n.t('contact'))
  end

  shared_examples_for "all static_pages" do
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }

    it { should_not have_selector('title', text: I18n.t('home_page')) }
    it { should have_content(@home_page.body) }

    describe "when user search documents"  do
      let!(:document) { FactoryGirl.create(:document, title: "Sample Document") }

      describe "typing exactly title" do
        before do
          fill_in "search", with: "Sample Document" 
          click_button I18n.t('home.btn-search')
        end

        it { should have_title(I18n.t('home.results.title')) }
      end

      describe "search empty string" do
        before do
          fill_in "search", with: " " 
          click_button I18n.t('home.btn-search')
        end

        it { should have_title(I18n.t('home.results.title')) }
      end
    end
  end

  describe "Ajuda page" do
    before { visit help_path }

    let(:heading)     { I18n.t('help') }
    let(:page_title)  { I18n.t('help') } 
    it_should_behave_like "all static_pages"
  end

  describe "Sobre page" do
    before { visit about_path }

    let(:heading)     { I18n.t('about') }
    let(:page_title)  { I18n.t('about') } 
    it_should_behave_like "all static_pages"
  end

  describe "Entre em contato page" do
    before { visit contact_path }
 
    let(:heading)     { I18n.t('contact')  }
    let(:page_title)  { I18n.t('contact') } 
    it_should_behave_like "all static_pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link I18n.t('about')
    should have_selector 'title', text: full_title(I18n.t('about'))
    click_link I18n.t('help')
    should have_selector 'title', text: full_title(I18n.t('help'))
    click_link I18n.t('contact')
    should have_selector 'title', text: full_title(I18n.t('contact'))
    click_link I18n.t('home_page')
    click_link "atlântico português"
    should have_selector 'title', text: full_title('')
    click_link I18n.t('documents.title')
    should have_title(full_title(I18n.t('documents.title')))
  end

  it "should have the sign in/out links" do
    visit root_path
    should have_link(I18n.t('signin_title'), href: signin_path) 
    should_not have_link(I18n.t('signout_tile'), href: signout_path) 
    should_not have_link(I18n.t('users_link')) 
    should_not have_link(I18n.t('pages_link'), href: pages_path) 
  end
end
