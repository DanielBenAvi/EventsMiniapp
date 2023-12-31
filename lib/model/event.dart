class EventObject {
  String name;
  DateTime date;
  String location;
  String description;
  String image;
  String contact;
  List<String> attendees;
  List<String> preferences;

  EventObject(
      {required this.name,
      required this.date,
      required this.description,
      required this.location,
      required this.contact,
      required this.image,
      required this.attendees,
      required this.preferences});

  @override
  String toString() {
    return 'Event{name: $name, description: $description, location: $location,'
        ' date: $date, contact: $contact, image: $image, attendees: $attendees,'
        ' preferences: $preferences}';
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
  EventObject.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        location = json['location'],
        date = DateTime.parse(json['date']),
        contact = json['contact'],
        image = json['image'],
        attendees = json['attendees'],
        preferences = json['preferences'];
}
