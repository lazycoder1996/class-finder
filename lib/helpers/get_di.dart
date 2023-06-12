import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable_app/controllers/auth_controller.dart';
import 'package:timetable_app/controllers/room_controller.dart';
import 'package:timetable_app/controllers/user_controller.dart';
import 'package:timetable_app/data/api/api_client.dart';
import 'package:timetable_app/data/repository/auth_repo.dart';
import 'package:timetable_app/data/repository/room_repo.dart';
import 'package:timetable_app/data/repository/user_repo.dart';
import 'package:timetable_app/utils/app_constants.dart';

Future<void> init() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // CORE
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: sharedPreferences));

  // REPO
  Get.lazyPut(() =>
      AuthRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
  Get.lazyPut(() =>
      UserRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
  Get.lazyPut(() =>
      RoomRepo( apiClient: Get.find()));

  // CONTROLLERS
  Get.lazyPut(() => AuthController(Get.find()));
  Get.lazyPut(() => UserController(Get.find()));
  Get.lazyPut(() => RoomController(Get.find()));
}
