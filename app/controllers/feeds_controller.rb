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
    @documents = @organization.search_documents(@feed.tag)
  end

  def destroy
    @feed = Feed.find(params[:id])
    @user = @feed.user
    if @feed.destroy
      flash[:notice] = "You're no longer following \'#{@feed.tag}\'"
    else
      flash[:error] = "There was an error deleting feed."
    end
    redirect_to :back
  end

  private

  def feed_params
    params.require(:feed).permit(:tag, :user_id)
  end

end