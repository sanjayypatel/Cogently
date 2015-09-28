class DocumentsController < ApplicationController

  def index
    @documents = current_user.organization.documents
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      flash[:notice] = "Document uploaded"
    else
      flash[:else] = "Error uploading document"
    end
    redirect_to documents_path
  end

  def show
    @document = Document.find(params[:id])
  end

  private

  def document_params
    params.require(:document).permit(:name, :file, :organization_id, :user_id)
  end

end