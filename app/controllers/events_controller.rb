class EventsController < ApplicationController
  def index
    @organization = Organization.find(params[:organization_id])
    @events = Event.all
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
  end

  private

  def event_params
    params.require(:event).permit(:title, :organization_id, :start_time, :end_time)
  end
end