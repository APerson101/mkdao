import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mkdao/helpers/backendhelper.dart';

import '../helpers/activeAccont.dart';

enum creationState { loading, success, failure }

class LandingPageController extends GetxController {
  Rx<creationState> currenState = creationState.loading.obs;

  Future<Account> createAccount() async {
    var acc = Account.fromJson(
        '{"privateKey":"894f220341596b205bf5c4b2185285eb0e0e56093f10da11b52907d8e8c97a96","publicKey":"de4b19662143e9edcc458362d04446629505e63ee22432a9bf9ad3d61f3843a1","accountID":"0.0.34713172"}');
    currenState.value = creationState.success;
    return acc;

    // return await BackendHelper().createAccount();
  }
}
