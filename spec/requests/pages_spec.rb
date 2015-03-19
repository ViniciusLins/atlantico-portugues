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
    it { should have_link("Visualizar", href: page_path(mypage)) } 
    it { should have_link("Editar",     href: edit_page_path(mypage)) } 
    it { should have_link("Excluir") } 
    it { should have_content(mypage.title) }
    it { should have_content(mypage.body) }

    describe "delete links" do
      it "should be deleted page" do
        expect { click_link "Excluir" }.to change(Page, :count).by(-1)
      end
    end
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
      end
      it "should create a page" do
        expect { click_button "Criar página" }.to change(Page, :count).by(1)
      end

      it "should be redirect to show page" do 
        click_button "Criar página"
        should have_title('Help') 
      end
      it "should show a success message" do
        click_button "Criar página"
        should have_selector('div.alert.alert-notice') 
      end

    end
  end

  describe "edit page" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let!(:mypage) { FactoryGirl.create(:page) }
    let(:btn_save) { "Salvar alterações"}

    before do
      sign_in admin
      visit edit_page_path(mypage)
    end 

    it { should have_title('Editar Página') }
    it { should have_selector('h1', text: 'Editar Página') }
    it { should have_button(btn_save) } 

    describe "with invalid information" do
      before do
        fill_in "Title",  with: "  "
        click_button btn_save
      end

      it { should have_title('Editar Página') }
      it { should have_error_message('') }
    end

    describe "when submitting a valid form" do
      let(:new_title) { "Help" }
      let(:new_body) { "a" * 50 }
      before do
        fill_in "Title",      with: new_title 
        click_button btn_save
      end

      specify { mypage.reload.title == new_title}
      specify { mypage.reload.title == new_body}
      it "should be redirect to show page" do 
        should have_title(new_title) 
      end
      it "should show a success message" do
        should have_selector('div.alert.alert-notice') 
      end
    end
  end
end
