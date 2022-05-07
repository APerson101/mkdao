// import { createAccount } from "./createaccount";
// import { sendEmail } from "./mailingservice";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
// "npm --prefix \"$RESOURCE_DIR\" run lint",

  // const converted = JSON.stringify(await createAccount());
// import { PrivateKey, AccountId, Client } from "@hashgraph/sdk";


// export const sendEmailservice = functions.https.onCall(async (email) => {
//   return await sendEmail(email.email);
// });

// import * as dotenv from "dotenv";
// dotenv.config();
// const myAccountIdString = '0.0.34362732';
// const myPrivateKeyString = '302e020100300506032b6570042204208bb7577d581fdb869c4f83e92e6ab5d20b8dc3f9c2f8e94e461a0bf758a766cc';
// const my_AccountID = AccountId.fromString(myAccountIdString || '');
// const my_privatekey = PrivateKey.fromString(myPrivateKeyString || '');
// const client = Client.forTestnet();
// client.setOperator(my_AccountID, my_privatekey);
// async function createAccount(): Promise<{}> {
//   const pk = PrivateKey.generate();
//   const pub_key = pk.publicKey;
//   const newly_created_account = (await (await new AccountCreateTransaction()
//     .setInitialBalance(new Hbar(2))
//     .setKey(pub_key)
//     .execute(client)).getReceipt(client)).accountId;
//   console.log(`private key: ${pk.toStringRaw()}, public key : ${pk.publicKey.toStringRaw()}`);
//   return { privateKey: pk.toStringRaw(), publicKey: pub_key.toStringRaw(), accountID: newly_created_account!.toString() };
// }
