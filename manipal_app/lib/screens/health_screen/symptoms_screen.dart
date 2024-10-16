// // // import 'package:flutter/material.dart';

// // // class SymptomsScreen extends StatefulWidget {
// // //   const SymptomsScreen({Key? key}) : super(key: key);

// // //   @override
// // //   _SymptomsScreenState createState() => _SymptomsScreenState();
// // // }

// // // class _SymptomsScreenState extends State<SymptomsScreen> {
// // //   final List<String> symptoms = [
// // //     'Fever', 'Diarrhea', 'Vomiting', 'Weight loss', 'Coughing',
// // //     'Lethargy', 'Dehydration', 'Sneezing', 'Ulcers', 'Facial swelling',
// // //     'Nasal discharge', 'Nausea', 'Weakness', 'Skin irritation',
// // //     'Loss of appetite', 'Shortness of breath', 'Abnormal behavior',
// // //     'Convulsions', 'Ring-shaped lesion', 'Blood in urine',
// // //     'Fatigue', 'Dizziness'
// // //   ];

// // //   List<String> selectedSymptoms = [];

// // //   void toggleSymptom(String symptom) {
// // //     setState(() {
// // //       if (selectedSymptoms.contains(symptom)) {
// // //         selectedSymptoms.remove(symptom);
// // //       } else if (selectedSymptoms.length < 5) {
// // //         selectedSymptoms.add(symptom);
// // //       }
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Symptom Selector (Max 5)'),
// // //       ),
// // //       body: ListView(
// // //         children: symptoms.map((symptom) {
// // //           return CheckboxListTile(
// // //             tileColor: Color.fromRGBO(255, 246, 246, 1),
// // //             title: Text(symptom),
// // //             value: selectedSymptoms.contains(symptom),
// // //             onChanged: (bool? value) {
// // //               if (value != null) {
// // //                 toggleSymptom(symptom);
// // //               }
// // //             },
// // //             enabled: selectedSymptoms.length < 5 || selectedSymptoms.contains(symptom),
// // //           );
// // //         }).toList(),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () {
// // //           // Here you can use the selectedSymptoms list
// // //           print('Selected symptoms: $selectedSymptoms');
// // //         },
// // //         child: const Icon(Icons.check),
// // //       ),
// // //     );
// // //   }
// // // }


// // import 'package:flutter/material.dart';

// // class SymptomsScreen extends StatefulWidget {
// //   const SymptomsScreen({Key? key}) : super(key: key);

// //   @override
// //   _SymptomsScreenState createState() => _SymptomsScreenState();
// // }

// // class _SymptomsScreenState extends State<SymptomsScreen> {
// //   final List<String> symptoms = [
// //     'Fever', 'Diarrhea', 'Vomiting', 'Weight loss', 'Coughing',
// //     'Lethargy', 'Dehydration', 'Sneezing', 'Ulcers', 'Facial swelling',
// //     'Nasal discharge', 'Nausea', 'Weakness', 'Skin irritation',
// //     'Loss of appetite', 'Shortness of breath', 'Abnormal behavior',
// //     'Convulsions', 'Ring-shaped lesion', 'Blood in urine',
// //     'Fatigue', 'Dizziness'
// //   ];

// //   List<String> selectedSymptoms = [];

