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
        title: Text('Symptoms'),
      ),
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
                        splashColor: Colors.transparent,  // Prevent splash effect
                        highlightColor: Colors.transparent, 
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
          color: isEnabled ? (isSelected ? Colors.black : Colors.grey) : Colors.white,
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