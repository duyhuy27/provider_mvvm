import 'package:arch_movie/res/colors.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final VoidCallback onPressed;
  const RoundButton(
      {super.key, required this.title, this.isLoading = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : InkWell(
            onTap: onPressed,
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Text(
                title,
                style: TextStyle(color: AppColors.white),
              )),
            ),
          );
  }
}
