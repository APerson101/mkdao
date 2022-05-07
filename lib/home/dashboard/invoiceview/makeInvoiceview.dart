import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/home/dashboard/invoiceview/newInvoiceController.dart';

class MakeInvoiceView extends StatelessWidget {
  MakeInvoiceView({Key? key}) : super(key: key);
  MakeInvoiceController controller = Get.put(MakeInvoiceController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter payer address',
              ),
              onChanged: (add) => controller.payer.value = add,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Amount',
              ),
              onChanged: (add) => controller.amount.value = add,
            ),
            ElevatedButton(
                onPressed: () {
                  controller.sendInvoice();
                },
                child: Text('Send Invoice'))
          ],
        ),
      ),
    );
  }
}
