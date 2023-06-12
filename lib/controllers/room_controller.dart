import 'package:get/get.dart';
import 'package:timetable_app/data/models/responses/room_model.dart';
import 'package:timetable_app/data/repository/room_repo.dart';

class RoomController extends GetxController implements GetxService {
  final RoomRepo roomRepo;
  RoomController(this.roomRepo);

  // GET LIVE ROOMS
  bool _loadingLiveRooms = false;
  bool get loadingLiveRooms => _loadingLiveRooms;

  List<RoomStatusModel>? _liveRooms;
  List<RoomStatusModel>? get liveRooms => _liveRooms;

  Future<void> fetchLiveRooms(Map<String, dynamic> query) async {
    _loadingLiveRooms = true;
    update();
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
      // _liveRooms!.addAll(liveRooms!.toList());
    } else {}
    _loadingLiveRooms = false;
    update();
  }
}
