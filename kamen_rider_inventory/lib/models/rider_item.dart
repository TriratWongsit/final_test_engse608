class RiderItem {
  int? id;
  String name;
  String era;
  String type;
  String status;

  RiderItem({this.id, required this.name, required this.era, required this.type, required this.status});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'era': era, 'type': type, 'status': status};
  }

  factory RiderItem.fromMap(Map<String, dynamic> map) {
    return RiderItem(
      id: map['id'],
      name: map['name'],
      era: map['era'],
      type: map['type'],
      status: map['status'],
    );
  }
}