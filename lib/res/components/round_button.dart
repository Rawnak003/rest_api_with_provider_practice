import 'package:flutter/material.dart';
import 'package:rest_api_with_provider_practice/res/colors.dart';

class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.onTap,
    this.loading = false,
  });

  final double width;
  final double height;
  final String title;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width * 0.25,
        height: height * 0.05,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: loading ? CircularProgressIndicator(
            color: AppColors.whiteColor,
          ) : Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}