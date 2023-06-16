import 'dart:convert';

class RoomModel {
  final String name;
  final int size;
  RoomModel({
    required this.name,
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'room_name': name,
      'size': size,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      name: map['room_name'],
      size: map['size'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() => 'RoomModel(name: $name, size: $size)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomModel && o.name == name && o.size == size;
  }

  @override
  int get hashCode => name.hashCode ^ size.hashCode;
}
