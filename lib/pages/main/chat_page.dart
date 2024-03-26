// ignore_for_file: use_build_context_synchronously, must_be_immutable, avoid_print, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/components/chat_bubble.dart';
import 'package:firebase_app/components/constant.dart';
import 'package:firebase_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:firebase_app/models/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/custom_widget.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final CollectionReference<Map<String, dynamic>> messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  String message = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // List<Message> messageList = [];

  @override
  Widget build(context) {
    final email = ModalRoute.of(context)!.settings.arguments;
    print('===========email in chat screen ${email.toString()}=============');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomLogo(
                width: 45,
                height: 45,
              ),
              Text(
                ' Chat Page',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // SharedPreferences shared = await SharedPreferences.getInstance();
                  // shared.remove('email');
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Sign Out',
                    desc: 'you have already sign out!',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('login', (route) => false);
                    },
                  ).show();
                },
                icon: const Icon(Icons.exit_to_app)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  return ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount:BlocProvider.of<ChatCubit>(context).messageList.length,
                      itemBuilder: (context, index) {
                        return (email == BlocProvider.of<ChatCubit>(context).messageList[index].email)
                            ? ChatBubble(
                          message: BlocProvider.of<ChatCubit>(context).messageList[index],

                              )
                            : ChatBubbleFriend(
                                message: BlocProvider.of<ChatCubit>(context).messageList[index],
                              );
                      });
                },
              ),
            ),
            Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: CustomTextFormField(
                  onChange: (data) {
                    message = data;
                    // print(data);
                  },
                  onSubmit: (data) {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<ChatCubit>(context).receiveMessage();
                      messageController.clear();
                      // scrollController.animateTo(0.0,
                      //     // scrollController.position.maxScrollExtent,
                      //     duration: const Duration(
                      //       milliseconds: 300,
                      //     ),
                      //     curve: Curves.fastOutSlowIn);
                    }
                    return null;
                  },
                  hintText: 'Enter your message here..',
                  title: '',
                  isSuffix: true,
                  suffixIcon: Icons.send_rounded,
                  onPressedSuffix: () {
                    if (formKey.currentState!.validate()) {
                      messages.add({
                        'body': message,
                        'createdAt': DateTime.now(),
                        'email': email,
                      });
                      messageController.clear();
                      scrollController.animateTo(
                          // scrollController.position.maxScrollExtent,
                          0.0,
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          curve: Curves.fastOutSlowIn);
                    }
                  },
                  customController: messageController,
                  type: TextInputType.text,
                  validate: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
