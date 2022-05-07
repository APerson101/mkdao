import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/MainPage/daocreator.dart';
import 'package:mkdao/MainPage/mainpagecontroller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  MainPageController controller = Get.put(MainPageController());
  DAOCreator creator = Get.put(DAOCreator());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Row(
        children: [
          ElevatedButton(
              onPressed: () async {
                //
                await Get.defaultDialog(
                    content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Container(child: daoform(context)),
                ));
              },
              child: const Text("CREATE DAO")),
        ],
      ),
    ));
  }

  Widget daoform(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter dao name",
            ),
            onChanged: (newText) {
              creator.daoName.value = newText;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter dao description",
            ),
            onChanged: (newText) {
              creator.daoName.value = newText;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter token name",
            ),
            onChanged: (newText) {
              creator.daoName.value = newText;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter token symbol",
            ),
            onChanged: (newText) {
              creator.daoName.value = newText;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter Initial supply",
            ),
            onChanged: (newText) {
              creator.daoName.value = newText;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter Token Memo",
            ),
            onChanged: (newText) {
              creator.daoName.value = newText;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter Token Decimal",
            ),
            onChanged: (newText) {
              creator.daoName.value = newText;
            },
          ),
          Row(children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Enter Treasury Account",
                  ),
                  onChanged: (newText) {
                    creator.daoName.value = newText;
                  },
                )),
            ElevatedButton(
                onPressed: () async {
                  await Get.defaultDialog(
                      onCancel: () => Get.back(),
                      content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Column(children: [
                            TextField(
                                decoration: const InputDecoration(
                                  hintText:
                                      'enter number of signatories to account',
                                ),
                                onChanged: (x) {
                                  creator.changeTotalAcc(int.parse(x));
                                }),
                            TextField(
                              decoration: const InputDecoration(
                                hintText:
                                    'enter minimum required to approve transaction',
                              ),
                              onChanged: (x) =>
                                  creator.minimumrequired.value = int.parse(x),
                            ),
                            Obx(() {
                              int count = creator.signatoriesAmount.value;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: count,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: TextField(
                                            onChanged: ((value) => creator
                                                .setSigneePubKey(value, index)),
                                            decoration: const InputDecoration(
                                                hintText:
                                                    'Enter public key of signee'),
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              await Get.defaultDialog(
                                                  content: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.6,
                                                child: Center(
                                                    child: Row(children: [
                                                  SizedBox(
                                                    width: 150,
                                                    child: TextField(
                                                      onChanged: (enteredEmail) =>
                                                          creator
                                                              .setSigneeEmail(
                                                                  enteredEmail,
                                                                  index),
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Enter Email'),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await creator
                                                            .sendEmail(index);
                                                      },
                                                      child: const Text(
                                                          "Send Email")),
                                                ])),
                                              ));
                                            },
                                            child: Text(
                                                "or send email to ask them to create a pub key")),
                                        Obx(() {
                                          switch (
                                              creator.allSigneesStatus[index]) {
                                            case EmailSendingStatus.none:
                                              return const Icon(
                                                  Icons.delivery_dining_sharp);
                                            case EmailSendingStatus.sending:
                                              return const Icon(Icons.refresh);
                                            case EmailSendingStatus.sent:
                                              return const Icon(Icons.check);
                                            case EmailSendingStatus.verified:
                                              return const Icon(Icons.done);
                                            default:
                                              return const Text('oo');
                                          }
                                        }),
                                      ],
                                    );
                                  });
                            }),
                          ])));
                },
                child: const Text('Create new MultiSig Treasury Account'))
          ])
        ],
      ),
    );
  }
}
