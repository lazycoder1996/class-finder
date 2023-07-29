import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/booking_controller.dart';
import 'package:timetable_app/views/base/custom_loader.dart';
import 'package:timetable_app/views/screens/booking/widgets/booking_widget.dart';

import '../../../controllers/user_controller.dart';
import '../../../data/models/responses/user_model.dart';
import '../../../helpers/font_styles.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (bookController) {
      if (bookController.bookings == null) {
        return const Center(
          child: CustomLoader(size: 50),
        );
      }
      // else if (bookController.bookings!.isEmpty) {
      //   return Center(
      //     child: Text(
      //       'No data found',
      //       style: bold(18),
      //     ),
      //   );
      // }
      else {
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            UserModel user = Get.find<UserController>().user!;

            await bookController.getBookings({
              'programme': user.programme,
              'year': user.year,
            });
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: ListView.builder(
              // physics: const BouncingScrollPhysics(),
              itemCount: bookController.bookings!.isEmpty
                  ? 1
                  : bookController.bookings!.length,
              itemBuilder: (context, index) {
                // BookingModel booking = ;
                return bookController.bookings!.isEmpty
                    ? Center(
                        child: Text(
                          'No data found',
                          style: bold(18),
                        ),
                      )
                    : BookingWidget(
                        booking: bookController.bookings![index],
                        controller: bookController,
                      );
              },
            ),
          ),
        );
      }
    });
  }
}
