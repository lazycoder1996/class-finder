import 'dart:convert';

class RoomStatusModel {
  final String room;
  final String programme;
  final int year;
  final String course;
  final int startTime;
  final int endTime;
  RoomStatusModel({
    required this.room,
    required this.programme,
    required this.year,
    required this.course,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'room': room,
      'programme': programme,
      'year': year,
      'course': course,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  factory RoomStatusModel.fromMap(Map<String, dynamic> map) {
    return RoomStatusModel(
      room: map['room'],
      programme: map['programme'],
      year: map['year'],
      course: map['course'],
      startTime: map['start_time'],
      endTime: map['end_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomStatusModel.fromJson(String source) =>
      RoomStatusModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomStatusReponse(room: $room, programme: $programme, year: $year, course: $course, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomStatusModel &&
        o.room == room &&
        o.programme == programme &&
        o.year == year &&
        o.course == course &&
        o.startTime == startTime &&
        o.endTime == endTime;
  }

  @override
  int get hashCode {
    return room.hashCode ^
        programme.hashCode ^
        year.hashCode ^
        course.hashCode ^
        startTime.hashCode ^
        endTime.hashCode;
  }
}
