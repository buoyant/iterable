class HomeController < ApplicationController


  def index
    @response = Iterable::Event.hello
  end

  def create_event
    event = Events.get(params[:id])
    Iterable::Event.create_event(current_user.id, event.name, event.id)
    flash[:notice] = "Successfully created event for #{current_user.name}"
  end
end
