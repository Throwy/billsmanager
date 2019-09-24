/// `EventList` is a helper class used to create a data structure that maps
/// lists of 'T' events to `DateTime`s.
///
/// The `EventList` data structure is primarily used for showing events
/// on a calendar.
class EventList<T> {
  Map<DateTime, List<T>> events;

  EventList({this.events});

  /// Adds an event<`T`> to the specified date.
  void add(DateTime date, T event) {
    if (events == null) {
      events = {
        date: [event]
      };
    } else if (!events.containsKey(date)) {
      events[date] = [event];
    } else {
      events[date].add(event);
    }
  }

  /// Adds mutliple events<`List<T>`> to the specified date.
  void addAll(DateTime date, List<T> events) {
    if (this.events == null) {
      this.events = {date: events};
    } else if (!this.events.containsKey(date)) {
      this.events[date] = events;
    } else {
      this.events[date].addAll(events);
    }
  }

  /// Removes an event<`T`> from the specified date.
  bool remove(DateTime date, T event) {
    return events != null && events.containsKey(date)
        ? events[date].remove(event)
        : true;
  }

  /// Removes all events from the specified date.
  List<T> removeAll(DateTime date) {
    return events != null && events.containsKey(date)
        ? events.remove(date)
        : [];
  }

  /// Clears all events and dates from the map.
  void clear() {
    if (events != null) {
      events.clear();
    } else {
      events = {};
    }
  }

  /// Returns `List<T>` events for the specified date.
  List<T> getEvents(DateTime date) {
    return events != null && events.containsKey(date) ? events[date] : [];
  }
}
