import 'package:flutter/material.dart';

void main() {
  runApp(const PetAge());
}

class PetAge extends StatelessWidget {
  const PetAge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Age Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const PetAgeCalculator(),
    );
  }
}

class PetAgeCalculator extends StatefulWidget {
  const PetAgeCalculator({super.key});

  @override
  State<PetAgeCalculator> createState() => _PetAgeCalculatorState();
}

class _PetAgeCalculatorState extends State<PetAgeCalculator> {
  String? selectedPetType;
  final TextEditingController ageController = TextEditingController();
  int? humanAge;
  String lifeStage = '';

  void calculateAge() {
    if (selectedPetType == null || ageController.text.isEmpty) return;

    final petAge = double.parse(ageController.text);
    int calculatedAge;

    if (selectedPetType == 'cat') {
      if (petAge == 1)
        calculatedAge = 15;
      else if (petAge == 2)
        calculatedAge = 24;
      else
        calculatedAge = 24 + ((petAge - 2) * 4).round();
    } else {
      // Dog calculation
      if (petAge == 1)
        calculatedAge = 15;
      else if (petAge == 2)
        calculatedAge = 24;
      else
        calculatedAge = 24 + ((petAge - 2) * 5).round();
    }

    setState(() {
      humanAge = calculatedAge;
      if (calculatedAge < 12)
        lifeStage = 'baby';
      else if (calculatedAge < 18)
        lifeStage = 'adolescent';
      else if (calculatedAge < 60)
        lifeStage = 'adult';
      else if (calculatedAge < 80)
        lifeStage = 'senior';
      else
        lifeStage = 'geriatric';
    });
  }

  String getPetCareAdvice() {
    if (humanAge == null) return '';

    switch (lifeStage) {
      case 'baby':
        return 'Regular vaccinations, socialization, and training are crucial at this stage.';
      case 'adolescent':
        return 'Focus on exercise, continued training, and proper nutrition for growth.';
      case 'adult':
        return 'Maintain regular exercise, annual check-ups, and dental care.';
      case 'senior':
        return 'More frequent vet visits, joint care, and adjusted exercise routine recommended.';
      case 'geriatric':
        return 'Special attention to comfort, pain management, and modified diet needed.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Select Cat or Dog:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selectedPetType = 'cat'),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: selectedPetType == 'cat'
                              ? Colors.green.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          "assets/Icons/catage.jpg",
                          fit: BoxFit.fill,
                        )
                        //const Icon(Icons.pets, color: Colors.grey, size: 40),
                        ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => selectedPetType = 'dog'),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: selectedPetType == 'dog'
                              ? Colors.green.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          "assets/Icons/dogage.jpg",
                          fit: BoxFit.fill,
                        )
                        // ImageIcon(
                        //   AssetImage(
                        //     "assets/Icons/dogage.jpg",
                        //   ),
                        //   //color: Colors.grey,
                        //   size: 40,
                        // ),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Select Age of Pet:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your pet age',
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateAge,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Calculate', style: TextStyle(fontSize: 18)),
              ),
              if (humanAge != null) ...[
                const SizedBox(height: 30),
                Text(
                  'Your ${selectedPetType} is...',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  '$humanAge years old',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'in human years',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LifeStageIcon(
                      icon: Icons.child_care,
                      isSelected: lifeStage == 'baby',
                      label: 'Baby',
                    ),
                    LifeStageIcon(
                      icon: Icons.person_outline,
                      isSelected: lifeStage == 'adolescent',
                      label: 'Teen',
                    ),
                    LifeStageIcon(
                      icon: Icons.person,
                      isSelected: lifeStage == 'adult',
                      label: 'Adult',
                    ),
                    LifeStageIcon(
                      icon: Icons.elderly,
                      isSelected: lifeStage == 'senior',
                      label: 'Senior',
                    ),
                    LifeStageIcon(
                      icon: Icons.elderly_woman,
                      isSelected: lifeStage == 'geriatric',
                      label: 'Elderly',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  getPetCareAdvice(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class LifeStageIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final String label;

  const LifeStageIcon({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: isSelected ? Colors.green : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.green : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}