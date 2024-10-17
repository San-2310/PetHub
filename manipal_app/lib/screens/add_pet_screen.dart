import 'package:flutter/material.dart';
import 'package:manipal_app/models/pet.dart';
import 'package:manipal_app/resources/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPetScreen extends StatefulWidget {
  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String species = '';
  String breed = '';
  int age = 0;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = Provider.of<UserProvider>(context, listen: false).getUser;
      
      final pet = Pet(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        species: species,
        breed: breed,
        age: age,
        ownerId: user!.uid,
        qrCodeLink: '',
      );

      pet.updateQRCode();

      await FirebaseFirestore.instance.collection('pets').add(pet.toJson());

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Pet')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              onSaved: (value) => name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Species'),
              validator: (value) => value!.isEmpty ? 'Please enter a species' : null,
              onSaved: (value) => species = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Breed'),
              validator: (value) => value!.isEmpty ? 'Please enter a breed' : null,
              onSaved: (value) => breed = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Please enter an age' : null,
              onSaved: (value) => age = int.parse(value!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add Pet'),
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}