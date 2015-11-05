class FeedsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @feeds = @user.feeds
  end

  def create
    @user = User.find(params[:user_id])
    @feed = Feed.new(feed_params)
    if @feed.save
      flash[:notice] = "Feed created"
    else
      flash[:error] = "There was an error creating feed. Please try again."
    end
    redirect_to user_feed_path(@user, @feed)
  end

  def update
    @user = current_user
    @feed = Feed.find(params[:id])
    if @feed.update_attributes(feed_params)
      flash[:notice] = "Feed created"
    else
      flash[:error] = "There was an error creating feed. Please try again."
    end
    redirect_to user_feed_path(@user, @feed)
  end

  def show
    @feed = Feed.find(params[:id])
    @user = @feed.user
    @organization = @user.organization
    @documents = @organization.documents.tagged_with(@feed.tag)
  end

  private

  def feed_params
    params.require(:feed).permit(:tag, :user_id)
  end
end