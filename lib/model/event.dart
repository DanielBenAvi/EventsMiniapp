class Event {
  String name;
  String description;
  String location;
  String contact;
  DateTime date;
  String image;
  Map<String, dynamic> attendees;
  Map<String, dynamic> preferences;

  Event(
      {required this.name,
      required this.description,
      required this.location,
      required this.contact,
      required this.date,
      required this.image,
      required this.attendees,
      required this.preferences});

  @override
  String toString() {
    return 'Event{name: $name, description: $description, location: $location, date: $date, contact: $contact, image: $image, attendees: $attendees, preferences: $preferences}';
  }

  // toJson

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'location': location,
        'date': date.toIso8601String(),
        'contact': contact,
        'image': image,
        'attendees': attendees,
        'preferences': preferences
      };

  // fromJson
  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        location = json['location'],
        date = DateTime.parse(json['date']),
        contact = json['contact'],
        image = json['image'],
        attendees = json['attendees'],
        preferences = json['preferences'];
}
