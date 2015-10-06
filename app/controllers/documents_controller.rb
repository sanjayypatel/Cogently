class DocumentsController < ApplicationController

  def index
    @organization = current_user.organization
    @documents = @organization.documents
  end

  def new
    @organization = current_user.organization
    @document = Document.new
  end

  def create
    @organization = current_user.organization
    @document = @organization.documents.build(document_params)
    @organization.tag(@document, on: :tags, with: params[:document][:tag_list])
    if @document.save
      flash[:notice] = "Document uploaded"
    else
      flash[:else] = "Error uploading document"
    end
    redirect_to organization_documents_path(@organization)
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @document = Document.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:organization_id])
    @document = Document.find(params[:id])
    @organization.tag(@document, on: :tags, with: params[:document][:tag_list])
    if @document.update_attributes(document_params)
      flash[:notice] = "Document updated"
    else
      flash[:else] = "Error updating document"
    end
    redirect_to organization_document_path(@organization, @document)
  end

  def show
    @document = Document.find(params[:id])
  end

  private

  def document_params
    params.require(:document).permit(:name, :file, :organization_id, :user_id)
  end

end