import 'package:get/route_manager.dart';
import 'package:interlal/app/modules/auth/bindings/auth_binding.dart';
import 'package:interlal/app/modules/auth/views/signin_view.dart';
import 'package:interlal/app/modules/auth/views/signup_view.dart';
import 'package:interlal/app/modules/home/bindings/home_binding.dart';
import 'package:interlal/app/modules/home/views/home_view.dart';
import 'package:interlal/app/modules/profile/bindings/profile_binding.dart';
import 'package:interlal/app/modules/profile/views/profile_view.dart';
import 'package:interlal/app/modules/ranking/bindings/ranking_binding.dart';
import 'package:interlal/app/modules/ranking/views/ranking_view.dart';
import 'package:interlal/app/modules/settings/bindings/settings_binding.dart';
import 'package:interlal/app/modules/settings/views/settings_view.dart';
import 'package:interlal/app/modules/shell/bindings/shell_binding.dart';
import 'package:interlal/app/modules/shell/views/shell_view.dart';
import 'package:interlal/app/routes/app_routes.dart';
import 'package:interlal/app/routes/middlewares/auth_middleware.dart';

class AppPages {
  static final initial = AppRoutes.shell;
  static final routes = [
    GetPage(
      name: AppRoutes.shell,
      page: () => ShellView(),
      binding: ShellBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.ranking,
      page: () => RankingView(),
      binding: RankingBinding(),
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => SigninView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupView(),
      binding: AuthBinding(),
    ),
  ];
}
