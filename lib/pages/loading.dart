import 'package:flutter/material.dart';

import '../services/user_services.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void _loadinUserInfo()async{
    // String email = await getEmail();
    // print('============ email is : $email =================');
    // if(email == ''){
    //   Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    // }
    // else{
    //   Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    // }
  }
  @override
  void initState() {
    _loadinUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(),
    );
  }
}
