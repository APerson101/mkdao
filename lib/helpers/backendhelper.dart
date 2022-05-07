import 'package:cloud_functions/cloud_functions.dart';
import 'package:mkdao/helpers/activeAccont.dart';

class BackendHelper {
  FirebaseFunctions instance = FirebaseFunctions.instance;
  Account? account;
  Future<Account> createAccount() async {
    HttpsCallableResult newAccount =
        await instance.httpsCallable('createaccount').call();
    print(newAccount.data);
    account = Account.fromJson(newAccount.data);
    return account!;
  }
}
