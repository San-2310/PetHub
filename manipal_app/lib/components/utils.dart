import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manipal_app/components/colors.dart';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}

Widget rectangularGreenBox(String text) {
  return Container(
    height: 80,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
      AppColors.darkGreen,
      AppColors.mediumGreen,
    ]),
    borderRadius: BorderRadius.circular(25),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(text,
            style: TextStyle(
              fontSize: 20,
              color: AppColors.mediumGray,
        
              
            ),),
          ),
        ],
      ),
    ),
  );
}

// showSnackBar(BuildContext context, String text) {
//   return ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//     ),
//   );
// }
