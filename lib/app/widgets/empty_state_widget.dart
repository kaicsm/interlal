import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? details;
  final Widget? actionButton;

  const EmptyStateWidget({
    required this.icon,
    required this.message,
    this.details,
    this.actionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize:
              MainAxisSize
                  .min, // Para não ocupar a tela toda se estiver em um ListView
          children: [
            Icon(
              icon,
              size: 48,
              color: colorScheme.outline.withValues(alpha: 0.8),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Get.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (details != null) ...[
              const SizedBox(height: 8),
              Text(
                details!,
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionButton != null) ...[
              const SizedBox(height: 24),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}
