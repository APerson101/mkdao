import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:mkdao/helpers/activeAccont.dart';
import 'fungleToken.dart';
import 'package:uuid/uuid.dart';

class BackendHelper {
  FirebaseFunctions instance = FirebaseFunctions.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Account? account;
  DAO? activeDAO;
  Future<Account> createAccount({List<String>? publickey}) async {
    HttpsCallableResult newAccount = await instance
        .httpsCallable('createAccount')
        .call({'publickey': publickey});

    print(newAccount.data);
    account = Account.fromMap(newAccount.data);
    return account!;
  }

  createDAO({DAO? dao}) async {
    await Future.delayed(const Duration(seconds: 3), () => {true});
    return true;
    var publickey =
        '302a300506032b65700321007e9921707f9e7b8c6d256878233e9967670fc2e4111b9cf849bfd8d1d301527f';
    HttpsCallableResult newDAO =
        //     await instance.httpsCallable('createDAO').call({
        //   'daoDetails': {
        //     'pe_key': account!.privateKey,
        //     'tokenDetails': dao.tokenDetails.toMap()
        //   },
        // });

        await instance.httpsCallable('createDAO').call({
      'daoDetails': {
        'pe_key':
            '302e020100300506032b657004220420be6a4b6614ede100b515bdca60dee882849a353f184a964cee23839181d9865f',
        'tokenDetails': {
          'name': 'tokenName231',
          'tokenSymbol': 'fde',
          'deciaml': 2,
          'initialSupply': 10000000,
          'adminKey': publickey,
          'freezeKey': publickey,
          'treasuryAccountId': '0.0.34402326',
          'infiniteSuply': false,
          'supplyKey': publickey,
          'pauseKey': publickey,
          'kycKey': publickey,
          'tokenMemo': 'tokenMemo',
          'wipeKey': publickey,
        }
      }
    });

    print(newDAO.data);
    // return activeDAO!;
  }

  generateInvoice(String payer, String amount) async {
    await instance.httpsCallable('generateInvoice').call({
      'amount': amount,
      'payer': payer,
    });
  }

  sendEmail(List<String> emails) async {
    var uuid = const Uuid();
    String id = uuid.v4();
    print(emails);
    await instance
        .httpsCallable('sendSignUpEmails')
        .call({'emails': emails, 'daoName': 'testName', 'id': id});
    var house;
    firestore.collection('MultiSig/$id/accounts').snapshots().listen((event) {
      event.docChanges.forEach((element) {
        house = {
          'email': element.doc.get('email'),
          'publicKey': element.doc.get('publicKey')
        };
      });
    });
    return house;
  }

  Future<bool> submitEmailCredentials(
      Account newAccount, String id, String email) async {
    //submit to firebase
    var val = await instance.httpsCallable('submitNewAccount').call({
      'email': email,
      'publicKey': newAccount.publicKey,
      'accountID': newAccount.accountID,
      'id': id
    });
    return val.data;
  }
}
