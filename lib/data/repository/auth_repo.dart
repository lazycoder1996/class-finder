import 'package:get/get_connect/connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable_app/data/api/api_client.dart';
import 'package:timetable_app/data/models/body/login_body.dart';
import 'package:timetable_app/utils/app_constants.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  AuthRepo({required this.sharedPreferences, required this.apiClient});

  // login
  Future<Response> login(LoginBody body) async {
    return await apiClient.postData(AppConstants.loginUri, body.toJson());
  }

  // keep user alive
  Future<void> updateToken(bool value) async {
    await sharedPreferences.setBool(AppConstants.loggedIn, value);
  }

  bool loggedIn() {
    return sharedPreferences.getBool(AppConstants.loggedIn) ?? false;
  }

  // logout
  Future<void> logout() async {
    await sharedPreferences.remove(AppConstants.loggedIn);
  }
}
