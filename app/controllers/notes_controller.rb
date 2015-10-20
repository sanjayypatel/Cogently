class NotesController < ApplicationController

  def new
    @paragraph = Paragraph.find(params[:paragraph_id])
    @document = @paragraph.document
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      flash[:notice] = "Note saved"
    else
      flash[:error] = "Error saving note"
    end
    @document = @note.paragraph.document
    redirect_to organization_document_path(@document.organization, @document)
  end

  private

  def note_params
    params.require(:note).permit(:body, :paragraph_id, :user_id)
  end
end