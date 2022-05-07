import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/helpers/activeAccont.dart';
import 'package:mkdao/helpers/backendhelper.dart';

class RemoteAccountCreationView extends StatelessWidget {
  RemoteAccountCreationView({Key? key}) : super(key: key);
  RxString _state = "launch".obs;
  Account? newlycreatedAccount;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (_state.value) {
        case "launch":
          return Container(
            child: Center(
                child: ElevatedButton(
                    onPressed: () async {
                      _state.value = "loading";
                      //send in the unique value here
                      var acc = await BackendHelper().createAccount();
                      if (acc != null) {
                        newlycreatedAccount = acc;
                        _state.value = "done";
                      }
                    },
                    child: const Text("Tap to create your Hedera Account!!"))),
          );
        case "loading":
          return CircularProgressIndicator.adaptive();
        case "done":
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Your account ID is: ${newlycreatedAccount!.accountID}"),
                Text("Your PUbLIC KEY is: ${newlycreatedAccount!.publicKey}"),
                Text("Your PRIVATE KEY is: ${newlycreatedAccount!.privateKey}"),
              ],
            ),
          );
        default:
          return Container();
      }
    });
  }
}
