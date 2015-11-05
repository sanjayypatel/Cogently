class SummariesController < ApplicationController

  def create
    @document = Document.find(params[:document_id])
    @summary = Summary.new(summary_params)
    if @summary.save
      flash[:notice] = 'Summary saved.'
    else
      flash[:error] = 'There was an error saving summary. Please try again.'
    end
    redirect_to organization_document_path(@document.organization, @document)
  end

  def update
    @document = Document.find(params[:document_id])
    @summary = Summary.find(params[:id])
    if @summary.update_attributes(summary_params)
      flash[:notice] = 'Summary updated.'
    else
      flash[:error] = 'There was an error saving summary. Please try again.'
    end
    redirect_to organization_document_path(@document.organization, @document)
  end

  def show
    @summary = Summary.find(params[:id])
    @document = @summary.document
    @organization = @document.organization
    @notes = @document.notes
  end

  private

  def summary_params
    params.require(:summary).permit(:body, :document_id)
  end
end