import 'dart:convert';

class Account {
  String accountID;
  String privateKey;
  String publicKey;
  Account({
    required this.accountID,
    required this.privateKey,
    required this.publicKey,
  });

  Account copyWith({
    String? accountID,
    String? privateKey,
    String? publicKey,
  }) {
    return Account(
      accountID: accountID ?? this.accountID,
      privateKey: privateKey ?? this.privateKey,
      publicKey: publicKey ?? this.publicKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accountID': accountID,
      'privateKey': privateKey,
      'publicKey': publicKey,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      accountID: map['accountID'] ?? '',
      privateKey: map['privateKey'] ?? '',
      publicKey: map['publicKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  @override
  String toString() =>
      'Account(accountID: $accountID, privateKey: $privateKey, publicKey: $publicKey)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.accountID == accountID &&
        other.privateKey == privateKey &&
        other.publicKey == publicKey;
  }

  @override
  int get hashCode =>
      accountID.hashCode ^ privateKey.hashCode ^ publicKey.hashCode;
}
