import 'package:flutter/material.dart';
import 'package:manipal_app/components/colors.dart';

class TabButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;
  final bool isSelected;
  const TabButton({super.key, required this.title, required this.icon , required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: isSelected?15:19,
            height: isSelected?15:15,
            color: isSelected ? const Color.fromARGB(255, 35, 57, 12) :  AppColors.darkGreen,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color.fromARGB(255, 35, 57, 12):  AppColors.darkGreen,
              fontSize: isSelected?15:12,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}