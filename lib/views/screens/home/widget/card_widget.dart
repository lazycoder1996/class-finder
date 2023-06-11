import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/styles.dart';
import 'package:timetable_app/utils/images.dart';

class RoomItem extends StatefulWidget {
  final bool occupied;
  const RoomItem({
    super.key,
    this.occupied = true,
  });

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: Dimensions.RadiusMedium.border,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: widget.occupied
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              if (widget.occupied)
                Lottie.asset(
                  Images.live,
                  height: 30,
                  width: 30,
                ),
              5.w,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'PB 008',
                    style: sansBold,
                  ),
                  // 20.h,
                  Text(
                    'ME 161',
                    style: sansMedium,
                  ),
                  // 20.h,
                  Text(
                    '8:00 - 10:00',
                    style: sansRegular,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
