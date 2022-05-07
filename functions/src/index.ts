import * as functions from "firebase-functions";
import { createnewAccount } from "./createaccount";
import { sendEmail } from "./mailingservice";


export const createAccount = functions.https.onCall(async (pulickey) => {
  var pk = pulickey.publickey;
  return await createnewAccount(pk);
});
export const sendMail = functions.https.onCall(async (variables) => {
  console.log("what is the issue hrer");
  var receivers = variables.receivers;
  var number_of_people = variables.number_of_people;
  var daoname = variables.daoName;

  return await sendEmail(receivers, daoname, number_of_people);
});

export const dontCreateme = functions.https.onCall(() => {
  return JSON.stringify("THis hs to be the strngetset errpr")
});


export const helloWorldWIEIEIEI = functions.https.onCall(() => {
  console.log("what is the issue hrer");
  return JSON.stringify('wlkhdiuofkhsdfkfdsjkdf fdgds i')
});

