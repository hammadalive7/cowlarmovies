import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/navigation_controller.dart';

class NavigationItem extends StatefulWidget {
  final int index;
  final String icon;

  const NavigationItem({
    required this.index,
    required this.icon,
    super.key,
  });

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  final _navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: 40,
        height: 40,
        child: IconButton(
          onPressed: () {
            if (_navigationController.selectedIndex.value == widget.index) {
              return;
            }
            HapticFeedback.selectionClick();
            _navigationController.changeScreen(widget.index);
          },
          icon: Stack(
            children: [
              SvgPicture.asset(
                widget.icon,
                colorFilter: ColorFilter.mode(
                  _navigationController.selectedIndex.value == widget.index
                      ? const Color(0xFF0296E5)
                      : const Color(0xFFE5E6E6),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
