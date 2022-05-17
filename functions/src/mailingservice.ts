// import * from "nodemailer";
/* eslint-disable*/
// import mailjet from 
import * as ss from "node-mailjet";
const v = ss.connect('5cf3835c986858df99223dc5e0c89071', '31b12add93430621b95fec377f7d456e')

// import * as nodemailer from "nodemailer";
// const nodemailer = require("nodemailer");

export async function sendEmail(receivers: string[], daoName: string, id: string): Promise<boolean> {
  //   // create reusable transporter object using the default SMTP transport.
  //   var constantLink = "";
  // const array_codes = await generateAndStoreCode(daoName, number_of_people);
  for (let index = 0; index < receivers.length; index++) {
    const current_receiver = receivers[index];

    const url = `http://localhost:57189/#/EmailSignUp/?daoName=${daoName}&type=email&id=${id}&email=${current_receiver}`
    const request = v
      .post("send", { 'version': 'v3.1' })
      .request({
        "Messages": [
          {
            "From": {
              "Email": "abdulhadih48@gmail.com",
              "Name": "Abdulhadi"
            },
            "To": [
              {
                "Email": `${current_receiver}`,
                "Name": "DAO Accounting"
              }
            ],
            "Subject": "MultiSig Account",
            "TextPart": "My first Mailjet email",
            "HTMLPart": `<h3>Hello, you are receiving this mail because you are required to create a wallet account which would be used to create a multisig account, follow <a href='${url}'>this</a> link, Cheers!</h3><br />May the DAO force be with you!`,
            "CustomID": "AppGettingStartedTest"
          }
        ]
      });
    request
      .then((result) => {
        console.log(result.body)
      })
      .catch((err) => {
        console.log(err.statusCode)
      });
  }
  console.log("DONE"); return true;
}
