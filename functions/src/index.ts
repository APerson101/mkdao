import { AccountId, Client, PrivateKey, PublicKey, TokenCreateTransaction, TopicId } from "@hashgraph/sdk";
import * as functions from "firebase-functions";
import { createnewAccount } from "./createaccount";
import { createInvoice, createTopic, subscribeToTopic } from "./generateInvoice";
import { deployInvoiceContract } from "./invoicecontract";
// import { carryOutArrayOfTransactions, deployContract } from "./maketxns";
// import { sendEmail } from "./mailingservice";


export const createAccount = functions.https.onCall(async (data) => {
  var pk = data.publickey;
  var min = data.min_required;

  return await createnewAccount(pk, min);
});
// export const sendMail = functions.https.onCall(async (variables) => {
//   console.log("what is the issue hrer");
//   var receivers = variables.receivers;
//   var number_of_people = variables.number_of_people;
//   var daoname = variables.daoName;

//   return await sendEmail(receivers, daoname, number_of_people);
// });

export const generateInvoice = functions.https.onCall(async (dets) => {
  const topicID = dets.topicid;
  const msgid = dets.msgid;
  await createInvoice(TopicId.fromString(topicID), msgid);
});

export const createDAO = functions.https.onCall(async (data) => {
  console.log("creating DAO");
  const myAccountIdString = '0.0.34362732';
  const myPrivateKeyString = '302e020100300506032b6570042204208bb7577d581fdb869c4f83e92e6ab5d20b8dc3f9c2f8e94e461a0bf758a766cc';
  const my_AccountID = AccountId.fromString(myAccountIdString || '');
  const my_privatekey = PrivateKey.fromString(myPrivateKeyString || '');
  const client = Client.forTestnet();
  client.setOperator(my_AccountID, my_privatekey);
  // var dao: DAO = DAO.fromMap(JSON.parse(data.dao));
  // var daopK = data.dao_private_key;

  var dao = data.daoDetails;
  var tpk = PrivateKey.fromString(dao.pe_key);
  // const newTokenTransaction = await new TokenCreateTransaction()
  //   .setDecimals(dao.tokenDetails.deciaml)
  //   .setInitialSupply(dao.tokenDetails.initialSupply)
  //   .setAdminKey(PublicKey.fromString(dao.tokenDetails.adminKey || ''))
  //   .setFreezeKey(PublicKey.fromString(dao.tokenDetails.freezeKey || ''))
  //   .setMaxSupply(dao.tokenDetails.maxSupply)
  //   .setTreasuryAccountId(AccountId.fromString(dao.tokenDetails.treasuryAccountId))
  //   .setTokenName(dao.tokenDetails.name)
  //   .setTokenSymbol(dao.tokenDetails.tokenSymbol)
  //   .setSupplyKey(PublicKey.fromString(dao.tokenDetails.supplyKey || ''))
  //   .setKycKey(PublicKey.fromString(dao.tokenDetails.kycKey || ''))
  //   .setTokenMemo(dao.tokenDetails.tokenMemo)
  //   .setWipeKey(PublicKey.fromString(dao.tokenDetails.wipeKey || ''))
  //   .freezeWith(client)
  //   .sign(my_privatekey)
  console.log(`treasury is ${dao.tokenDetails.treasuryAccountId}`);
  const newTokenTransaction = await new TokenCreateTransaction()
    .setDecimals(2)
    .setInitialSupply(10000)
    .setTreasuryAccountId(AccountId.fromString(dao.tokenDetails.treasuryAccountId))
    .setTokenName('sfdf')
    .setTokenSymbol('sdfsfew')
    .freezeWith(client)
    .sign(my_privatekey)

  const executed = await newTokenTransaction.execute(client);
  const new_created_token_id = (await executed.getReceipt(client)).tokenId;
  // generate and subscribe to topic 
  console.log(`NEW CREATED TOKEN ID: ${new_created_token_id}`)
  const topicId = await createTopic();
  //
  await new Promise((resolve) => setTimeout(resolve, 5000));
  const contractID = await deployInvoiceContract(client);
  await subscribeToTopic(topicId, tpk, AccountId.fromString(dao.tokenDetails.treasuryAccountId), contractID);
  // const txnsContract = await deployContract();
  return {
    tokenID: new_created_token_id?.toString(),
    topicID: topicId.toString(),
    // transactionsContract: `0.0.${txnsContract.shard.toString()}`,
    invoiceContractID: `0.0.${contractID.shard.toString()}`
  };
});

export const makeTransaction = functions.https.onCall(async (data) => {
  //
  var receiversAddresses: string[] = data.receivers;
  var sender: string = data.sender;
  var receiverIDS: AccountId[] = [];
  for (let index = 0; index < receiversAddresses.length; index++) {
    const element = receiversAddresses[index];
    receiverIDS.push(AccountId.fromString(element));
  }
  var senderAddress = AccountId.fromString(sender);
  //
  // await carryOutArrayOfTransactions(senderAddress, receiverIDS);

});