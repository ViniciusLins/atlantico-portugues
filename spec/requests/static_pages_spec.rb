require 'spec_helper'

describe "Static pages" do

  subject{ page }

  shared_examples_for "all static_pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading) { 'Sample App' }
    let(:page_title) { '' } 
    it_should_behave_like "all static_pages"

    it { should_not have_selector('title', text: "| Home") }
    it { should_not have_button('Sign up now!') }
  end

  describe "Ajuda page" do
    before { visit help_path }

    let(:heading)     { 'Ajuda' }
    let(:page_title)  { 'Ajuda' } 
    it_should_behave_like "all static_pages"
  end

  describe "Sobre page" do
    before { visit about_path }

    let(:heading)     { 'Sobre Nós' }
    let(:page_title)  { 'Sobre Nós' } 
    it_should_behave_like "all static_pages"
  end

  describe "Entre em contato page" do
    before { visit contact_path }
 
    let(:heading)     { 'Entre em contato' }
    let(:page_title)  { 'Entre em contato' } 
    it_should_behave_like "all static_pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Sobre"
    should have_selector 'title', text: full_title('Sobre Nós')
    click_link "Ajuda"
    should have_selector 'title', text: full_title('Ajuda')
    click_link "Entre em contato"
    should have_selector 'title', text: full_title('Entre em contato')
    click_link "Home"
    click_link "atlântico português"
    should have_selector 'title', text: full_title('')
  end

  it "should have the sign in/out links" do
    visit root_path
    should have_link('Entrar',      href: signin_path) 
    should_not have_link('Sair',      href: signout_path) 
    should_not have_link('Usuários') 
    should_not have_link('Páginas', href: pages_path) 
  end
end
