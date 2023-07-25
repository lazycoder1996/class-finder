import 'package:flutter/material.dart';
import 'package:timetable_app/helpers/font_styles.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Widget? child;
  final void Function() onPressed;
  final bool showViewAll;
  const TitleWidget({
    super.key,
    required this.title,
    this.child,
    required this.onPressed,
    this.showViewAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          child ??
              Text(
                title,
                style: bold(16).copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
          const Spacer(),
          if (showViewAll)
            TextButton(
              onPressed: onPressed,
              child: const Text('View all'),
            ),
        ],
      ),
    );
  }
}
