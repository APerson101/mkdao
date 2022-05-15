import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsTesters extends StatelessWidget {
  NotificationsTesters({Key? key}) : super(key: key);
  final handler _handler = Get.put(handler());
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('got a message while in the foreground');
      RemoteNotification? notification = event.notification;
      _handler.newInvoice.value = true;
      if (notification != null) {
        Get.snackbar(notification.title!, notification.body!);
      } else if (event.data != null) {
        var notification = event.data;
        _handler.newInvoiceId.value = event.data["invoiceID"];
        SnackBar(
          content: ListTile(
            title: notification["title"],
            subtitle: notification["body"],
          ),
        );
        Get.snackbar(notification["title"], notification["body"]);
      }
    });
    return Scaffold(body: Obx(() {
      Widget stuff = ButtonBar(
        children: [
          ElevatedButton(
              onPressed: () async {
                await _handler.ignoreInvoice();
              },
              child: const Text("ignore")),
          ElevatedButton(
              onPressed: () async {
                await _handler.acknowledgeInvoice();
              },
              child: const Text("Acknowledge")),
          ElevatedButton(
              onPressed: () async {
                await _handler.payInvoice();
              },
              child: const Text("Pay now")),
        ],
      );
      if (_handler.newInvoice.value) return stuff;
      return SingleChildScrollView(
          child: Column(children: [
        ElevatedButton(
          onPressed: () async {
            await _handler.sendInvoice();
          },
          child: const Text("Send new invoice"),
        ),
        ElevatedButton(
          onPressed: () async {
            await _handler.subscribe();
          },
          child: const Text("Subscribe to Topic"),
        ),
        ElevatedButton(
          onPressed: () async {
            await _handler.payInvoice();
          },
          child: const Text("Pay invoice"),
        )
      ]));
    }));
  }
}

class handler extends GetxController {
  FirebaseFunctions firebase = FirebaseFunctions.instance;
  //
  String? token = '';
  RxBool newInvoice = false.obs;
  RxString newInvoiceId = "".obs;
  handler() {
    test();
    FirebaseMessaging.onBackgroundMessage((message) async {
      await backhg(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('got a message while in the foreground');
      RemoteNotification notification = event.notification!;
      Get.snackbar(notification.title!, notification.body!);
    });
  }

  test() async {
    token = await FirebaseMessaging.instance.getToken(
        vapidKey:
            'BIqc1wPMB0JaZPDwEd6Kc4aTK5ulcoihALZv7jnM_a1F5jYz1o_HgTivCWLUahqzkjvkotWYLm-5CUe7e8Uyhsk');

    FirebaseMessaging.instance.onTokenRefresh.listen((newfcmToken) {
      token = newfcmToken;
    }).onError((handleError) {
      print("Failed to get token");
    });
    FirebaseMessaging _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print("USer permission status: ${settings.authorizationStatus}");
    print('fcm ${token}');
  }

  backhg(message) async {
    print(message);
  }

  subscribe() async {
    var result = await firebase.httpsCallable('sub2Topic').call({
      'token': token,
    });
    print(result.data);
  }

  sendInvoice() async {
    var result = await firebase.httpsCallable('sendMessage').call();
    print(result.data);
  }

  ignoreInvoice() async {
    var result = await firebase
        .httpsCallable('ignoreInvoice')
        .call({'invoiceId': newInvoiceId.value});
    print(result);
  }

  acknowledgeInvoice() async {
    var result = await firebase
        .httpsCallable('acknowledgeInvoice')
        .call({'invoiceId': newInvoiceId.value});
    print(result);
  }

  payInvoice() async {
    var result = await firebase
        .httpsCallable('payInvoice')
        .call({'invoiceId': '0.0.34744401@1652626954.801803457'});
    print(result);
  }
}
