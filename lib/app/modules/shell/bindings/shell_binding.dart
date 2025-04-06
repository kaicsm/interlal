import 'package:get/instance_manager.dart';
import 'package:interlal/app/modules/home/bindings/home_binding.dart';
import 'package:interlal/app/modules/profile/bindings/profile_binding.dart';
import 'package:interlal/app/modules/shell/controllers/shell_controller.dart';

class ShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShellController>(() => ShellController());
    HomeBinding().dependencies();
    ProfileBinding().dependencies();
  }
}
