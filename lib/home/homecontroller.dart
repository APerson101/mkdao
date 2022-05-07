import 'package:get/get.dart';

enum pages { activity, community, dashboard, invoice, report, notifications }

class HomeViewController extends GetxController {
  Rx<pages> currentPage = pages.dashboard.obs;
}
