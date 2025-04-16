import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:interlal/app/core/services/auth_service.dart';
import 'package:interlal/app/routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final AuthService authService = Get.find();
    final bool isSignedIn = authService.isSignedIn();

    if (!isSignedIn && route != AppRoutes.signin) {
      return const RouteSettings(name: AppRoutes.signin);
    } else if (isSignedIn && route == AppRoutes.signin) {
      return const RouteSettings(name: AppRoutes.shell);
    }

    return null;
  }
}
