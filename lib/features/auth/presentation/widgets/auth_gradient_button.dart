import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onpress;
  const AuthGradientButton({super.key, required this.buttonText,required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Decorations
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [AppPallete.gradient1, AppPallete.gradient2],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
          borderRadius: BorderRadius.circular(7)),

      // childs
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            shadowColor: AppPallete.transparent,
            backgroundColor: AppPallete.transparent),
        child: Text(
          buttonText,
          style:const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
