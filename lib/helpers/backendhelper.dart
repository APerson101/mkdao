import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:mkdao/helpers/activeAccont.dart';
import 'package:mkdao/helpers/emailer.dart';
import 'fungleToken.dart';

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
    account = Account.fromJson(newAccount.data);
    return account!;
  }

  createDAO() async {
    HttpsCallableResult newDAO =
        await instance.httpsCallable('createDAO').call();
    print(newDAO.data);
    // activeDAO = Account.fromJson(newDAO.data);
    return activeDAO!;
  }

//   sendEmail(String email) async {
// // embed the secret code in the url and save it;

//     HttpsCallableResult status = await instance
//         .httpsCallable('sendMail')
//         .call({'email': 'abdulhadih48@gmail.com'});
//     print(status.data);
//     return status.data;
//   }

//   storeToBase(String daoName, int number_of_people, List<String> emails) async
//   {
//     await firestore.doc("DAOCODES/$daoName").set({'emails':emails});
//   var collection= firestore.collection('DAOCODES').snapshots();
//   collection.listen((event) {
//     // something
//     var changes=event.docChanges;
//     var emails__=changes.elementAt(0);
//     var emails_=emails__.doc.get('emails');
//     if(emails.contains(emails_)!=false)
//     {
//       //user done;
//       mark as done
//     }

//   })
// }

  // }
}

//  firebase emulators:start --only firestore
