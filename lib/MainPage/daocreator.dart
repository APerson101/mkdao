import 'package:get/state_manager.dart';

enum EmailSendingStatus { none, sending, sent, verified }

class DAOCreator extends GetxController {
  RxString daoName = ''.obs;
  RxString description = ''.obs;
  RxString tokenName = ''.obs;
  RxString treasuryAccount = ''.obs;
  RxString tokenSymbol = ''.obs;
  RxInt tokenDecimal = 2.obs;
  RxString tokenMemo = ''.obs;
  RxInt initialSupply = 1000000.obs;
  RxInt signatoriesAmount = 1.obs;

  RxInt minimumrequired = 1.obs;
  RxList<EmailSendingStatus> allSigneesStatus =
      List.filled(1, EmailSendingStatus.none, growable: true).obs;
  RxList<String> allSigneesPubKey = List.filled(1, '', growable: true).obs;
  RxList<String> allSigneesEmail = List.filled(1, '', growable: true).obs;

  setSigneePubKey(String value, int index) {
    allSigneesPubKey[index] = value;
  }

  setSigneeEmail(String enteredEmail, int index) {
    allSigneesEmail[index] = enteredEmail;
  }

  sendEmail(int index) {
    //do stuffs
    allSigneesStatus[index] = EmailSendingStatus.sending;
  }

  changeTotalAcc(int newNumber) {
    if (newNumber < 1) return;
    allSigneesEmail = List.filled(newNumber, '', growable: true).obs;
    allSigneesPubKey = List.filled(newNumber, '', growable: true).obs;
    allSigneesStatus =
        List.filled(newNumber, EmailSendingStatus.none, growable: true).obs;
    signatoriesAmount.value = newNumber;
  }
}
