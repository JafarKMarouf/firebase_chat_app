import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/components/constant.dart';
import 'package:firebase_app/models/messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final CollectionReference<Map<String, dynamic>> messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
      List<Message> messageList = [];

  void sendMessage({required String message, required String email}) {
    messages.add({
      'body': message,
      'createdAt': DateTime.now(),
      'email': email,
    });
  }

  void receiveMessage() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
    });
  }
}
