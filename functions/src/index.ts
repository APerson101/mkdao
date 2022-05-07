import * as functions from "firebase-functions";
import { createAccount } from "./createaccount";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

export const createaccount = functions.https.onCall(async () => {
  const converted = JSON.stringify(await createAccount());
  console.log(converted);
  return converted;
});
