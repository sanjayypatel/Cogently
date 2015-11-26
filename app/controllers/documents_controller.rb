class DocumentsController < ApplicationController
  require 'rubygems'
  require 'pdf/reader'
  require 'uri'

  def index
    @organization = current_user.organization
    if params[:search]
      @documents = @organization.search_documents(params[:search])
      @query = params[:search]
    else
      @documents = @organization.documents
      @query = nil
    end
  end

  def new
    @organization = current_user.organization
    @document = Document.new
  end

  def create
    @organization = current_user.organization
    @document = @organization.documents.build(document_params)
    @organization.tag(@document, on: :tags, with: params[:document][:tag_list])
    io = open(@document.path_to_file)
    reader = PDF::Reader.new(io)
    if @document.save
      @document.content = @document.process_new_document(reader.to_html)
      @document.save
      flash[:notice] = "Document uploaded"
    else
      flash[:error] = "Error uploading document"
    end
    redirect_to organization_document_path(@organization, @document)
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @document = Document.find(params[:id])
    @document.summary.nil? ? @summary = Summary.new : @summary = @document.summary
  end

  def update
    @organization = Organization.find(params[:organization_id])
    @document = Document.find(params[:id])
    @organization.tag(@document, on: :tags, with: params[:document][:tag_list])
    if @document.update_attributes(document_params)
      flash[:notice] = "Document updated"
    else
      flash[:error] = "Error updating document"
    end
    redirect_to organization_document_path(@organization, @document)
  end

  def show
    @document = Document.find(params[:id])
    @organization = @document.organization
    io = open(@document.path_to_file)
    @reader = PDF::Reader.new(io)
    @paragraphs = @document.paragraphs
    @document.summary.nil? ? @summary = Summary.new : @summary = @document.summary
  end

  private

  def document_params
    params.require(:document).permit(:name, :file, :organization_id, :user_id)
  end

end