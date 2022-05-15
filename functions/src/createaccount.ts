import { AccountId, PrivateKey, Client, AccountCreateTransaction, Hbar, PublicKey, KeyList } from "@hashgraph/sdk";

/* eslint-disable*/
const myAccountIdString = '0.0.34362732';
const myPrivateKeyString = '302e020100300506032b6570042204208bb7577d581fdb869c4f83e92e6ab5d20b8dc3f9c2f8e94e461a0bf758a766cc';
const my_AccountID = AccountId.fromString(myAccountIdString || '');
const my_privatekey = PrivateKey.fromString(myPrivateKeyString || '');
const client = Client.forTestnet();
client.setOperator(my_AccountID, my_privatekey);

// can create account for individual and Multisig
export async function createnewAccount(): Promise<{}> {
  const pk = PrivateKey.generate();
  const pub_key = pk.publicKey;
  const newly_created_account = (await (await new AccountCreateTransaction()
    .setInitialBalance(new Hbar(20))
    .setKey(pub_key)
    .execute(client)).getReceipt(client)).accountId;
  console.log(`private key: ${pk.toStringRaw()}, public key : ${pk.publicKey.toStringRaw()}`);
  return { privateKey: pk.toStringRaw(), publicKey: pub_key.toStringRaw(), accountID: newly_created_account!.toString() };
}

export async function createMutlisigAccount(pubKeys: (string)[], min_requied: number) {
  //
  var publicKeyList: (PublicKey)[] = [];
  pubKeys.forEach(key => {
    publicKeyList.push(PublicKey.fromString(key));
  });
  var keylist = new KeyList(publicKeyList, min_requied);
  const newly_created_account = (await (await new AccountCreateTransaction()
    .setInitialBalance(new Hbar(2))
    .setKey(keylist)
    .execute(client)).getReceipt(client)).accountId;
  console.log(`NEW MULTISIG ACCOUNT CREATED WITH DETAILS: accountID: ${newly_created_account!.toString()}`)
  return { accountID: newly_created_account!.toString() };
}