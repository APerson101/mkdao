import {
  AccountId,
  Client,
  PrivateKey,
  PublicKey,
  ScheduleCreateTransaction,
  ScheduleSignTransaction,
  TokenCreateTransaction,
  Transaction
} from "@hashgraph/sdk";
export async function createToken(data: any, client: Client) {
  var dao = data.daoDetails;
  // var tpk = PrivateKey.fromString(dao.pe_key);
  const newTokenTransaction = new TokenCreateTransaction()
    .setDecimals(dao.tokenDetails.deciaml)
    .setInitialSupply(dao.tokenDetails.initialSupply)
    .setAdminKey(PublicKey.fromString(dao.tokenDetails.adminKey || ''))
    .setFreezeKey(PublicKey.fromString(dao.tokenDetails.freezeKey || ''))
    .setMaxSupply(dao.tokenDetails.maxSupply)
    .setTreasuryAccountId(AccountId.fromString(dao.tokenDetails.treasuryAccountId))
    .setTokenName(dao.tokenDetails.name)
    .setTokenSymbol(dao.tokenDetails.tokenSymbol)
    .setSupplyKey(PublicKey.fromString(dao.tokenDetails.supplyKey || ''))
    .setKycKey(PublicKey.fromString(dao.tokenDetails.kycKey || ''))
    .setTokenMemo(dao.tokenDetails.tokenMemo)
    .setWipeKey(PublicKey.fromString(dao.tokenDetails.wipeKey || ''))
    .setNodeAccountIds([new AccountId(3)])
  const schedultedId = await scheduleTransaction(newTokenTransaction, client);
  await signTransaction(schedultedId!.toString(), client, dao.pe_key);
  // .freezeWith(client)
  // .sign(tpk)

  // const executed = await newTokenTransaction.execute(client);
  // const new_created_token_id = (await executed.getReceipt(client)).tokenId;
  // generate and subscribe to topic 
  // console.log(`NEW CREATED TOKEN ID: ${new_created_token_id}`)
  // return new_created_token_id;
}


// Send email for users to sign transaction
async function scheduleTransaction(txn: Transaction, client: Client) {
  const scheduledtxn = new ScheduleCreateTransaction()
    .setScheduledTransaction(txn);
  const scheduledTxnId = (await (await scheduledtxn.execute(client)).getReceipt(client)).scheduleId;
  console.log(`new scheduled txn created with id: ${scheduledTxnId}`);
  return scheduledTxnId;
}

export async function signTransaction(scheduleId: string, client: Client, userPrivateKey: string) {
  try {
    const signed = new ScheduleSignTransaction().setScheduleId(scheduleId)
      .freezeWith(client)
      .sign(PrivateKey.fromString(userPrivateKey));
    console.log(`Signed a scheduled txn with status: ${(await (await (await signed).execute(client)).getReceipt(client)).status}`);
  } catch (error) {
    console.log("OMO THIS IS THE ERORR OHH!!");
    console.log(error)
  }
}