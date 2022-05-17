// import { AccountId, Client, PrivateKey, TopicId, } from "@hashgraph/sdk";
import * as functions from "firebase-functions";
import { createnewAccount } from "./createaccount";
import {
  //  createInvoice, createTopic, 
  sendMessageToTopic, subscribeToTopic, payInvoicewithId,
  _acknowledgeInvoice, _ignoreInvoice
} from "./generateInvoice";
// import { deployInvoiceContract } from "./invoicecontract";
// import { createToken } from "./token";
// import { deployTransactionsContract } from "./transactions";
// import { carryOutArrayOfTransactions, deployContract } from "./maketxns";
import { sendEmail } from "./mailingservice";
import * as admin from "firebase-admin";
const serviceAccount = require("../mkdao-564b7-firebase-adminsdk-9a503-59829ead57.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://mkdao-564b7-default-rtdb.firebaseio.com"
});

export const createAccount = functions.https.onCall(async (data) => {
  return await createnewAccount();
});

// export const createMultiSigACC = functions.https.onCall(async (data) => {
//   const publicKeyList = data.keys;
//   const min_required = data.min_requied;
//   return await createMutlisigAccount(publicKeyList, min_required)
// })
export const sendSignUpEmails = functions.https.onCall(async (variables) => {
  var receivers = variables.emails;
  var daoname = variables.daoName;
  var id = variables.id;

  return await sendEmail(receivers, daoname, id);
});
export const sub2Topic = functions.https.onCall(async (data) => {
  const _token = data.token
  await subscribeToTopic(_token);
  console.log("TOKEN SUBSCRIPTION SUCCESS");
  return true;
});

export const sendMessage = functions.https.onCall(async (data) => {
  return await sendMessageToTopic();
});

export const ignoreInvoice = functions.https.onCall(async (data) => {
  const invoiceId = data.invoiceId;

  return await _ignoreInvoice(invoiceId);
});

export const acknowledgeInvoice = functions.https.onCall(async (data) => {
  const invoiceId = data.invoiceId;

  return await _acknowledgeInvoice(invoiceId);
});
export const payInvoice = functions.https.onCall(async (data) => {
  const invoiceId = data.invoiceId;
  return await payInvoicewithId(invoiceId);
});

export const submitNewAccount = functions.https.onCall(async (data) => {
  const publicKey = data.publicKey;
  const accountID = data.accountID;
  const id = data.id;
  const email = data.email;
  await admin.firestore().collection(`MultiSig/${id}/accounts`).add({
    accountId: accountID,
    publicKey: publicKey,
    email: email
  });
  return true;
});


// export const generateInvoice = functions.https.onCall(async (dets) => {
//   const topicID = dets.topicid;
//   const msgid = dets.msgid;
//   await createInvoice(TopicId.fromString(topicID), msgid);
// });

// export const createDAO = functions.https.onCall(async (data) => {
//   console.log("creating DAO");
//   // const myAccountIdString = '0.0.34362732';
//   // const myPrivateKeyString = '302e020100300506032b6570042204208bb7577d581fdb869c4f83e92e6ab5d20b8dc3f9c2f8e94e461a0bf758a766cc';
//   // const my_privatekey = PrivateKey.fromString(myPrivateKeyString || '');
//   // const my_AccountID = AccountId.fromString(myAccountIdString || '');

//   const creator_id = AccountId.fromString(data.creatorAccountID);
//   const creator_pk = PrivateKey.fromString(data.creatorPrivateKey);
//   const client = Client.forTestnet();

//   client.setOperator(creator_id, creator_pk);
//   const newtokeId = await createToken(data, client);
//   console.log("TOKEN CREATION SUCCESS");

//   var dao = data.daoDetails;
//   var tpk = PrivateKey.fromString(dao.pe_key);

//   // Topic subscription for invoice and notifications
//   const topicId = await createTopic(client);
//   console.log("TOPIC CREATION SUCCESS");
//   //
//   await new Promise((resolve) => setTimeout(resolve, 5000));

//   // Deploy invoice contract for topic to do stuff with it: DOESNT WORK YET
//   const invoiceContractID = await deployInvoiceContract(client);
//   console.log("INVOICE CONRTACT DELPLOYED SUCCESSFULLY");



//   const txnsContract = await deployTransactionsContract(client);
//   console.log("ACCOUNTNG TXNS DELPLOYED SUCCESSFULLY");

//   return {
//     // tokenID: newtokeId?.toString(),
//     topicID: topicId.toString(),
//     transactionsContract: `0.0.${txnsContract.shard.toString()}`,
//     invoiceContractID: `0.0.${invoiceContractID.shard.toString()}`
//   };
// });

// export const makeTransaction = functions.https.onCall(async (data) => {
//   //
//   var receiversAddresses: string[] = data.receivers;
//   // var sender: string = data.sender;
//   var receiverIDS: AccountId[] = [];
//   for (let index = 0; index < receiversAddresses.length; index++) {
//     const element = receiversAddresses[index];
//     receiverIDS.push(AccountId.fromString(element));
//   }
//   // var senderAddress = AccountId.fromString(sender);
//   //
//   // await carryOutArrayOfTransactions(senderAddress, receiverIDS);

// });
