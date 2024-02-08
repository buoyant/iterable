class HomeController < ApplicationController

  # welcome message

  def index
    @response = Iterable::Event.hello
  end

  # create event action: which uses Iterable module which in turn calls mock api and returns responses.

  def create_event
    event = Events.get(params[:id])
    response = Iterable::Event.create_event(current_user.id, event.name, event.id)

    if response['success'] && event.notify?
      # TODO: sent to background job async in case of high volume.
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

  # listing events from mock api

  def events
    @events = Iterable::Event.list_events
  end

  # listing emails sent from mock api

  def emails
    @emails = Iterable::Email.list_sent_emails
  end
end
