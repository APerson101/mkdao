import 'package:flutter/material.dart';
import 'dart:html';

import 'package:get/get.dart';
import 'package:mkdao/helpers/activeAccont.dart';
import 'package:mkdao/notificationstester.dart';

import 'helpers/backendhelper.dart';

class EmailSignUpView extends StatelessWidget {
  EmailSignUpView({Key? key}) : super(key: key);
  final BackendHelper _handler = Get.put(BackendHelper());

  @override
  Widget build(BuildContext context) {
    var uri = Uri.dataFromString(window.location.href);
    var qp = uri.queryParameters;
    RxString name = ''.obs;
    RxString type = ''.obs;
    RxString id = ''.obs;
    RxString email = ''.obs;
    name.value = qp['daoName'] ?? 'ERROR';
    type.value = qp['type'] ?? 'ERROR';
    id.value = qp['id'] ?? 'ERROR';
    email.value = qp['email'] ?? 'ERROR';
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                  "You are part of the treasury to the dao called: ${name.value}"),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Account newAccount = await _handler.createAccount();
                  await _handler.submitEmailCredentials(
                      newAccount, id.value, email.value);
                  {
                    print('registered successfully, you can close page');
                  }
                },
                child: const Text("Create account and submit"),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    //
                  },
                  child: const Text("Already have an account")),
            ),
          ],
        ),
      ),
    );
  }
}
// http://localhost:53978/#/EmailSignUp/?daoName=abba&type=email
// send in the dao name being created