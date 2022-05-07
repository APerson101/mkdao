import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/home/dashboard/invoiceview/makeInvoiceview.dart';
import 'package:mkdao/home/dashboard/paymentview/newPaymentView.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonBar(
        children: [
          ElevatedButton(
              onPressed: () async {
                await Get.defaultDialog(content: MakeInvoiceView());
              },
              child: const Text("Generate invoice")),
          ElevatedButton(
              onPressed: () async {
                await Get.defaultDialog(content: NewPaymentView());
              },
              child: const Text("Make Payment")),
        ],
      ),
    );
  }
}
