import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timetable_app/controllers/booking_controller.dart';
import 'package:timetable_app/data/models/responses/booking_model.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/utils/app_colors.dart';
import 'package:timetable_app/utils/navigation.dart';

import '../../../../helpers/font_styles.dart';
import '../../../base/custom_snackbar.dart';

class BookingWidget extends StatefulWidget {
  final BookingModel booking;
  final BookingController controller;

  const BookingWidget({
    super.key,
    required this.booking,
    required this.controller,
  });

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            // borderRadius: BorderRadius.circular(15),
            padding: EdgeInsets.zero,
            onPressed: (context) async {
              showDialog<void>(
                context: context,
                barrierDismissible: true,

                // false = user must tap button, true = tap outside dialog
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: 16.border,
                    ),
                    title: const Text('Delete'),
                    content: widget.controller.deleting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Would you want to delete this booking?'),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Yes'),
                        onPressed: () async {
                          await widget.controller
                              .deleteBooking(widget.booking.id)
                              .then((status) {
                            showCustomSnackBar(status.message,
                                isError: !status.isSuccess);
                            pop(dialogContext);
                          });
                        },
                      ),
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(dialogContext)
                              .pop(); // Dismiss alert dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            foregroundColor: AppColors.red,
            backgroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      // endActionPane: ActionPane(
      //   extentRatio: 0.2,
      //   motion: const ScrollMotion(),
      //   children: [
      //     SlidableAction(
      //       onPressed: (context) {},
      //       backgroundColor: Colors.white,
      //       foregroundColor: AppColors.red,
      //       icon: Icons.edit,
      //       label: 'Edit',
      //     ),
      //   ],
      // ),
      key: Key(widget.booking.id.toString()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          elevation: 2.5,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 115,
            width: double.maxFinite,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: AppColors.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: 96,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.booking.day.substring(0, 3).toUpperCase(),
                      style: bold(22).copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                15.w,
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${widget.booking.course.code} ${widget.booking.course.name}',
                        overflow: TextOverflow.ellipsis,
                        style: bold(18),
                      ),
                      Text(
                        widget.booking.room,
                        style: semiBold(17),
                      ),
                      Text(
                        '${widget.booking.startTime.toTime} - ${widget.booking.endTime.toTime}',
                        style: regular(16),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
