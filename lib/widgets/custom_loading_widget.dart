import 'package:flutter/material.dart';
import 'package:siakad_lpk/themes/colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation(kPrimaryColor),
      ),
    );
  }
}