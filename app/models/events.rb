#-- encoding: UTF-8
class Events
  @events = {}

  def self.all
    @events
  end
  
  def self.add(event)
    @events[event.id] = event
  end

  def self.get(event_id)
    @events[event_id]
  end
  
  add(Event.new(id: 'ea01', name: 'Event A', description: 'This is Event A'))
  add(Event.new(id: 'eb02', name: 'Event B', description: 'This is Event B', notify: true))
end
