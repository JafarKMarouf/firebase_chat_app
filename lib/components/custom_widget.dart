import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController customController;
  final String hintText;
  final TextInputType type;
  final String title;
  final bool isSuffix;
  final IconData? suffixIcon;
  final String? Function(String?)? validate;
  final void Function(String)? onChange;
  final String? Function(String?)? onSubmit;
  final VoidCallback? onPressedSuffix;
  const CustomTextFormField({
    super.key,
    required this.validate,
    required this.title,
    required this.customController,
    required this.hintText,
    required this.type,
    required this.isSuffix,
    this.suffixIcon,
    this.onPressedSuffix,
    this.onChange,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                )),
            suffixIcon: (isSuffix)?IconButton(
              onPressed:onPressedSuffix ,
              icon: Icon(suffixIcon),
            ):const Text(''),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 20,
            ),
            labelStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          controller: customController,
          keyboardType: type,
          onChanged:onChange,
          onFieldSubmitted: onSubmit,
          validator: validate,
        ),
      ],
    );
  }
}

class PasswordTextFormField extends StatelessWidget {
  final bool isShow;
  final Function changeSuffixIcon;
  final TextEditingController password;
  final String? Function(String?)? validate;
  final String hintText;

  const PasswordTextFormField({
    super.key,
    required this.validate,
    required this.password,
    required this.isShow,
    required this.changeSuffixIcon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: password,
      obscureText: isShow,
      keyboardType: TextInputType.visiblePassword,
      validator:validate,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            )),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 20,
        ),
        labelStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red),
        suffixIcon: IconButton(
          onPressed: () {
            changeSuffixIcon();
          },
          icon: isShow
              ? const Icon(Icons.remove_red_eye_sharp)
              : const Icon(Icons.remove_red_eye_outlined),
        ),
      ),
    );
  }
}

class CustomButtonAuth extends StatelessWidget {
  final String title;
  final VoidCallback ? onTap;
  const CustomButtonAuth({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          boxShadow: const[
            BoxShadow(color: Colors.black26,offset: Offset(2, 4)),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            color:Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String? imageName;
  final VoidCallback? onTap;
  const SocialButton({
    super.key,
    required this.imageName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 65,
        height: 65,
        child:Image.asset('$imageName'),
      ),
    );
  }
}

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key,required this.height,required this.width,});
  final double width,height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300),
        child: Image.asset(
          'assets/logos/logo2.png',
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
