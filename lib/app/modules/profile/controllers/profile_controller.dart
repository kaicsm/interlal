import 'package:get/get.dart';
import 'package:interlal/app/core/services/auth_service.dart';

class ProfileController extends GetxController {
  late AuthService _authService;

  @override
  void onInit() {
    _authService = Get.find<AuthService>();
    super.onInit();
  }

  String getUserName() {
    return _authService.currentUser?.userMetadata?['name'] ?? 'Aluno';
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
