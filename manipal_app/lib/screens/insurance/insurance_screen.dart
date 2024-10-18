import 'package:flutter/material.dart';
import 'package:manipal_app/screens/insurance/pet_insurance.dart';

class InsurancePage extends StatefulWidget {
  const InsurancePage({super.key});

  @override
  InsurancePageState createState() => InsurancePageState();
}

class InsurancePageState extends State<InsurancePage> {
  double baseValue = 1000;
  double monthlyPremium = 50; // baseValue/20

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet Insurance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose Base Coverage: ₹${baseValue.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Slider(
              min: 1000,
              max: 100000,
              value: baseValue,
              onChanged: (value) {
                setState(() {
                  baseValue = value;
                  monthlyPremium = value / 20;
                });
              },
            ),
            Text(
              'Monthly Premium: ₹${monthlyPremium.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddonsPage(baseValue: baseValue),
                  ),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddonsPage extends StatefulWidget {
  final double baseValue;

  const AddonsPage({super.key, required this.baseValue});

  @override
  AddonsPageState createState() => AddonsPageState();
}

class AddonsPageState extends State<AddonsPage> {
  List<bool> selectedAddons = [false, false, false];
  late double totalCost;

  @override
  void initState() {
    super.initState();
    totalCost = widget.baseValue;
  }

  void updateTotal() {
    double newTotal = widget.baseValue;
    for (var selected in selectedAddons) {
      if (selected) {
        newTotal += widget.baseValue * 0.2;
      }
    }
    setState(() {
      totalCost = newTotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Add-ons')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('Diagnostic Coverage'),
              value: selectedAddons[0],
              onChanged: (bool? value) {
                setState(() {
                  selectedAddons[0] = value!;
                  updateTotal();
                });
              },
            ),
            // Add more checkboxes as needed
            const SizedBox(height: 20),
            Text(
              'Total Cost: ₹${totalCost.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ConfirmationPage(totalCost: totalCost),
                  ),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

// lib/screens/confirmation_page.dart

class ConfirmationPage extends StatelessWidget {
  final double totalCost;

  const ConfirmationPage({super.key, required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Purchase')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Cost: ₹${totalCost.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InsurancePage()),
                      (route) => false,
                    );
                  },
                  child: const Text('No, Go Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PetInsuranceDetailsPage(totalCost: totalCost),
                      ),
                    );
                  },
                  child: const Text('Yes, Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}