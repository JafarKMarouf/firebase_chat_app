import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/custom_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isShow = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const CustomLogo(height: 90,width: 90,),
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
                      if (val!.isEmpty) return 'Email must not be empty';
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                      setState(() {
                        isShow = !isShow;
                      });
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
                    loading = true;
                    setState(() {});
                    try {
                      final credential =await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailAddress.text, password: password.text
                      );
                      if(credential != null){
                        print("============credential:$credential===============");

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Success',
                          desc:
                          'Created account Successfully, A message has been sent to your email',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            Navigator.of(context).pushReplacementNamed('login');
                          },
                        ).show();
                      }
                      // credential.user!.sendEmailVerification();

                    } on FirebaseAuthException catch (e) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Warning',
                        desc: '${e.message}',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                        },
                      ).show();
                    } catch (e) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: e.toString(),
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                        },
                      ).show();
                    }
                    loading = false;
                    setState(() {});
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
                      Navigator.of(context).pushReplacementNamed('login');
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
              if (loading)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
