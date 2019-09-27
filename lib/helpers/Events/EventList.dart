/// `EventList` is a helper class used to create a data structure that maps
/// lists of 'T' events to `DateTime`s.
///
/// The `EventList` data structure is primarily used for showing events
/// on a calendar.
class EventList<T> {
  Map<DateTime, List<T>> events;

  EventList() {
    this.events = new Map<DateTime, List<T>>();
  }

  /// Adds an event<`T`> to the specified date.
  void add(DateTime date, T event) {
    var convertedDate = zeroHoursAndMinutes(date);
    if (events == null) {
      events = {
        convertedDate: [event]
      };
    } else if (!events.containsKey(convertedDate)) {
      events[convertedDate] = [event];
    } else {
      events[convertedDate].add(event);
    }
  }

  /// Adds mutliple events<`List<T>`> to the specified date.
  void addAll(DateTime date, List<T> events) {
    var convertedDate = zeroHoursAndMinutes(date);
    if (this.events == null) {
      this.events = {convertedDate: events};
    } else if (!this.events.containsKey(convertedDate)) {
      this.events[convertedDate] = events;
    } else {
      this.events[convertedDate].addAll(events);
    }
  }

  /// Removes an event<`T`> from the specified date.
  bool remove(DateTime date, T event) {
    var convertedDate = zeroHoursAndMinutes(date);
    return events != null && events.containsKey(convertedDate)
        ? events[convertedDate].remove(event)
        : true;
  }

  /// Removes all events from the specified date.
  List<T> removeAll(DateTime date) {
    var convertedDate = zeroHoursAndMinutes(date);
    return events != null && events.containsKey(convertedDate)
        ? events.remove(convertedDate)
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
    var convertedDate = zeroHoursAndMinutes(date);
    return events != null && events.containsKey(convertedDate)
        ? events[convertedDate]
        : [];
  }

  /// Returns a new `DateTime` with time zeroed out.
  DateTime zeroHoursAndMinutes(DateTime date) {
    return new DateTime(date.year, date.month, date.day);
  }
}
