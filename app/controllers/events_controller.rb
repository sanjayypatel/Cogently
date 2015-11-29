class EventsController < ApplicationController
  def index
    @organization = Organization.find(params[:organization_id])
    params[:start_date].nil? ? @start_date = Time.now.strftime("%d/%m/%Y") : @start_date = params[:start_date]
    @events = @organization.events.starting_during(Date.parse(@start_date))
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @event = Event.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event saved."
    else
      flash[:error] = "Error saving event."
    end
    redirect_to organization_events_path(@organization)
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    @attendees = @event.users
    @summaries = @event.summaries
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    @attendees = @event.users
    @summaries = @event.summaries
    if params[:search]
      @found_users = @organization.search_members(params[:search]) - @event.users.to_a
      @query = params[:search]
    else
      @found_users = nil
    end
    if params[:search_summaries]
      @found_summaries = @organization.search_summaries(params[:search_summaries]) - @event.summaries.to_a
      @summary_query = params[:search_summaries]
    else
      @found_summaries = nil
    end
  end

  def update
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    redirect_to organization_event_path(@organization, @event)
  end

  def add_attendee
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    @user = User.find(params[:event][:user_id])
    @event.users << @user
    redirect_to edit_organization_event_path(@organization, @event)
  end

  def add_reference
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    @summary = Summary.find(params[:event][:summary_id])
    @event.summaries << @summary
    redirect_to edit_organization_event_path(@organization, @event)
  end

  def remove_attendee
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    @user = User.find(params[:event][:user_id])
    @event.users.delete(@user)
    redirect_to edit_organization_event_path(@organization, @event)
  end

  def remove_reference
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    @summary = Summary.find(params[:event][:summary_id])
    @event.summaries.delete(@summary)
    redirect_to edit_organization_event_path(@organization, @event)
  end

  def event_params
    params.require(:event).permit(:title, :organization_id, :start_time, :end_time, :user_id)
  end
end