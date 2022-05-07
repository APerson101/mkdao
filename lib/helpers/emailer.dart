import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailHelper {
  sendEmail(String receiverAddress) async {
    String username = 'kokorohunt@gmail.com';
    String password = "Najahatu1\$";

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.
    // Create our message.
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add('abdulhadih48@gmail.com')
      ..subject = 'Treasury Account Creation :: 😀 :: ${DateTime.now()}'
      ..text =
          'Follow this link to create an account which would be used for the treasury ';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
