import 'package:get/get.dart';
import 'package:interlal/app/modules/ranking/controllers/ranking_controller.dart';

class RankingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RankingController());
  }
}
