// import 'package:flutter/material.dart';
// import 'package:manipal_app/models/vet.dart';
// import 'colors.dart';

// class DoctorCard extends StatelessWidget {
//   final Doctor doctor;

//   const DoctorCard({Key? key, required this.doctor}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 doctor.imageUrl,
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     doctor.name,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     doctor.specialty,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: AppColors.mediumGray,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: AppColors.paleGreen,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(Icons.verified, size: 16, color: AppColors.darkGreen),
//                             const SizedBox(width: 4),
//                             Text(
//                               "${doctor.yearsExperience} Yrs",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.darkGreen,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           "Consultant at: ${doctor.hospital}",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: AppColors.mediumGray,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:manipal_app/models/vet.dart';
import 'colors.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                doctor.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialty,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.mediumGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.paleGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, size: 14, color: AppColors.darkGreen),
                            const SizedBox(width: 4),
                            Text(
                              "${doctor.yearsExperience} Yrs",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.darkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Consultant at: ${doctor.hospital}",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.mediumGray,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}