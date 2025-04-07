import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/modules/shell/controllers/shell_controller.dart';

class ShellView extends GetView<ShellController> {
  const ShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex,
          children:
              controller.pages
                  .map(
                    (pageInfo) => KeyedSubtree(
                      key: ValueKey(pageInfo.name),
                      child: pageInfo.page,
                    ),
                  )
                  .toList(),
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex,
          onDestinationSelected: (index) => controller.setCurrentIndex(index),
          destinations:
              controller.pages.map((pageInfo) {
                return NavigationDestination(
                  icon: Icon(pageInfo.icon),
                  selectedIcon: Icon(pageInfo.selectedIcon),
                  label: pageInfo.name,
                );
              }).toList(),
        ),
      ),
    );
  }
}
