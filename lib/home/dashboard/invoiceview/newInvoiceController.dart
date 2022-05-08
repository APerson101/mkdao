import 'package:get/get.dart';
import 'package:mkdao/helpers/backendhelper.dart';

class MakeInvoiceController extends GetxController {
  RxString payer = ''.obs;
  RxString amount = ''.obs;

  sendInvoice() async {
    //

    String invoiceId =
        await BackendHelper().generateInvoice(payer.value, amount.value);
    print(invoiceId);
  }
}