// //   void toggleSymptom(String symptom) {
// //     setState(() {
// //       if (selectedSymptoms.contains(symptom)) {
// //         selectedSymptoms.remove(symptom);
// //       } else if (selectedSymptoms.length < 5) {
// //         selectedSymptoms.add(symptom);
// //       }
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Symptom Selector'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: symptoms.length,
// //         itemBuilder: (context, index) {
// //           final symptom = symptoms[index];
// //           final isSelected = selectedSymptoms.contains(symptom);
// //           return Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 color: const Color.fromRGBO(255, 246, 246, 1),
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: InkWell(
// //                 onTap: () => toggleSymptom(symptom),
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         symptom,
// //                         style: const TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w500,
// //                           color: Colors.black87,
// //                         ),
// //                       ),
// //                       CustomCheckbox(
// //                         isSelected: isSelected,
// //                         isEnabled: selectedSymptoms.length < 5 || isSelected,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class CustomCheckbox extends StatelessWidget {
// //   final bool isSelected;
// //   final bool isEnabled;

// //   const CustomCheckbox({
// //     Key? key,
// //     required this.isSelected,
// //     required this.isEnabled,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: 24,
// //       height: 24,
// //       decoration: BoxDecoration(
// //         border: Border.all(
// //           color: isEnabled ? (isSelected ? Colors.blue : const Color.fromARGB(255, 158, 158, 158)) : Color.fromRGBO(251, 233, 233, 0.85),
// //           width: 2,
// //         ),
// //         borderRadius: BorderRadius.circular(4),
// //       ),
// //       child: isSelected
// //           ? Icon(
// //               Icons.check,
// //               size: 20,
// //               color: isEnabled ? Colors.blue : Color.fromRGBO(251, 233, 233, 0.85)
// //             )
// //           : null,
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class SymptomsScreen extends StatefulWidget {
//   const SymptomsScreen({Key? key}) : super(key: key);

//   @override
//   _SymptomsScreenState createState() => _SymptomsScreenState();
// }

// class _SymptomsScreenState extends State<SymptomsScreen> {
//   final List<String> symptoms = [
//     'Fever', 'Diarrhea', 'Vomiting', 'Weight loss', 'Coughing',
//     'Lethargy', 'Dehydration', 'Sneezing', 'Ulcers', 'Facial swelling',
//     'Nasal discharge', 'Nausea', 'Weakness', 'Skin irritation',
//     'Loss of appetite', 'Shortness of breath', 'Abnormal behavior',
//     'Convulsions', 'Ring-shaped lesion', 'Blood in urine',
//     'Fatigue', 'Dizziness'
//   ];

//   List<String> selectedSymptoms = [];

//   void toggleSymptom(String symptom) {
//     setState(() {
//       if (selectedSymptoms.contains(symptom)) {
//         selectedSymptoms.remove(symptom);
//       } else if (selectedSymptoms.length < 5) {
//         selectedSymptoms.add(symptom);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Symptom Selector Max(5)'),
//       ),
//       body: ListView.builder(
//         itemCount: symptoms.length,
//         itemBuilder: (context, index) {
//           final symptom = symptoms[index];
//           final isSelected = selectedSymptoms.contains(symptom);
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color.fromRGBO(251, 233, 233, 0.85),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: InkWell(
//                 onTap: () => toggleSymptom(symptom),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         symptom,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       CustomCheckbox(
//                         isSelected: isSelected,
//                         isEnabled: selectedSymptoms.length < 5 || isSelected,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class CustomCheckbox extends StatelessWidget {
//   final bool isSelected;
//   final bool isEnabled;

//   const CustomCheckbox({
//     Key? key,
//     required this.isSelected,
//     required this.isEnabled,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 24,
//       height: 24,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: isEnabled ? (isSelected ? Colors.black : Colors.grey) : Colors.grey.shade300,
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: isSelected
//           ? Icon(
//               Icons.check,
//               size: 20,
//               color: isEnabled ? Colors.black : Colors.grey.shade300,
//             )
//           : null,
//     );
//   }
// }

import 'package:flutter/material.dart';

class SymptomsScreen extends StatefulWidget {
  const SymptomsScreen({Key? key}) : super(key: key);

  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  final List<String> symptoms = [
    'Fever', 'Diarrhea', 'Vomiting', 'Weight loss', 'Coughing',
    'Lethargy', 'Dehydration', 'Sneezing', 'Ulcers', 'Facial swelling',
    'Nasal discharge', 'Nausea', 'Weakness', 'Skin irritation',
    'Loss of appetite', 'Shortness of breath', 'Abnormal behavior',
    'Convulsions', 'Ring-shaped lesion', 'Blood in urine',
    'Fatigue', 'Dizziness'
  ];

  List<String> selectedSymptoms = [];

  void toggleSymptom(String symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else if (selectedSymptoms.length < 5) {
        selectedSymptoms.add(symptom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select upto 5 symptoms',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: symptoms.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final symptom = symptoms[index];
                    final isSelected = selectedSymptoms.contains(symptom);
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(251, 233, 233, 0.85),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        onTap: () => toggleSymptom(symptom),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                symptom,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              CustomCheckbox(
                                isSelected: isSelected,
                                isEnabled: selectedSymptoms.length < 5 || isSelected,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle proceed action
                    print('Selected symptoms: $selectedSymptoms');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(200, 230, 201, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;

  const CustomCheckbox({
    Key? key,
    required this.isSelected,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: isEnabled ? (isSelected ? Colors.black : Colors.grey) : Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              size: 24,
              color: isEnabled ? Colors.black : Colors.grey.shade300,
            )
          : null,
    );
  }
}