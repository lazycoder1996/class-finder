import 'package:get/get.dart';
import 'package:timetable_app/data/models/responses/room_status_model.dart';
import 'package:timetable_app/data/repository/room_repo.dart';

class RoomController extends GetxController implements GetxService {
  final RoomRepo roomRepo;
  RoomController(this.roomRepo);

  // GET LIVE ROOMS
  List<RoomStatusModel>? _liveRooms;
  List<RoomStatusModel>? get liveRooms => _liveRooms;

  Future<void> fetchLiveRooms(Map<String, dynamic> query) async {
    update();
    Response response = await roomRepo.fetchLiveRooms(query);
    if (response.statusCode == 200) {
      _liveRooms = [];
      List<dynamic> body = response.body['rooms'];
      print('room $body');
      _liveRooms = List.generate(
        body.length,
        (index) => RoomStatusModel.fromMap(
          body[index],
        ),
      );
    } else {}
    update();
  }

  // GET EMPTY ROOMS
  List<RoomStatusModel>? _emptyRooms;
  List<RoomStatusModel>? get emptyRooms => _emptyRooms;

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
    } else {}

    update();
  }
}
