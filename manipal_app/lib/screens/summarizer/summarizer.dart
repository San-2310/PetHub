import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:manipal_app/components/colors.dart';
import 'dart:convert';

class SummarizerScreen extends StatefulWidget {
  @override
  _SummarizerScreenState createState() => _SummarizerScreenState();
}

class _SummarizerScreenState extends State<SummarizerScreen> {
  int _selectedIndex = 2; // Set to 2 for the home icon
  File? _file;
  String _summary = '';
  bool _isLoading = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  Future<void> _analyzePdf() async {
    if (_file == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse(
          'https://8ac1-2409-40c0-105f-b7a7-45d5-a4de-ac60-cb3a.ngrok-free.app/analyze_medical_reports');

      var request = http.MultipartRequest('POST', url);
      // Add the file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'files',
      _file!.path,
      filename: path.basename(_file!.path),
    ));

    // Add headers
    var headers = {
      "Content-Type": "multipart/form-data",
      // Add other headers if necessary
    };
    request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Parse the JSON response and extract the "analysis" field
        var jsonResponse = json.decode(response.body);
        setState(() {
          _summary = jsonResponse['analysis'] ?? 'No summary available';
        });
      } else {
        throw Exception('Failed to analyze PDF');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        actions: [
          IconButton(
            icon: Icon(Icons.light_mode),
            onPressed: () {
              // Implement theme toggle
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Implement notifications
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (_summary.isEmpty ? _buildUploadScreen() : _buildSummaryScreen()),
    );
  }

  Widget _buildUploadScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.upload_file, size: 50),
              onPressed: _pickFile,
            ),
          ),
          SizedBox(height: 20),
          Text('Upload File Here', style: TextStyle(fontSize: 18)),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.mediumGreen,
                  AppColors.mediumGreen,
                  AppColors.mediumGreen,
                  AppColors.mediumGreen,
                  AppColors.paleGreen,
                  AppColors.paleGreen,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: _file != null ? _analyzePdf : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors
                    .transparent, // Make button background transparent to show gradient
                shadowColor: Colors
                    .transparent, // Disable shadow to avoid conflicting with gradient
              ),
              child: Text('Proceed'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Text(_summary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
