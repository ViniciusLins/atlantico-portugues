class DocumentsController < ApplicationController 
  #include SessionsHelper
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_user, only: [:new, :edit, :create, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    if signed_in?
      @documents = Document.page(params[:page])
    else
      @documents = Document.page(params[:page]).where(:is_private => false)
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    if @document.is_private != true || signed_in?  
      @pdf_url = build_pdf_url @document
    else
      signed_in_user
    end
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: I18n.t('documents.messages.create_success') }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: I18n.t('documents.messages.update_success') }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: I18n.t('documents.messages.destroy_success') }
      format.json { head :no_content }
    end
  end

  def search
    @search = Document.search do
      with :is_private, false unless signed_in?
      fulltext params[:search] do
        query_phrase_slop 5
        phrase_fields title:  2.0
        phrase_slop 2
      end

      order_by :published_year, :desc
      paginate page: params[:page] 
    end
    @documents = @search.results
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:document).permit(
      :title, :author, :description, :keywords, :published_year, :publisher, :file, :is_private)
  end

  def build_pdf_url(doc)
    URI.join(request.url,@document.file.url)
  end
end
