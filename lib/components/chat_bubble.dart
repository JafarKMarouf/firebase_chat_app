import 'package:flutter/material.dart';

import '../models/messages.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.blueGrey),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            margin:
                const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 4),
            child: Text(
              '${message.body} ',
              style: const TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 15),
          child: Text(TimeOfDay.fromDateTime(DateTime.fromMicrosecondsSinceEpoch(message.date.millisecondsSinceEpoch)).format(context)),
        ),
      ],
    );
  }
}

class ChatBubbleFriend extends StatelessWidget {
  const ChatBubbleFriend({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.blue),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            margin:
                const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 4),
            child: Text(
              '${message.body} ',
              style: const TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(right: 15),
          child: Text(TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(message.date.millisecondsSinceEpoch)).format(context)),

        ),
        // Text('${message.date.toDate()}'),
      ],
    );
  }
}
