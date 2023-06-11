import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/user_controller.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/app_colors.dart';
import 'package:timetable_app/utils/images.dart';
import 'package:timetable_app/views/screens/home/widget/title_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                          children: [
                            Flexible(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Good Afternoon\n',
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
            20.h,
            TitleWidget(
              title: 'Ongoing Session',
              onPressed: () {},
            ),
            TitleWidget(
              title: 'Empty Rooms',
              onPressed: () {},
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
                  // TODO: TAKE ACTUAL DAY AND FORMAT ACCODINGLY
                  'FRI\n09',
                  style: bold(24).copyWith(color: Colors.white),
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
