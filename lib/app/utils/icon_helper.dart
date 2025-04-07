import 'package:flutter/material.dart';

class IconHelper {
  static IconData getSportIcon(String sport) {
    final lowerCaseSport = sport.toLowerCase();
    if (lowerCaseSport.contains('futsal')) return Icons.sports_soccer;
    if (lowerCaseSport.contains('vôlei')) return Icons.sports_volleyball;
    if (lowerCaseSport.contains('basquete')) return Icons.sports_basketball;
    if (lowerCaseSport.contains('handebol')) return Icons.sports_handball;
    return Icons.sports;
  }

  static IconData getRankingTypeIcon(String rankingType) {
    final lowerCaseType = rankingType.toLowerCase();
    if (lowerCaseType.contains('times')) return Icons.group_outlined;
    if (lowerCaseType.contains('jogadores')) return Icons.person_outline;
    return Icons.leaderboard_outlined;
  }
}
