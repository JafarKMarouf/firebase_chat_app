// ignore_for_file: must_be_immutable, unnecessary_string_interpolations, unused_import

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebase_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../components/custom_widget.dart';

class RegisterPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isShow = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomLogo(
                      height: 90,
                      width: 90,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                    Text(
                      'Register to continue using app',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      isSuffix: false,
                      validate: (val) {
                        if (val!.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      title: 'Email',
                      customController: emailAddress,
                      hintText: 'Enter your email',
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    PasswordTextFormField(
                      validate: (val) {
                        if (val!.isEmpty) {
                          return 'Password must not be empty';
                        }
                        if (val.length < 6) {
                          return 'Password must be longer than 6 character';
                        }
                        return null;
                      },
                      password: password,
                      isShow: isShow,
                      hintText: 'Enter your password',
                      changeSuffixIcon: () {
                        // setState(() {
                        //   isShow = !isShow;
                        // });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButtonAuth(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {

                      try {
                     await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emailAddress.text,
                          password: password.text,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  title: 'Sign up',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do you have an account?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('home');
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
