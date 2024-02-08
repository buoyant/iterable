module Iterable
  class Event

    BASE_URI = 'http://localhost:3000/api'
    
    def self.hello
      response = HTTParty.get(BASE_URI)
      response
    end

    def self.create_event(user_id, event_name, event_id)
      response = HTTParty.post("#{BASE_URI}/events/track",
        JSON.generate({ userId: user_id, eventName: event_name, eventId: event_id }),
        headers: { 'Content-Type' => 'application/json' }
      )
      response
    end
  end
end
