import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Colors.blue;

  static final ThemeData lightTheme = _buildTheme(Brightness.light);
  static final ThemeData darkTheme = _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );

    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
    );

    return baseTheme.copyWith(
      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: brightness == Brightness.light ? 1.0 : 0.5,
        iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      ),

      chipTheme: ChipThemeData(
        selectedColor: colorScheme.secondaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        labelStyle: baseTheme.textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.normal,
        ),
        secondaryLabelStyle: baseTheme.textTheme.labelLarge?.copyWith(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: colorScheme.primary, size: 18),

        showCheckmark: false,
        shape: StadiumBorder(
          side: BorderSide(
            color: colorScheme.outlineVariant.withAlpha((255 * 0.5).round()),
            width: 1.0,
          ),
        ),
      ),

      cardTheme: CardTheme(
        elevation: brightness == Brightness.light ? 1.0 : 1.5,
        color: colorScheme.surfaceContainerLow,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 0.8,
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        indicatorColor: colorScheme.secondaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
          Set<WidgetState> states,
        ) {
          final style = baseTheme.textTheme.labelSmall!;
          return states.contains(WidgetState.selected)
              ? style.copyWith(color: colorScheme.onSurface)
              : style.copyWith(color: colorScheme.onSurfaceVariant);
        }),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
          (Set<WidgetState> states) => IconThemeData(
            color:
                states.contains(WidgetState.selected)
                    ? colorScheme.onSecondaryContainer
                    : colorScheme.onSurfaceVariant,
          ),
        ),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 70,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        hintStyle: TextStyle(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 0.8,
        space: 1,
      ),

      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
      ),

      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        titleTextStyle: baseTheme.textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        contentTextStyle: baseTheme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
