import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal Health Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SymptomsScreen(),
    );
  }
}

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
    'Fatigue', 'Dizziness', 'Epistaxis', 'Difficulty in breathing'
  ];

  List<String> selectedSymptoms = [];
  String animalName = 'Tommy'; // Default animal name

  void toggleSymptom(String symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else if (selectedSymptoms.length < 5) {
        selectedSymptoms.add(symptom);
      }
    });
  }

  Future<void> sendRequest() async {
    if (selectedSymptoms.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select exactly 5 symptoms')),
      );
      return;
    }

    final url = Uri.parse('https://8ac1-2409-40c0-105f-b7a7-45d5-a4de-ac60-cb3a.ngrok-free.app/check_animal_condition');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'AnimalName': animalName,
        'symptoms1': selectedSymptoms[0],
        'symptoms2': selectedSymptoms[1],
        'symptoms3': selectedSymptoms[2],
        'symptoms4': selectedSymptoms[3],
        'symptoms5': selectedSymptoms[4],
      }),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final prediction = result['prediction'];
      final probability = result['probability'] as double;
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => prediction == 'Yes'
              ? DangerScreen(animalName: animalName, probability: probability)
              : SafeScreen(animalName: animalName, probability: probability),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending request')),
      );
    }
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
                'Select exactly 5 symptoms',
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
                        splashColor: Colors.transparent,
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
                  onPressed: sendRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(200, 230, 201, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Check Animal Condition',
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

class DangerScreen extends StatefulWidget {
  final String animalName;
  final double probability;

  const DangerScreen({Key? key, required this.animalName, required this.probability}) : super(key: key);

  @override
  _DangerScreenState createState() => _DangerScreenState();
}

class _DangerScreenState extends State<DangerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Slower animation
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Alert'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 100,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                'Oh no!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Your ${widget.animalName} might need help!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GradedMeter(value: _animation.value * widget.probability),
              SizedBox(height: 20),
              FadeTransition(
                opacity: _animation,
                child: Text(
                  'Danger Level: ${(widget.probability * 100).toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement vet consultation functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Connecting to a vet...')),
                  );
                },
                child: Text('Consult a Vet'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SafeScreen extends StatefulWidget {
  final String animalName;
  final double probability;

  const SafeScreen({Key? key, required this.animalName, required this.probability}) : super(key: key);

  @override
  _SafeScreenState createState() => _SafeScreenState();
}

class _SafeScreenState extends State<SafeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Status'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                'Good news!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Your ${widget.animalName} seems to be doing fine.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GradedMeter(value: 0.5 + (_animation.value * (1 - widget.probability) / 2)),
              SizedBox(height: 20),
              FadeTransition(
                opacity: _animation,
                child: Text(
                  'Safety Level: ${((1 - widget.probability) * 100).toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to Symptoms'),
                style: ElevatedButton.styleFrom(
                 // primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradedMeter extends StatelessWidget {
  final double value;

  const GradedMeter({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 20,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.yellow, Colors.green],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            left: (200 - 20) * value,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}