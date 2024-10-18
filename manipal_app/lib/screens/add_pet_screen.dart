import 'package:flutter/material.dart';
import 'package:manipal_app/models/pet.dart';
import 'package:manipal_app/resources/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

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
  PlatformFile? _file;

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

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = result.files.first;
      });
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
            _buildTextField('Name*', (value) => name = value!),
            _buildTextField('Species*', (value) => species = value!),
            _buildTextField('Breed*', (value) => breed = value!),
            _buildTextField('Age*', (value) => age = int.parse(value!), TextInputType.number),
            SizedBox(height: 20),
            Text(
              'Upload Insurance proof/Vet Report/Vaccination certificate*',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: _file == null
                  ? IconButton(
                      icon: Icon(Icons.upload_file, size: 50),
                      onPressed: _pickFile,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_present, size: 50, color: Colors.green),
                        SizedBox(height: 10),
                        Text(
                          'File Uploaded',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          _file?.name ?? 'Unknown file name',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add Pet'),
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved, [TextInputType? keyboardType]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: (value) => value!.isEmpty ? 'This field is required' : null,
        onSaved: onSaved,
        keyboardType: keyboardType,
      ),
    );
  }
}