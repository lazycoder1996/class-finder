import 'dart:convert';

class UpdateScheduleBody {
  final String programme;
  final String day;
  final String roomName;
  final int startTime;
  final int endTime;
  final int year;
  UpdateScheduleBody({
    required this.programme,
    required this.day,
    required this.roomName,
    required this.startTime,
    required this.endTime,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'programme': programme,
      'day': day,
      'room_name': roomName,
      'start_time': startTime,
      'end_time': endTime,
      'year': year,
    };
  }

  factory UpdateScheduleBody.fromMap(Map<String, dynamic> map) {
    return UpdateScheduleBody(
      programme: map['programme'],
      day: map['day'],
      roomName: map['room_name'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      year: map['year'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateScheduleBody.fromJson(String source) =>
      UpdateScheduleBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateSchedule(programme: $programme, day: $day, roomName: $roomName, startTime: $startTime, endTime: $endTime, year: $year)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UpdateScheduleBody &&
        o.programme == programme &&
        o.day == day &&
        o.roomName == roomName &&
        o.startTime == startTime &&
        o.endTime == endTime &&
        o.year == year;
  }

  @override
  int get hashCode {
    return programme.hashCode ^
        day.hashCode ^
        roomName.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        year.hashCode;
  }
}
