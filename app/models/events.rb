#-- encoding: UTF-8
# This class is used for collection of events as these are limited in this scenario.
class Events
  @events = {}

  # returns events with id as key and object as value.
  def self.all
    @events
  end
  
  def self.add(event)
    @events[event.id] = event
  end

  # get a particular event by event id.
  def self.get(event_id)
    @events[event_id]
  end
  
  add(Event.new(id: 'ea01', name: 'Event A', description: 'This is Event A'))
  add(Event.new(id: 'eb02', name: 'Event B', description: 'This is Event B', notify: true))
end
