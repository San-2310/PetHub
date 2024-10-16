import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manipal_app/components/colors.dart';

class PrimaryButtonWithIcon extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  //final String iconPath;
  const PrimaryButtonWithIcon(
      {super.key,
      required this.buttonText,
      required this.onTap,
      //required this.iconPath
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
                            AppColors.darkGreen,
                            AppColors.lightGreen,
                            AppColors.mediumGreen,
                            AppColors.mediumGreen,
                            AppColors.mediumGreen,
                            AppColors.mediumGreen,
                            AppColors.paleGreen,
                            AppColors.paleGreen
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Icons/Google.png',height: 30,width: 30,),
            SizedBox(width: 10),
            Text(
              buttonText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.mediumGray,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}