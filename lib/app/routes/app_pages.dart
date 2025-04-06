import 'package:get/route_manager.dart';
import 'package:interlal/app/modules/home/bindings/home_binding.dart';
import 'package:interlal/app/modules/home/views/home_view.dart';
import 'package:interlal/app/modules/profile/views/profile_view.dart';
import 'package:interlal/app/modules/settings/bindings/settings_binding.dart';
import 'package:interlal/app/modules/settings/views/settings_view.dart';
import 'package:interlal/app/modules/shell/bindings/shell_binding.dart';
import 'package:interlal/app/modules/shell/views/shell_view.dart';
import 'package:interlal/app/routes/app_routes.dart';

class AppPages {
  static final initial = AppRoutes.shell;
  static final routes = [
    GetPage(
      name: AppRoutes.shell,
      page: () => ShellView(),
      binding: ShellBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.profile, page: () => ProfileView()),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
