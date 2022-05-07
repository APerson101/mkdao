import { AccountId, PrivateKey, Client, AccountCreateTransaction, Hbar, PublicKey, KeyList } from "@hashgraph/sdk";

/* eslint-disable*/
const myAccountIdString = '0.0.34362732';
const myPrivateKeyString = '302e020100300506032b6570042204208bb7577d581fdb869c4f83e92e6ab5d20b8dc3f9c2f8e94e461a0bf758a766cc';
const my_AccountID = AccountId.fromString(myAccountIdString || '');
const my_privatekey = PrivateKey.fromString(myPrivateKeyString || '');
const client = Client.forTestnet();
client.setOperator(my_AccountID, my_privatekey);
export async function createnewAccount(pubKeys: (string)[], min_requied: number): Promise<{}> {
  if (pubKeys !== null) {
    const pk = PrivateKey.generate();
    var pkl: (PublicKey)[] = [];
    pubKeys.forEach(key => {
      pkl.push(PublicKey.fromString(key));
    });
    var kl = new KeyList(pkl, min_requied);
    const newly_created_account = (await (await new AccountCreateTransaction()
      .setInitialBalance(new Hbar(2))
      .setKey(kl)
      .execute(client)).getReceipt(client)).accountId;
    console.log(`DAO ACCOUNT CREATED WITH ID: ${newly_created_account!.toString()}`);
    return { privateKey: pk.toStringRaw(), publicKey: pk.publicKey, accountID: newly_created_account!.toString() };
  }
  const pk = PrivateKey.generate();
  const pub_key = pk.publicKey;
  const newly_created_account = (await (await new AccountCreateTransaction()
    .setInitialBalance(new Hbar(2))
    .setKey(pub_key)
    .execute(client)).getReceipt(client)).accountId;
  console.log(`private key: ${pk.toStringRaw()}, public key : ${pk.publicKey.toStringRaw()}`);
  return { privateKey: pk.toStringRaw(), publicKey: pub_key.toStringRaw(), accountID: newly_created_account!.toString() };
}