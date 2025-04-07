import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;

  const SectionTitle(
    this.title, {
    this.padding = const EdgeInsets.only(top: 24.0, bottom: 12.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(title, style: Get.textTheme.titleLarge),
    );
  }
}
