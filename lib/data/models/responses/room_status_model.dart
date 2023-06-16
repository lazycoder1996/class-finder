import 'dart:convert';

import 'package:timetable_app/data/models/responses/course_model.dart';

class RoomStatusModel {
  final String room;
  final String programme;
  final int year;
  final CourseModel course;
  final int startTime;
  final int endTime;
  final bool status;
  RoomStatusModel({
    required this.room,
    required this.programme,
    required this.year,
    required this.course,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'room': room,
      'programme': programme,
      'year': year,
      'course': course.toMap(),
      'start_time': startTime,
      'endt_ime': endTime,
      'status': status,
    };
  }

  factory RoomStatusModel.fromMap(Map<String, dynamic> map) {
    String room = map['room'];
    return RoomStatusModel(
      room: room.split('/').first,
      programme: map['programme'] ,
      year: map['year'],
      course: CourseModel.fromMap(map['course']),
      startTime: map['start_time'],
      endTime: map['end_time'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomStatusModel.fromJson(String source) =>
      RoomStatusModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomStatusModel(room: $room, programme: $programme, year: $year, course: $course, startTime: $startTime, endTime: $endTime, status: $status)';
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
        o.endTime == endTime &&
        o.status == status;
  }

  @override
  int get hashCode {
    return room.hashCode ^
        programme.hashCode ^
        year.hashCode ^
        course.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        status.hashCode;
  }
}
