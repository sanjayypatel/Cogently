class TagsController < ApplicationController
  def show
    @organization = current_user.organization
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    # @tag = ActsAsTaggableOn::Tag.where(name: params[:id]).first
    @documents = @organization.documents.tagged_with(@tag)
  end

  def index
    @tags = ActsAsTaggableOn::Tag.most_used(100)
  end
end 
