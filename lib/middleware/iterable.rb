module Iterable
  BASE_URI = 'http://localhost:3000/api'
  class Event

    def self.hello
      response = HTTParty.get(BASE_URI)
      response
    end

    def self.create_event(user_id, event_name, event_id)
      response = HTTParty.post("#{BASE_URI}/events/track",
        body: JSON.generate({ userId: user_id, eventName: event_name, eventId: event_id }),
        headers: { 'Content-Type' => 'application/json' }
      )
      response
    end

    def self.list_events #(user_id)
      response = HTTParty.get("#{BASE_URI}/events")
      response
    end

  end

  class Email

    def self.notify(options={})
      response = HTTParty.post("#{BASE_URI}/email/target",
        body: JSON.generate({
          recipientUserId: options[:user_id],
          recipientEmail: options[:recipient_email],
          campaignId: options[:campaign_id],
          dataFields: options[:data_fields],
        }),
        headers: { 'Content-Type' => 'application/json' }
      )
      response
    end

    def self.list_sent_emails #(user_id)
      response = HTTParty.get("#{BASE_URI}/emails")
      response
    end
  end
end
