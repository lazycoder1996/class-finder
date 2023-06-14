import 'package:timetable_app/data/models/responses/user_model.dart';

String userFullname(UserModel user) {
  return '${user.firstName} ${user.middleName ?? ''} ${user.surname}';
}
