import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timetable_app/controllers/room_controller.dart';
import 'package:timetable_app/controllers/user_controller.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/app_colors.dart';
import 'package:timetable_app/utils/images.dart';
import 'package:timetable_app/views/base/custom_loader.dart';
import 'package:timetable_app/views/screens/home/widget/card_widget.dart';
import 'package:timetable_app/views/screens/home/widget/title_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Get.find<RoomController>().fetchLiveRooms({
      // 'time': 800,
      'time': DateTime.now().hour,
      'day': DateFormat().add_EEEE().format(DateTime.now()).toLowerCase(),
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
    String greeting = '';
    int hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      greeting = 'Morning';
    } else if (hour >= 12 && hour < 16) {
      greeting = 'Afternoon';
    } else if (hour >= 16) {
      greeting = 'Evening';
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<UserController>(builder: (userController) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Good $greeting\n',
                                      style: medium(16).copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${userController.user?.firstName} ${userController.user?.middleName} ${userController.user?.surname}',
                                      style: bold(24).copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Image.asset(
                              Images.profilePicture,
                              width: 60,
                              height: 60,
                            ),
                          ],
                        );
                      }),
                      15.h,
                      Text(
                        'Upcoming class',
                        style: medium(16),
                      ),
                      10.h,
                      const UpcomingClass(),
                    ],
                  ),
                ),
              ),
            ),
            10.h,
            GetBuilder<RoomController>(
              builder: (roomController) {
                return Column(
                  children: [
                    TitleWidget(
                      title: 'Ongoing Session',
                      onPressed: () {},
                    ),
                    !roomController.loadingLiveRooms
                        ? roomController.liveRooms!.isEmpty
                            ? Center(
                                child: Text(
                                  'No data found',
                                  style: bold(18),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 130,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: roomController.liveRooms!.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return RoomItem(
                                    room: roomController.liveRooms![index],
                                  );
                                })
                        : const Center(
                            child: CustomLoader(),
                          ),
                    TitleWidget(
                      title: 'Empty Rooms',
                      onPressed: () {},
                    ),
                    10.h,
                    !roomController.loadingLiveRooms
                        ? roomController.liveRooms!.isEmpty
                            ? Center(
                                child: Text(
                                  'No data found',
                                  style: bold(18),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 130,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: roomController.liveRooms!.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return RoomItem(
                                    room: roomController.liveRooms![index],
                                    occupied: false,
                                  );
                                })
                        : const Center(
                            child: CustomLoader(),
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingClass extends StatelessWidget {
  const UpcomingClass({super.key});

  @override
  Widget build(BuildContext context) {
    String day = DateFormat().add_E().format(DateTime.now());
    String date = DateFormat().add_d().format(DateTime.now());
    return Container(
      height: 115,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 96,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${day.toUpperCase()}\n${date.padLeft(2, '0')}',
                  style: bold(24).copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              20.w,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ME 161',
                      style: medium(16)
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      'BASIC MECHANICS',
                      style: semiBold(16)
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    const Spacer(),
                    Text(
                      '08:00 - 09:55',
                      style: regular(14)
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      'PB201, Engineering',
                      style: regular(15)
                          .copyWith(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              )
            ],
          ),
          SvgPicture.asset(Images.bubble)
        ],
      ),
    );
  }
}
