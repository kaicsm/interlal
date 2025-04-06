import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/modules/shell/controllers/shell_controller.dart';

class ShellView extends StatelessWidget {
  ShellView({super.key});

  final ShellController _shellController = Get.find<ShellController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: _shellController.currentIndex,
          children:
              _shellController.pages
                  .map((pageInfo) => pageInfo.pageBuilder())
                  .toList(),
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: _shellController.currentIndex,
          onDestinationSelected:
              (index) => _shellController.setCurrentIndex(index),
          destinations:
              _shellController.pages.map((pageInfo) {
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
