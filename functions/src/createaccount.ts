/* eslint-disable*/
import { Client, PrivateKey, AccountCreateTransaction, Hbar, AccountId } from "@hashgraph/sdk";
import * as dotenv from "dotenv";
dotenv.config();
const myAccountIdString = process.env.MY_ACCOUNT_ID;
const myPrivateKeyString = process.env.MY_PRIVATE_KEY;
const my_AccountID = AccountId.fromString(myAccountIdString || '');
const my_privatekey = PrivateKey.fromString(myPrivateKeyString || '');
const client = Client.forTestnet();
client.setOperator(my_AccountID, my_privatekey);

export async function createAccount(): Promise<{}> {
  const pk = PrivateKey.generate();
  const pub_key = pk.publicKey;
  const newly_created_account = (await (await new AccountCreateTransaction()
    .setInitialBalance(new Hbar(2))
    .setKey(pub_key)
    .execute(client)).getReceipt(client)).accountId;
  console.log(`private key: ${pk.toStringRaw()}, public key : ${pk.publicKey.toStringRaw()}`);
  return { privateKey: pk.toStringRaw(), publicKey: pub_key.toStringRaw(), accountID: newly_created_account!.toString() };
}