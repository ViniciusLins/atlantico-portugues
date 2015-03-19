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

    it { should have_title('Páginas') }
    it { should have_selector('h1', text: 'Páginas') }
    it { should have_link("Nova página", href: new_page_path) } 
    it { should have_content(mypage.title) }
    it { should have_content(mypage.body) }
  end

  describe "create page" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let!(:mypage) { FactoryGirl.create(:page) }

    before do
      sign_in admin
      visit new_page_path
    end 

    it { should have_title('Nova Página') }
    it { should have_selector('h1', text: 'Nova Página') }
    it { should have_button("Criar página") } 

    it "should not create a page" do
      expect { click_button "Criar página" }.not_to change(Page, :count)
    end

    describe "when submitting a blank form" do
      before { click_button "Criar página" }

      it { should have_title('Nova Página') }
      it { should have_selector('h1', text: 'Nova Página') }
      it { should have_error_message('') }
    end

    describe "when submitting a valid form" do
      before do
        fill_in "Title",      with: "Help"
        fill_in "Body",       with: "Bla Bla Bla"
      end
      it "should create a page" do
        expect { click_button "Criar página" }.to change(Page, :count).by(1)
      end

      it "should be redirect to show page" do 
        click_button "Criar página"
        should have_title('Help') 
      end
    end
  end

end
