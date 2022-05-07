import 'package:get/get.dart';

class NewPaymentController extends GetxController {
  RxString gas = ''.obs;

  RxString amount = ''.obs;

  RxString receiver = ''.obs;

  void makePayment() {
    //
    double gasFee = double.parse(gas.value);
    double amountHbar = double.parse(amount.value);
  }
}
