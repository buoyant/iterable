require 'sinatra'
require 'json'

class IterableSinatraApp < Sinatra::Base
  
  # Mock data for users
  users = [
    { userId: 1, email: 'user1@example.com', name: 'User 1' },
    { userId: 2, email: 'user2@example.com', name: 'User 2' }
  ]

  # default route
  get '/' do
    'Hello from Iterable Sinatra!'
  end

  # users

  get '/users/:user_id' do |user_id|
    content_type :json
    user = users.find { |user| user[:id] == user_id.to_i }
    if user
      user.to_json
    else
      status 404
      { error: 'User not found' }.to_json
    end
  end

  get '/users' do
    content_type :json
    users.to_json
  end

  # events

  events = []

  post '/events/track' do
    content_type :json
    request_body = JSON.parse(request.body.read)

    user_id     = request_body['userId'] # send from controller
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
    data_fields = request_body['dataFields']
    subject = request_body['subject']
    body = {
      "campaignId": campaign_id,
      "dataFields": data_fields,
    }

    user = users.find { |user| user[:id] == user_id.to_i }

    if user && recipient_email
      sent_email = {
        userId: user_id,
        emailAddress: recipient_email,
        subject: subject,
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

  get '/sentEmails' do
    content_type :json
    sent_emails.to_json
  end
end
