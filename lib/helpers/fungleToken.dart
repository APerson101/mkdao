 import 'package:mkdao/helpers/backendhelper.dart';

Future<bool> verifyKey( String enteredText)async{
   return await BackendHelper().vefifyKey(enteredText);
}

Future<bool>  verifyAccount(String enteredText)async {
  return await BackendHelper().verifyAccount(enteredText);
}

 CreateDAOToken(
  dao: DAO, client: Client, treasuryPrivateKey: PrivateKey): Promise<TokenId> {
  const newTokenTransaction = await new TokenCreateTransaction()
    .setDecimals(dao.tokenDetails.deciaml)
    .setInitialSupply(dao.tokenDetails.initialSupply)
    .setAdminKey(dao.tokenDetails.adminKey)
    .setFreezeKey(dao.tokenDetails.freezeKey)
    .setMaxSupply(dao.tokenDetails.maxSupply)
    .setTreasuryAccountId(dao.tokenDetails.treasuryAccountId)
    .setTokenName(dao.tokenDetails.name)
    .setTokenSymbol(dao.tokenDetails.tokenSymbol)
    .setSupplyKey(dao.tokenDetails.supplyKey)
    .setKycKey(dao.tokenDetails.kycKey)
    .setTokenMemo(dao.tokenDetails.TokenMemo)
    .setWipeKey(dao.tokenDetails.wipeKey)
    .freezeWith(client)
    .sign(treasuryPrivateKey)
  const executed = await newTokenTransaction.execute(client);
  const new_created_token_id = (await executed.getReceipt(client)).tokenId;
  return new_created_token_id;
}

export type NewAccountDetails = { privateKey: PrivateKey, publicKey: PublicKey, accountID: AccountId }
async function CreateTreasuryAccount(
  threshhold: number, client: Client,
  keys_to_accounts: PublicKey[]
) {
  var thresholdkey = new KeyList(keys_to_accounts, threshhold);
  const newprivateKey = await PrivateKey.generateECDSAAsync();
  const newpublicKey = newprivateKey.publicKey;
  const newAccount = await new AccountCreateTransaction()
    .setKey(thresholdkey)
    .setInitialBalance(new Hbar(2))
    .execute(client);
  const getReceipt = await newAccount.getReceipt(client);
  const newAccountId = getReceipt.accountId;
  return { privateKey: newprivateKey, publicKey: newpublicKey, accountID: newAccountId }

  // ask for number of required signatories.

  //enter all 3 or create by sending link to their email,
  // which they then open to create an account.
  // It's basically and account creating page
}
export async function CreateAccount(client: Client): Promise<NewAccountDetails> {
  // var priKeys: PrivateKey[] = new Array(3);
  // var pubkeys: PublicKey[] = new Array(3);
  // for (let index = 0; index < 3; index++) {
  const pk = PrivateKey.generate();
  // priKeys[index] = pk;
  // pubkeys[index] = pk.publicKey;
  const pub_key = pk.publicKey;
  const newly_created_account = (await (await new AccountCreateTransaction()
    .setInitialBalance(new Hbar(2))
    .execute(client)).getReceipt(client)).accountId;
  return { privateKey: pk, publicKey: pub_key, accountID: newly_created_account };
  // console.log(`private key: ${pk.toStringRaw()}, public key : ${pk.publicKey.toStringRaw()}`);
}

class DAO {
  //name should me maximum of 100 characters
  name: string;
  description: string;
  tokenDetails: TokenDetails;
  constructor(name: string, description: string, tokenDetails: TokenDetails) {
    this.description = description;
    this.name = name;
    this.tokenDetails = tokenDetails;
  }

}

class TokenDetails {
  String name;
  String tokenSymbol;
  int decimal;
  int initialSupply;
  String adminKey;
  String freezeKey;
  String treasuryAccountId;
  bool infiniteSuply;
  int maxSupply;
  String supplyKey;
  String pauseKey;
  String kycKey;
  String TokenMemo;
  String wipeKey;
 
}

enum CustomeFees { FIXED, FRACIONAL, ROYALTY }