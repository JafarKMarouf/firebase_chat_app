import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String body;
  final String email;
  final Timestamp date;

  Message(
    this.body,
    this.email,
    this.date,
);
  factory Message.fromJson(jsonData){
    return Message(
        jsonData['body'],
        jsonData['email'],
        jsonData['createdAt']
        // DateTime.parse(jsonData['createdAt']) as Timestamp,
    );
  }

}