// topic subscription
// notify user
import {
  AccountId, Client,
  ContractCallQuery,
  ContractFunctionParameters,
  ContractExecuteTransaction, ContractId,
  PrivateKey, TopicCreateTransaction, TopicId, TopicMessageQuery, TopicMessageSubmitTransaction, TransactionResponse, Hbar,
  // TransferTransaction
} from "@hashgraph/sdk";
// import * as fs from "fs";
// import * as path from "path";
import * as admin from "firebase-admin";
// import { Message } from "firebase-admin/lib/messaging/messaging-api";
import * as dotenv from "dotenv";
import { Interface } from "@ethersproject/abi";
const abii = [
  {
    "inputs": [
      {
        "components": [
          {
            "internalType": "address",
            "name": "sender",
            "type": "address"
          },
          {
            "internalType": "string",
            "name": "description",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "category",
            "type": "string"
          },
          {
            "internalType": "uint256",
            "name": "amount",
            "type": "uint256"
          },
          {
            "internalType": "string",
            "name": "tokenId",
            "type": "string"
          }
        ],
        "internalType": "struct Invoicing.Invoice",
        "name": "newInvoice",
        "type": "tuple"
      },
      {
        "internalType": "string",
        "name": "invoiceId",
        "type": "string"
      }
    ],
    "name": "addInvoice",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getAllInvoices",
    "outputs": [
      {
        "components": [
          {
            "internalType": "address",
            "name": "sender",
            "type": "address"
          },
          {
            "internalType": "string",
            "name": "description",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "category",
            "type": "string"
          },
          {
            "internalType": "uint256",
            "name": "amount",
            "type": "uint256"
          },
          {
            "internalType": "string",
            "name": "tokenId",
            "type": "string"
          }
        ],
        "internalType": "struct Invoicing.Invoice[]",
        "name": "",
        "type": "tuple[]"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "invoiceId",
        "type": "string"
      }
    ],
    "name": "getInvoice",
    "outputs": [
      {
        "components": [
          {
            "internalType": "address",
            "name": "sender",
            "type": "address"
          },
          {
            "internalType": "string",
            "name": "description",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "category",
            "type": "string"
          },
          {
            "internalType": "uint256",
            "name": "amount",
            "type": "uint256"
          },
          {
            "internalType": "string",
            "name": "tokenId",
            "type": "string"
          }
        ],
        "internalType": "struct Invoicing.Invoice",
        "name": "",
        "type": "tuple"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  }
]
let abiInterface: Interface;

dotenv.config();

const myAccountIdString = '0.0.34362732';
const myPrivateKeyString = '302e020100300506032b6570042204208bb7577d581fdb869c4f83e92e6ab5d20b8dc3f9c2f8e94e461a0bf758a766cc';
const my_AccountID = AccountId.fromString(myAccountIdString || '');
const my_privatekey = PrivateKey.fromString(myPrivateKeyString || '');
const client = Client.forTestnet();
client.setOperator(my_AccountID, my_privatekey);

// "publicKey": "302a300506032b65700321007e9921707f9e7b8c6d256878233e9967670fc2e4111b9cf849bfd8d1d301527f",
const myAccountIdString2 = '0.0.34402326';
const myPrivateKeyString2 = '302e020100300506032b657004220420be6a4b6614ede100b515bdca60dee882849a353f184a964cee23839181d9865f';
const my_AccountID2 = AccountId.fromString(myAccountIdString2 || '');
const my_privatekey2 = PrivateKey.fromString(myPrivateKeyString2 || '');
const client2 = Client.forTestnet();
client2.setOperator(my_AccountID2, my_privatekey2);


// let abiInterface: Interface;

// class Invoice {
//   toMap(): {} {
//     return {
//       sender: this.sender,
//       description: this.description,
//       category: this.category,
//       amount: this.amount,
//       status: this.status
//     }

//   }
//   toMessage(): string {
//     return `new_invoice_${this.sender}_${this.amount}_${this.description}_${this.category}`;
//   }
//   sender: string;
//   description: string;
//   category: string;
//   amount: number;
//   status: boolean;

//   constructor(sender: string, description: string, category: string, amount: number, status: boolean) {
//     this.amount = amount;
//     this.category = category;
//     this.description = description;
//     this.sender = sender;
//     this.status = status;
//   }
// }




// var 
export async function createTopic(creatorClient: Client): Promise<TopicId> {
  // create Topic
  var topicid = (await (await new TopicCreateTransaction().execute(creatorClient)).getReceipt(creatorClient)).topicId;
  return topicid!;
}

// subscribe to Topic
export async function subscribeToTopic(_token: string) {
  const topic = TopicId.fromString('0.0.34744491');
  await admin.firestore().doc(`TopicSubscribers/0.0.34744491`).set({ 'subscribers': admin.firestore.FieldValue.arrayUnion(_token) });
  new TopicMessageQuery()
    .setTopicId(topic)
    .subscribe(client, null, (message) => {
      const messageString = Buffer.from(message.contents).toString();
      console.log(` time received ${message.consensusTimestamp.toDate()}, message received is: ${messageString} `);
      // ResolveMessage(messageString, message.consensusTimestamp.toDate(), _token);
    });
}

// send topic message- sample invoice
export async function sendMessageToTopic() {
  const topicid: TopicId = TopicId.fromString('0.0.34744491');
  const senderClient: Client = Client.forTestnet();
  const senderID = AccountId.fromString(process.env.FIFTH_ACC_ID!);
  const senderPK = PrivateKey.fromString(process.env.FIFITH_PRIVATE_KEY!);
  senderClient.setOperator(senderID, senderPK);
  const messagecreated: string = "TEST FOR HEDERA";

  const rr = await new TopicMessageSubmitTransaction({
    topicId: topicid,
    message: messagecreated
  })
    // .freezeWith(client)
    .execute(senderClient);
  const status = ((await rr.getReceipt(senderClient)).status.toString());
  if (status == "SUCCESS") {
    const invoideId = (await rr.getRecord(senderClient)).transactionId;
    // const abi = JSON.parse(JSON);
    abiInterface = new Interface(abii);

    const invoiceMap = {
      sender: senderID.toSolidityAddress(),
      description: 'test invoice',
      category: 'test category',
      amount: 2,
      status: false,
      tokenId: 'testTokenID'
    }
    const encoededFunctionParameters = Buffer.from(
      abiInterface.encodeFunctionData('addInvoice', [invoiceMap, invoideId.toString()]).slice(2), 'hex');

    await sendNewNotification(topicid, messagecreated);
    // send new invoice
    const saveInvoice = await new ContractExecuteTransaction()
      .setGas(400_000)
      .setContractId(ContractId.fromString('0.0.34816305'))
      .setFunction('addInvoice')
      .setFunctionParameters(encoededFunctionParameters)
      .execute(senderClient);
    console.log("Invoice saving status is: ", (await saveInvoice.getReceipt(senderClient)).status.toString());
    console.log(invoideId.toString());

  }
  return status;
}
// How to receive notifications in a decentralized manner:
/**
 * Option 1: Store 
 */

async function sendNewNotification(topidid: TopicId, message: string) {
  // 
  console.log('sending notification to all subscribers');
  const docsSnapshots = await admin.firestore().doc(`TopicSubscribers/${topidid.toString()}`).get();
  const allFields = docsSnapshots.data();
  if (allFields !== undefined) {
    const subscribers: (string)[] = allFields['subscribers']
    console.log(subscribers)
    var messaging = admin.messaging()
    const messages = {
      data: {
        title: 'Odogwu you bad',
        body: message
      },
      tokens: subscribers
    };
    messaging.sendMulticast(messages)
      .then((response) => {
        if (response.failureCount > 0) {
          const failedTokens: (string)[] = [];
          response.responses.forEach((resp, index) => {
            if (!resp.success) {
              failedTokens.push(subscribers[index]);
            }
          });
          console.log(`List of tokens that caused failures are: ${failedTokens}`);
        }
      }).catch((error) => console.log(error));

  }
}

export async function _ignoreInvoice(invoiceId: string) {
  // set to ignored on firebase and also on the chain?
  // await new ContractCallQuery()
  //   .setContractId()
  //   .setFunction('updateInvoiceStatus', new ContractFunctionParameters().addString('Ignore')
  //     .addString(invoiceId))
  //   .execute()
}
export async function _acknowledgeInvoice(invoiceId: string) {
  // await new ContractCallQuery()
  //   .setContractId()
  //   .setFunction('updateInvoiceStatus', new ContractFunctionParameters().addString('Acknowledge')
  //     .addString(invoiceId))
  //   .execute()

}
export async function payInvoicewithId(invoiceId: string) {
  //get invoice details
  // const abi = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../contracts/invoiceabi.json'), 'utf-8'));
  abiInterface = new Interface(abii);
  const invoiceResult = await new ContractCallQuery()
    .setContractId(ContractId.fromString('0.0.34816305'))
    .setGas(400_000)
    .setQueryPayment(new Hbar(5))
    .setFunction('getInvoice', new ContractFunctionParameters().addString(invoiceId))
    .execute(client2);
  const result = abiInterface.decodeFunctionResult('getInvoice', invoiceResult.asBytes());
  console.log(result);
  //topic information gotten, next up is to make the payment
}

// async function ResolveMessage(message: string, date: Date, _token: string) {
//   if (message.startsWith('TEST FOR HEDERA', 0)) {
//     // new invoice sent to us
//     console.log(`you have a new invoice: ${message}`);
//     //show notification
//     var messaging = admin.messaging()
//     const messages: Message = {
//       notification: {
//         title: 'Odogwu you bad',
//         body: message
//       }, token: _token
//     };

//     const response = await messaging.send(messages);
//     console.log(response);
//     // you can therefore accept, reject or pay
//     //simulate accept
//   }

//   else if (message.startsWith('your_created_invoice_status_', 0)) {
//     // there is an update regarding an invoice you created
//     console.log(`the status is: ${message} `);

//     // update the invoice with the invoice id and the message update
//     // await updateInvoice(invoiceId, message);

//   }
// }

// create invoice knowing the person's invoice contract ID, notify user of newly created invoice, trigger refresh.

// or

// create a new topic for every new invoice

export async function createInvoice(receivertopicId: TopicId, msgid: string) {
  const topicmsgg: TransactionResponse = await new TopicMessageSubmitTransaction
    (
      {
        topicId: receivertopicId, message: `new_invoice_with_id_${msgid}`
      })
    .execute(client);
  console.log(`status of message is: ${(await topicmsgg.getReceipt(client)).status} `)
}
// async function main() {
//   const my_AccountID = AccountId.fromString(process.env.MY_ACCOUNT_ID);
//   const my_pk = PrivateKey.fromString(process.env.MY_PRIVATE_KEY);
//   const client = Client.forTestnet();
//   client.setOperator(my_AccountID, my_pk);

//   const new_acc_id = AccountId.fromString(process.env.TEST_2);
//   const new_private = PrivateKey.fromString(process.env.privateKeytest);
//   const client2 = Client.forTestnet();
//   client2.setOperator(new_acc_id, new_private);

//   //create topic for first user
//   // var topicUser1 = await createTopic(client);
//   var topicUser1 = TopicId.fromString('0.0.34705317');
//   // wait for 5 seconds
//   await new Promise((resolve) => setTimeout(resolve, 5000));

//   // create topic for second user
//   // var topicUser2 = await createTopic(client2);
//   var topicUser2 = TopicId.fromString('0.0.34705318');


//   // wait for 5 seconds
//   await new Promise((resolve) => setTimeout(resolve, 5000));

//   // deploy invoice contract for first person
//   // var contractid1 = await deployInvoiceContract(client);
//   var contractid1 = ContractId.fromString('0.0.34705320')


//   // deploy invoice contract for second person
//   // var contractId2 = await deployInvoiceContract(client2);
//   var contractId2 = ContractId.fromString('0.0.34705322');


//   const mockInvoice = new Invoice(new_acc_id.toSolidityAddress(), "TESTING THINGS", "chocolate", 40, false);
//   const mockInvoice2 = new Invoice(my_AccountID.toSolidityAddress(), "TESTING THINGS_AS_E_DEY_BE", "chocolate", 40, false);

//   //Subscribe first person to first topic
//   await subscribeToTopic(topicUser1, client, my_AccountID, mockInvoice.toMap(), "mock invoice_id", contractid1);

//   //Subscribe second person to second topic
//   await subscribeToTopic(topicUser2, client2, new_acc_id, mockInvoice2.toMap(), "mock_2", contractId2);


//   //send invoice from user 2 to one, user accepts it and it adds to contract
//   await createInvoice(client2, topicUser1, mockInvoice);

// }

// main().catch((error) => {
//   console.log(error);
//   process.exit(1);
// })

