import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/LandingPage/landingpagecontroller.dart';
import 'package:mkdao/models/newAccountModel.dart';

import '../MainPage/mainpage.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  LandingPageController controller = Get.put(LandingPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: ElevatedButton(
          onPressed: () async {
            await Get.defaultDialog(
                content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        List keys = await controller.createAccount();
                        Account acc = keys[0];
                        PrivateKey private = keys[1];
                        PublicKey public = keys[2];

                        await Get.defaultDialog(
                            content: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Obx(() {
                                  switch (controller.currenState.value) {
                                    case creationState.loading:
                                      return const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      );
                                    case creationState.success:
                                      return Column(children: [
                                        Text(acc.id),
                                        Text(private.id),
                                        Text(public.id),
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                return MainPage();
                                              }));
                                            },
                                            child: const Text("Continue"))
                                      ]);
                                    default:
                                      return const Center(
                                        child: Text("UNknown error"),
                                      );
                                  }
                                })));
                      },
                      child: Text("create new wallet"))
                ],
              ),
            ));
          },
          child: const Text("Join us")),
    ));
  }
}
