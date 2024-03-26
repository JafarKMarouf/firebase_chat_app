// ignore_for_file: must_be_immutable, curly_braces_in_flow_control_structures, unnecessary_string_interpolations, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebase_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/custom_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  bool isShow = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          loading = true;
        } else if (state is LoginSuccess) {
          loading = false;
          print('==========email is login screen    ${email.text}');
          BlocProvider.of<ChatCubit>(context).receiveMessage();
          Navigator.pushReplacementNamed(context, 'home', arguments: email.text);
        } else if (state is LoginFailure) {
          loading = false;
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Info',
            desc: '${state.errorMessage}',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, state) => ModalProgressHUD(
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
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
                      ),
                      Text(
                        'Login to continue using app',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        isSuffix: false,
                        title: 'Email',
                        customController: email,
                        hintText: 'Enter your email',
                        type: TextInputType.emailAddress,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      PasswordTextFormField(
                          validate: (val) {
                            if (val!.isEmpty)
                              return 'Password must not be empty';
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
                          }),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          onPressed: () {},
                          elevation: 0.0,
                          child: const Text(
                            'Forget password?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomButtonAuth(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context)
                            .login(email: email.text, password: password.text);
                      }
                    },
                    title: 'Sign in',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    ' - Or Login with - ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButton(
                          imageName: 'assets/logos/facebook-logo.png',
                          onTap: () {}),
                      SocialButton(
                          imageName: 'assets/logos/google-logo.png',
                          onTap: () {}),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('register');
                        },
                        child: const Text(
                          'Register',
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
      ),
    );
  }
}
