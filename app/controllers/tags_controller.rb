class TagsController < ApplicationController
  def show
    @organization = current_user.organization
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @documents = @organization.documents.tagged_with(@tag)
  end

  def index
    @organization = current_user.organization
    @tags = @organization.owned_tags.most_used(100)
  end
end 
