import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/home/dashboard/paymentview/newpaymentcontroller.dart';

class NewPaymentView extends StatelessWidget {
  NewPaymentView({Key? key}) : super(key: key);
  NewPaymentController controller = Get.put(NewPaymentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          TextField(
            onChanged: (receiver) => controller.receiver.value = receiver,
            decoration: const InputDecoration(
              hintText: 'enter receiver',
            ),
          ),
          TextField(
            onChanged: (amount) => controller.amount.value = amount,
            decoration: const InputDecoration(
              hintText: 'enter amount',
            ),
          ),
          TextField(
            onChanged: (gas) => controller.gas.value = gas,
            decoration: const InputDecoration(
              hintText: 'set gas',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                controller.makePayment();
              },
              child: const Text('Confirm'))
        ],
      )),
    );
  }
}
