import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:interlal/app/modules/home/views/home_view.dart';
import 'package:interlal/app/modules/profile/views/profile_view.dart';
import 'package:interlal/app/modules/ranking/views/ranking_view.dart';

class ShellController extends GetxController {
  final List<PageInfo> _pages = [
    PageInfo(
      name: 'Inicio',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      page: HomeView(),
    ),
    PageInfo(
      name: 'Ranking',
      icon: Icons.leaderboard_outlined,
      selectedIcon: Icons.leaderboard,
      page: RankingView(),
    ),
    PageInfo(
      name: 'Perfil',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      page:ProfileView(),
    ),
  ];
  List<PageInfo> get pages => _pages;

  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  void setCurrentIndex(int index) {
    _currentIndex.value = index;
  }
}

class PageInfo {
  final String name;
  final IconData icon;
  final IconData selectedIcon;
  final Widget  page;

  PageInfo({
    required this.name,
    required this.icon,
    required this.selectedIcon,
    required this.page,
  });
}
