// lib/screens/pet_details_page.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:manipal_app/screens/home_screen/home_screen.dart';

class PetInsuranceDetailsPage extends StatefulWidget {
  final double totalCost;

  const PetInsuranceDetailsPage({super.key, required this.totalCost});

  @override
  PetInsuranceDetailsPageState createState() => PetInsuranceDetailsPageState();
}

class PetInsuranceDetailsPageState extends State<PetInsuranceDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _createStripeCustomer() async {
    final url = Uri.parse('https://api.stripe.com/v1/customers');
    final apiKey =
        'sk_test_51PnS1LRrPd3YsHcx31PFAe9bnACEeVcAb2bkNKxnr5U38faxO0plBohooJnwtFFF7WvMgJL0WLVFbVx1pM58MoU600youJ2Mdf'; // Use your Stripe secret key

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': 'customer@example.com', // You would get this from user input
          'name': _nameController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Customer created: ${data['id']}');

        // Navigate back to home on success
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        }
      } else {
        print('Failed to create customer: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Pet Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pet name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Pet Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pet type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(labelText: 'Pet Breed'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pet breed';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Pet Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pet age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (_image != null)
                Image.file(_image!, height: 200)
              else
                const Text('No image selected'),
              ElevatedButton(
                onPressed: _getImage,
                child: const Text('Add Photo'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _image != null) {
                    _createStripeCustomer();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all fields and add a photo'),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}