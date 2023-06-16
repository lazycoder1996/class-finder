import 'package:get/get.dart';
import 'package:timetable_app/data/models/responses/room_status_model.dart';
import 'package:timetable_app/data/repository/room_repo.dart';

import '../data/models/responses/room_model.dart';

class RoomController extends GetxController implements GetxService {
  final RoomRepo roomRepo;
  RoomController(this.roomRepo);

  // GET ALL ROOMS

  List<RoomModel>? _rooms;
  List<RoomModel>? get rooms => _rooms;

  Future<void> fetchAllRooms() async {
    Response response = await roomRepo.fetchAllRooms();
    if (response.statusCode == 200) {
      List<dynamic> body = response.body['rooms'];
      _rooms =
          List.generate(body.length, (index) => RoomModel.fromMap(body[index]));
    } else {}
    update();
  }

  int roomOpen = 800;
  int roomClose = 800;

  // GET LIVE ROOMS
  List<RoomStatusModel>? _liveRooms;
  List<RoomStatusModel>? get liveRooms => _liveRooms;

  Future<void> fetchLiveRooms(Map<String, dynamic> query) async {
    Response response = await roomRepo.fetchLiveRooms(query);
    if (response.statusCode == 200) {
      _liveRooms = [];
      List<dynamic> body = response.body['rooms'];
      _liveRooms = List.generate(
        body.length,
        (index) => RoomStatusModel.fromMap(
          body[index],
        ),
      );
      _liveRooms!.sort((a, b) {
        return a.endTime.compareTo(b.endTime);
      });
    } else {}
    update();
  }

  // GET EMPTY ROOMS
  List<RoomStatusModel>? _emptyRooms;
  List<RoomStatusModel>? get emptyRooms => _emptyRooms;

  List<RoomStatusModel>? _availableToday;
  List<RoomStatusModel>? get availableToday => _availableToday;

  Future<void> fetchEmptyRooms(Map<String, dynamic> query) async {
    Response response = await roomRepo.fetchEmptyRooms(query);
    if (response.statusCode == 200) {
      _emptyRooms = [];
      List<dynamic> body = response.body['rooms'];
      _emptyRooms = List.generate(
        body.length,
        (index) => RoomStatusModel.fromMap(
          body[index],
        ),
      );
      List i =
          List.generate(_liveRooms!.length, (index) => _liveRooms![index].room);
      _emptyRooms!.removeWhere((element) {
        return i.contains(element.room) ||
            ["PRACTICALS", "LAB"].contains(element.room);
      });
      _emptyRooms!.sort((a, b) {
        return a.startTime.compareTo(b.startTime);
      });
    } else {}

    update();
  }
}

List getAvailableTimes() {
  return [];
}
