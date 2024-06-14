
import 'package:flutter/material.dart';
import '../../../../constants/utils.dart';
import 'navigation_item.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceUtils.getDynamicHeight(context, 0.08),
      // margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Color(0xFF242A32),
        // color border top border
        border: Border.lerp(
          const Border(
            top: BorderSide(
              color: Color(0xFF0296E5),
              width: 2.0,
            ),
          ),
          const Border(
            top: BorderSide(
              color: Color(0xFF242A32),
              width: 1.0,
            ),
          ),
          0.5,
        ),
        // borderRadius: BorderRadius.circular(36.0),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigationItem(index: 0, icon: "assets/icons/Home.svg"),
          NavigationItem(index: 1, icon: "assets/icons/Search.svg"),
          NavigationItem(index: 2, icon: "assets/icons/Save.svg"),
          NavigationItem(index: 3, icon: "assets/icons/BT.svg"),
          NavigationItem(index: 4, icon: "assets/icons/MQTT.svg"),
        ],
      ),
    );
  }
}
