import 'package:flutter/material.dart';
import 'package:unping_ui/controller/base_badge_controller.dart';
import '../widget/base_badge_widget.dart';
import '../widget/badge_image.dart';
import '../widget/badge_count.dart';
import '../widget/badge_dot.dart';
// import 'package:unping_ui/controller/base_badge_controller.dart';
//import 'package:unping_ui/core/class/badge_size.dart';
import 'package:unping_ui/unping_ui.dart' hide BaseBadge, BadgeDot, BadgeImage, BadgeCount;

class BadgeFullDemoScreen extends StatelessWidget {
  BadgeFullDemoScreen({super.key});

  // Controllers for Badges
  final BaseBadgeController badgeController1 = BaseBadgeController();
  final BaseBadgeController badgeController2 = BaseBadgeController();
  final BaseBadgeController badgeController3 = BaseBadgeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Full Badge Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(' Base Badge with Dot & Image:'),
            const SizedBox(height: 8),
            BaseBadge(
              text: 'Hello Badge',
              leftWidget1: const BadgeDot(),
              leftWidget2: BadgeImage(imageUrl: ''),
              removable: true,
              controller: badgeController1,
           //   size: BadgeSize.md,
              backgroundColor: UiColors.neutral700,
              textColor: UiColors.onPrimary,
            ),
            const SizedBox(height: 20),

            const Text(' Base Badge only text:'),
            const SizedBox(height: 8),
            BaseBadge(
              text: 'Simple Badge',
              removable: true,
              controller: badgeController2,
           //   size: BadgeSize.sm,
              backgroundColor: UiColors.neutral500,
              textColor: UiColors.onPrimary,
            ),
            const SizedBox(height: 20),

            const Text(' Badge Count:'),
            const SizedBox(height: 8),
            BadgeCount(count: 5),
            const SizedBox(height: 20),

            const Text(' Badge Dot:'),
            const SizedBox(height: 8),
            const BadgeDot(),
            const SizedBox(height: 20),

            const Text(' Badge with Image only:'),
            const SizedBox(height: 8),
            BadgeImage(imageUrl: ''),
            const SizedBox(height: 20),

            const Text(' Base Badge with Remove Button:'),
            const SizedBox(height: 8),
            BaseBadge(
              text: 'Removable Badge',
              removable: true,
              controller: badgeController3,
         //     size: BadgeSize.lg,
              backgroundColor: UiColors.success500,
              textColor: UiColors.onPrimary,
            ),
            const SizedBox(height: 20),

            const Text(' Badge with custom colors:'),
            const SizedBox(height: 8),
            BaseBadge(
              text: 'Custom Colors',
              removable: false,
    //          size: BadgeSize.md,
              backgroundColor: UiColors.warning500,
              textColor: UiColors.neutral800,
            ),
            const SizedBox(height: 20),

            const Text(' Badge with multiple left widgets:'),
            const SizedBox(height: 8),
            BaseBadge(
              text: 'Left Widgets',
              leftWidget1: const BadgeDot(),
              leftWidget2: BadgeImage(imageUrl: ''),
              removable: true,
            //  size: BadgeSize.md,
              backgroundColor: UiColors.neutral700,
              textColor: UiColors.onPrimary,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          badgeController1.remove();
          badgeController2.remove();
          badgeController3.remove();
        },
        child: const Icon(Icons.remove),
      ),
    );
  }
}
