class HomeController < ApplicationController

  def index
    @response = Iterable::Event.hello
  end

  def create_event
    event = Events.get(params[:id])
    response = Iterable::Event.create_event(current_user.id, event.name, event.id)

    if response['success'] && event.notify?
      options = {
        user_id: current_user.id,
        recipient_email: current_user.email,
        campaign_id: 100,
        data_fields: {},
      }
      Iterable::Email.notify(options)
    end

    if response['success']
      msg = "Successfully created event for #{current_user.name}."
    else
      msg = "Event already exists for this user."
    end

    flash[:notice] = msg
    redirect_to root_path
  end

  def events
    @events = Iterable::Event.list_events
  end

  def emails
    @emails = Iterable::Email.list_sent_emails
  end
end
