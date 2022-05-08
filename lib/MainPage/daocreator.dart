import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mkdao/helpers/backendhelper.dart';

import '../helpers/fungleToken.dart';

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
  RxString freezeKey = ''.obs;
  RxBool infiniteSuply = false.obs;
  RxInt maxSupply = 100000000.obs;
  RxString adminKey = ''.obs;
  RxString supplyKey = ''.obs;
  RxString pauseKey = ''.obs;
  RxString kycKey = ''.obs;
  RxString wipeKey = ''.obs;
  RxString customeFees = ''.obs;

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

  sendEmail(int index) async {
    //do stuffs
    allSigneesStatus[index] = EmailSendingStatus.sending;
    // await BackendHelper().sendEmail(allSigneesEmail[index]);
    allSigneesStatus[index] = EmailSendingStatus.sent;
  }

  changeTotalAcc(int newNumber) {
    if (newNumber < 1) return;
    allSigneesEmail = List.filled(newNumber, '', growable: true).obs;
    allSigneesPubKey = List.filled(newNumber, '', growable: true).obs;
    allSigneesStatus =
        List.filled(newNumber, EmailSendingStatus.none, growable: true).obs;
    signatoriesAmount.value = newNumber;
  }

  createDAO() async {
    // CREATE FUNGIBLE TOKEN
    var token = TokenDetails(
        decimal: tokenDecimal.value,
        initialSupply: initialSupply.value,
        name: tokenName.value,
        tokenSymbol: tokenSymbol.value,
        tokenMemo: tokenMemo.value,
        adminKey: adminKey.value,
        freezeKey: freezeKey.value,
        infiniteSuply: infiniteSuply.value,
        maxSupply: maxSupply.value,
        supplyKey: supplyKey.value,
        pauseKey: pauseKey.value,
        kycKey: kycKey.value,
        wipeKey: wipeKey.value,
        treasuryAccountId: treasuryAccount.value);

    var dao = DAO(daoName.value, description.value, token);

    bool status = await BackendHelper().createDAO(dao: dao);
    return status;
  }

  createTreasury() async {
    await BackendHelper().createAccount(publickey: allSigneesPubKey);
  }
}
