import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionCardTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final Widget? trailing;
  final EdgeInsetsGeometry contentPadding;

  const ActionCardTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.trailing, // = const Icon(Icons.chevron_right, size: 20),
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 4.0,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color finalIconColor = iconColor ?? context.theme.colorScheme.primary;
    final Color finalTextColor =
        textColor ??
        context.theme.textTheme.bodyLarge?.color ??
        context.theme.colorScheme.onSurface;

    return Card(
      child: ListTile(
        leading: Icon(icon, color: finalIconColor),
        title: Text(
          title,
          style: context.theme.textTheme.bodyLarge?.copyWith(
            color: finalTextColor,
          ),
        ),
        trailing:
            trailing ??
            const Icon(Icons.chevron_right, size: 20), // Usa o padrão se null
        onTap: onTap,
        contentPadding: contentPadding,
      ),
    );
  }
}
