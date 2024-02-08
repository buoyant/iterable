require 'sinatra'
require 'json'

class IterableSinatraApp < Sinatra::Base
  
  # default route
  get '/' do
    "Hey I'm up!"
  end

  # events

  events = []

  post '/events/track' do
    content_type :json
    request_body = JSON.parse(request.body.read)

    user_id     = request_body['userId']
    event_name  = request_body['eventName'] # send from controller
    event_id    = request_body['eventId'] # send from controller
    data_fields = request_body['dataFields'] # optional
    campaign_id = request_body['campaignId'] # optional

    event = events.find { |event| event[:userId] == user_id.to_i && event[:eventId] == event_id }

    if !event
      event = {
        userId: user_id,
        eventName: event_name,
        eventId: event_id,
        createdAt: Time.now.to_i,
        dataFields: data_fields,
        campaignId: campaign_id
      }

      events.push(event)
      { success: true }.to_json
    else
      event.to_json
    end
  end

  get '/events' do
    content_type :json
    events.to_json
  end

  sent_emails = []

  post '/email/target' do
    content_type :json
    request_body = JSON.parse(request.body.read)

    campaign_id = request_body['campaignId']
    recipient_email = request_body['recipientEmail']
    user_id = request_body['recipientUserId']
    data_fields = request_body['dataFields'] # optional
    body = {
      "campaignId": campaign_id,
      "dataFields": data_fields,
    }

    if campaign_id && recipient_email
      sent_email = {
        userId: user_id,
        emailAddress: recipient_email,
        body: body,
        timestamp: Time.now.to_i
      }

      sent_emails.push(sent_email)
      { success: true }.to_json
    else
      status 400
      { error: 'Invalid request parameters' }.to_json
    end
  end

  get '/emails' do
    content_type :json
    sent_emails.to_json
  end
end
