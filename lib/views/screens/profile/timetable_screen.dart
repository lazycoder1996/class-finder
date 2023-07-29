import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/schedule_controller.dart';
import 'package:timetable_app/controllers/timetime_controller.dart';
import 'package:timetable_app/controllers/user_controller.dart';
import 'package:timetable_app/data/models/body/update_schedule_body.dart';
import 'package:timetable_app/data/models/responses/timetable_model.dart';
import 'package:timetable_app/data/models/responses/user_model.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/navigation.dart';
import 'package:timetable_app/views/base/custom_snackbar.dart';
import 'package:timetable_app/views/screens/profile/course.dart';

import '../../../utils/app_colors.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  String selectedDay = 'Monday';
  late UserModel user;

  @override
  void initState() {
    super.initState();
    user = Get.find<UserController>().user!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Timetable'),
      ),
      body: GetBuilder<TimetableController>(
        builder: (tController) {
          // print(tController.timeTable!.first.toMap());
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday'
                  ].map((e) {
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedDay = e;
                          });
                        },
                        child: Card(
                          color: selectedDay == e
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e.substring(0, 3),
                              textAlign: TextAlign.center,
                              style: semiBold(16).copyWith(
                                color: selectedDay == e
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                20.h,
                ListView.builder(
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 1,
                  //   mainAxisExtent: 120,
                  //   mainAxisSpacing: 5,
                  // ),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: tController.timeTable!
                      .where((element) =>
                          element.day.toLowerCase() ==
                              selectedDay.toLowerCase() &&
                          element.recursive)
                      .length,
                  itemBuilder: (context, index) {
                    List<TimetableModel> timetableModel = tController.timeTable!
                        .where((element) =>
                            element.day.toLowerCase() ==
                                selectedDay.toLowerCase() &&
                            element.recursive)
                        .toList();
                    timetableModel
                        .sort((a, b) => a.startTime.compareTo(b.startTime));
                    TimetableModel timetable = timetableModel[index];
                    return Slidable(
                      startActionPane: user.role == 0
                          ? null
                          : ActionPane(
                              extentRatio: 0.2,
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  // borderRadius: BorderRadius.circular(15),
                                  padding: EdgeInsets.zero,
                                  onPressed: (context) async {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return CancelClassWidget(
                                            timetable: timetable);
                                      },
                                    );
                                  },
                                  foregroundColor: AppColors.red,
                                  backgroundColor: Colors.white,
                                  icon: Icons.cancel_presentation,
                                  label: 'Cancel',
                                ),
                              ],
                            ),
                      child: CourseCard(timetableModel: timetable),
                    );
                  },
                )
                // Padding(
                //   padding: const EdgeInsets.all(3.0),
                //   child: DataTable(
                //     columnSpacing: 15,
                //     border: TableBorder.all(),
                //     columns: [
                //       // 'Code',
                //       'Course',
                //       'Room',
                //       'Start',
                //       'End',
                //     ].map((e) {
                //       return DataColumn(
                //         label: Text(
                //           e,
                //           style: bold(15),
                //         ),
                //       );
                //     }).toList(),
                //     rows: tController.timeTable!
                //         .where((tt) =>
                //             tt.day.toLowerCase() == selectedDay.toLowerCase())
                //         .map((e) {
                //       return DataRow(
                //           cells: [
                //         // e.course.code,
                //         e.course.name,
                //         e.room.name,
                //         e.startTime.toTime,
                //         e.endTime.toTime
                //       ].map((row) {
                //         return DataCell(
                //           Text(
                //             row,
                //             style: semiBold(14),
                //           ),
                //         );
                //       }).toList());
                //     }).toList(),
                //   ),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CancelClassWidget extends StatelessWidget {
  const CancelClassWidget({
    Key? key,
    required this.timetable,
  }) : super(key: key);

  final TimetableModel timetable;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(builder: (scheduleController) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: 16.border,
        ),
        title: const Text('Cancel Class'),
        content: scheduleController.cancelling
            ? const SizedBox(
                height: 40,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const Text('Are you sure you want to cancel this week\'s class?'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Yes'),
            onPressed: () async {
              UserModel user = Get.find<UserController>().user!;
              UpdateScheduleBody body = UpdateScheduleBody(
                programme: user.programme,
                day: timetable.day,
                roomName: timetable.room.name,
                startTime: timetable.startTime,
                endTime: timetable.endTime,
                year: user.year,
              );
              await scheduleController.cancelClass(body).then((value) {
                showCustomSnackBar(value.message, isError: !value.isSuccess);
                pop(context);
              });
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss alert dialog
            },
          ),
        ],
      );
    });
  }
}
