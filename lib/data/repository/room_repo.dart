import 'package:get/get_connect/http/src/response/response.dart';
import 'package:timetable_app/data/api/api_client.dart';
import 'package:timetable_app/utils/app_constants.dart';

class RoomRepo {
  final ApiClient apiClient;
  RoomRepo({required this.apiClient});


  // LIVE ROOMS
  Future<Response> fetchLiveRooms(Map<String, dynamic> query) async{
    return await apiClient.getData(AppConstants.rooms + AppConstants.liveRooms,query: query);
  }
}
