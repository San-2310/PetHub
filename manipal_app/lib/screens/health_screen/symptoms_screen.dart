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
      appBar: AppBar(
        title: const Text('Symptom Selector (Max 5)'),
      ),
      body: ListView(
        children: symptoms.map((symptom) {
          return CheckboxListTile(
            title: Text(symptom),
            value: selectedSymptoms.contains(symptom),
            onChanged: (bool? value) {
              if (value != null) {
                toggleSymptom(symptom);
              }
            },
            enabled: selectedSymptoms.length < 5 || selectedSymptoms.contains(symptom),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Here you can use the selectedSymptoms list
          print('Selected symptoms: $selectedSymptoms');
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}