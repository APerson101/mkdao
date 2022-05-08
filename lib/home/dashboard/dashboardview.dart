import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/home/dashboard/invoiceview/makeInvoiceview.dart';
import 'package:mkdao/home/dashboard/paymentview/newPaymentView.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height / 2,
          left: 10,
          right: 0,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              child: GestureDetector(
                  onTap: () async {
                    await Get.defaultDialog(
                        title: 'New Invoice',
                        content: MakeInvoiceView(),
                        onCancel: () => Get.back());
                  },
                  child: Center(
                    child: Text(
                      'New Invoice',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  )),
            ),
          ),

          //   ElevatedButton(
          //       onPressed: () async {
          //         await Get.defaultDialog(
          //             title: 'New Invoice',
          //             content: MakeInvoiceView(),
          //             onCancel: () => Get.back());
          //       },
          //       child: const Text("Generate invoice")),
          //   ElevatedButton(
          //       onPressed: () async {
          //         await Get.defaultDialog(content: NewPaymentView());
          //       },
          //       child: const Text("Make Payment")),
          // ],
          // )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 4,
          left: 10,
          right: 0,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              child: GestureDetector(
                  onTap: () async {
                    await Get.defaultDialog(content: NewPaymentView());
                  },
                  child: Center(
                    child: Text(
                      'Make Payment',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  )),
            ),
          ),
        ),
        Positioned(
            left: 10,
            right: 10,
            child: Center(
              child: Text("Hbar Balance:  20",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            )),
      ],
    );
  }
}
