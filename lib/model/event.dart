class Event {
  String name;
  String description;
  String location;
  DateTime date;
  String time;
  String image;

  Event(
      {required this.name,
      required this.description,
      required this.location,
      required this.date,
      required this.time,
      required this.image});

  @override
  String toString() {
    return 'Event{name: $name, description: $description, location: $location, date: $date, time: $time, image: $image}';
  }

  // toJson

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'location': location,
        'date': date,
        'time': time,
        'image': image,
      };

  // fromJson
  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        location = json['location'],
        date = json['date'],
        time = json['time'],
        image = json['image'];
}
