import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FCMNotifications {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;


  Future<bool> sendNotification(
      {required String title,
      required String body,
      required String token}) async {
    print("VM-- $title, $body, $token");
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization":
          "key=<server key>"
    };
    String notificationBody =
        '{ "to" : "$token", "notification" : { "body" : "$body", "title" : "$title" } }';
    http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: headers, body: notificationBody);
    return true;
  }
}
