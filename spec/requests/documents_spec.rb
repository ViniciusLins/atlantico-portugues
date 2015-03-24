require 'spec_helper'

describe "Documents" do

  subject { page }

  let!(:document) { FactoryGirl.create(:document) }

  describe "index page" do
    let!(:user) { FactoryGirl.create(:user) }
    before do 
      sign_in user
      visit documents_path
    end 

    it { should have_title(I18n.t('documents.title')) }
    it { should have_selector('h1', text: I18n.t('documents.title')) }

    describe "should have right links" do 
      it { should have_link(I18n.t('documents.new'), href: new_document_path) } 
      it { should have_link(I18n.t('.documents.show_link'), href: document_path(document)) } 
      it { should have_link(I18n.t('documents.edit'),     href: edit_document_path(document)) } 
      it { should have_link(I18n.t('documents.destroy')) } 
    end

    describe "should have right document contents" do
      it { should have_content(document.title) }
      it { should have_content(document.author) }
      it { should have_content(document.published_year) }
    end

    describe "delete links" do
      it "should be deleted document" do
        expect { click_link I18n.t('documents.destroy') }.to change(Document, :count).by(-1)
      end
    end
  end

  describe "create page" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }

    before do
      sign_in admin
      visit new_document_path
    end 

    it { should have_title(I18n.t('documents.new_title')) }
    it { should have_selector('h1', text: I18n.t('documents.new_title')) }

    it { should have_button( I18n.t('documents.save')) } 
    it "should not create a page" do 
      expect { click_button I18n.t('documents.save') }.not_to change(Document, :count)
    end

    describe "when submitting a blank form" do
      before { click_button I18n.t('documents.save') }

      it { should have_title(I18n.t('documents.new_title')) }
      it { should have_error_message('') }
    end

    describe "when submitting a valid form" do
      before do
        fill_in I18n.t('documents.title_model'),      with: "Sample Document"
        fill_in I18n.t('documents.author'),           with: "Sample Author"
        fill_in I18n.t('documents.keywords'),         with: "Sample, Document"
        attach_file I18n.t('documents.file'), "spec/assets/test.pdf"
      end
      it "should create a document" do
        expect { click_button I18n.t('documents.save') }.to change(Document, :count).by(1)
      end

      it "should be redirect to show document" do 
        click_button I18n.t('documents.save')
        should have_title("Sample Document") 
      end
      it "should show a success message" do
        click_button I18n.t('documents.save')
        should have_message('')
      end
    end

    describe "when try upload a invalid file" do
      before do
        fill_in I18n.t('documents.title_model'),      with: "Sample Document"
        fill_in I18n.t('documents.author'),           with: "Sample Author"
        fill_in I18n.t('documents.keywords'),         with: "Sample, Document"
        attach_file I18n.t('documents.file'), "spec/assets/invalid.exe"
      end

      it "should show a error message" do
        click_button I18n.t('documents.save') 
        should have_error_message('')
      end

      it "should cannot save document" do
        expect { click_button I18n.t('documents.save') }.not_to change(Document, :count)
      end
    end
  end


  describe "edit page" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let(:btn_save) { I18n.t('documents.save') }

    before do
      sign_in admin
      visit edit_document_path(document)
    end 

    it { should have_title(I18n.t('documents.edit_title')) }
    it { should have_selector('h1', text: I18n.t('documents.edit_title')) }
    it { should have_button(btn_save) } 

    describe "with invalid information" do
      before do
        fill_in I18n.t('documents.title_model'),  with: "  "
        click_button btn_save
      end

      it { should have_title(I18n.t('documents.edit_title')) }
      it { should have_error_message('') }
    end

    describe "when submitting a valid form" do
      let(:new_title) { "Sample Document New" }
      let(:new_keywords) { "a" * 50 }
      before do
        fill_in I18n.t('documents.title_model'),      with: new_title 
        fill_in I18n.t('documents.keywords'),      with: new_keywords
        click_button btn_save
      end

      specify { document.reload.title == new_title}
      specify { document.reload.keywords == new_keywords}
      it "should be redirect to show page" do 
        should have_title(new_title) 
      end
      it "should show a success message" do
        should have_message('')
      end
    end
  end
end
