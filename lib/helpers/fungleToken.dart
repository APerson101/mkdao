import 'dart:convert';

class DAO {
  //name should me maximum of 100 characters
  String name;
  String description;
  TokenDetails tokenDetails;
  DAO(this.name, this.description, this.tokenDetails);
}

class TokenDetails {
  String name;
  String tokenSymbol;
  int decimal;
  int initialSupply;
  String? adminKey;
  String? freezeKey;
  String treasuryAccountId;
  bool? infiniteSuply;
  int? maxSupply;
  String? supplyKey;
  String? pauseKey;
  String? kycKey;
  String? tokenMemo;
  String? wipeKey;
  TokenDetails({
    required this.name,
    required this.tokenSymbol,
    required this.decimal,
    required this.initialSupply,
    required this.treasuryAccountId,
    this.tokenMemo,
    this.adminKey,
    this.freezeKey,
    this.infiniteSuply,
    this.maxSupply,
    this.supplyKey,
    this.pauseKey,
    this.kycKey,
    this.wipeKey,
  });

  TokenDetails copyWith({
    String? name,
    String? tokenSymbol,
    int? decimal,
    int? initialSupply,
    String? adminKey,
    String? freezeKey,
    String? treasuryAccountId,
    bool? infiniteSuply,
    int? maxSupply,
    String? supplyKey,
    String? pauseKey,
    String? kycKey,
    String? tokenMemo,
    String? wipeKey,
  }) {
    return TokenDetails(
      name: name ?? this.name,
      tokenSymbol: tokenSymbol ?? this.tokenSymbol,
      decimal: decimal ?? this.decimal,
      initialSupply: initialSupply ?? this.initialSupply,
      adminKey: adminKey ?? this.adminKey,
      freezeKey: freezeKey ?? this.freezeKey,
      treasuryAccountId: treasuryAccountId ?? this.treasuryAccountId,
      infiniteSuply: infiniteSuply ?? this.infiniteSuply,
      maxSupply: maxSupply ?? this.maxSupply,
      supplyKey: supplyKey ?? this.supplyKey,
      pauseKey: pauseKey ?? this.pauseKey,
      kycKey: kycKey ?? this.kycKey,
      tokenMemo: tokenMemo ?? this.tokenMemo,
      wipeKey: wipeKey ?? this.wipeKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tokenSymbol': tokenSymbol,
      'deciaml': decimal,
      'initialSupply': initialSupply,
      'adminKey': adminKey?.isEmpty ?? treasuryAccountId,
      'freezeKey': freezeKey?.isEmpty ?? treasuryAccountId,
      'treasuryAccountId': treasuryAccountId,
      'infiniteSuply': infiniteSuply,
      'maxSupply': maxSupply,
      'supplyKey': supplyKey?.isEmpty ?? treasuryAccountId,
      'pauseKey': pauseKey?.isEmpty ?? treasuryAccountId,
      'kycKey': kycKey?.isEmpty ?? treasuryAccountId,
      'tokenMemo': tokenMemo,
      'wipeKey': wipeKey?.isEmpty ?? treasuryAccountId,
    };
  }

  factory TokenDetails.fromMap(Map<String, dynamic> map) {
    return TokenDetails(
      name: map['name'] ?? '',
      tokenSymbol: map['tokenSymbol'] ?? '',
      decimal: map['decimal']?.toInt() ?? 0,
      initialSupply: map['initialSupply']?.toInt() ?? 0,
      adminKey: map['adminKey'],
      freezeKey: map['freezeKey'],
      treasuryAccountId: map['treasuryAccountId'] ?? '',
      infiniteSuply: map['infiniteSuply'],
      maxSupply: map['maxSupply']?.toInt(),
      supplyKey: map['supplyKey'],
      pauseKey: map['pauseKey'],
      kycKey: map['kycKey'],
      tokenMemo: map['tokenMemo'],
      wipeKey: map['wipeKey'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenDetails.fromJson(String source) =>
      TokenDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TokenDetails(name: $name, tokenSymbol: $tokenSymbol, decimal: $decimal, initialSupply: $initialSupply, adminKey: $adminKey, freezeKey: $freezeKey, treasuryAccountId: $treasuryAccountId, infiniteSuply: $infiniteSuply, maxSupply: $maxSupply, supplyKey: $supplyKey, pauseKey: $pauseKey, kycKey: $kycKey, tokenMemo: $tokenMemo, wipeKey: $wipeKey)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TokenDetails &&
        other.name == name &&
        other.tokenSymbol == tokenSymbol &&
        other.decimal == decimal &&
        other.initialSupply == initialSupply &&
        other.adminKey == adminKey &&
        other.freezeKey == freezeKey &&
        other.treasuryAccountId == treasuryAccountId &&
        other.infiniteSuply == infiniteSuply &&
        other.maxSupply == maxSupply &&
        other.supplyKey == supplyKey &&
        other.pauseKey == pauseKey &&
        other.kycKey == kycKey &&
        other.tokenMemo == tokenMemo &&
        other.wipeKey == wipeKey;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        tokenSymbol.hashCode ^
        decimal.hashCode ^
        initialSupply.hashCode ^
        adminKey.hashCode ^
        freezeKey.hashCode ^
        treasuryAccountId.hashCode ^
        infiniteSuply.hashCode ^
        maxSupply.hashCode ^
        supplyKey.hashCode ^
        pauseKey.hashCode ^
        kycKey.hashCode ^
        tokenMemo.hashCode ^
        wipeKey.hashCode;
  }
}
