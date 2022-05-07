import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mkdao/models/newAccountModel.dart';

enum creationState { loading, success, failure }

class LandingPageController extends GetxController {
  Rx<creationState> currenState = creationState.loading.obs;

  Future<List> createAccount() async {
    currenState.value = creationState.loading;
    var accountID = Account(id: "id");
    var pk = PrivateKey(id: "id");
    var pubkey = PublicKey(id: "id");
    await Future.delayed(const Duration(seconds: 3), () {
      currenState.value = creationState.success;
    });

    return [accountID, pk, pubkey];
  }
}
