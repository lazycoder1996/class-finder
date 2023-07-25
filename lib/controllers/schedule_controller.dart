import 'package:get/get.dart';
import 'package:timetable_app/data/models/body/update_schedule_body.dart';
import 'package:timetable_app/data/models/responses/response_model.dart';

import '../data/repository/schedule_repo.dart';

class ScheduleController extends GetxController implements GetxService {
  final ScheduleRepo scheduleRepo;
  ScheduleController(this.scheduleRepo);

  bool _cancelling = false;
  bool get cancelling => _cancelling;

  // CANCEL CLASS
  Future<ResponseModel> cancelClass(UpdateScheduleBody updateBody) async {
    _cancelling = true;
    update();
    ResponseModel responseModel;
    Response response = await scheduleRepo.updateSchedule(updateBody);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, 'Classed cancelled succesfully');
    } else {
      print('error occured');
      responseModel = ResponseModel(false, 'Error cancelling class');
    }
    _cancelling = false;
    update();
    return responseModel;
  }
}
