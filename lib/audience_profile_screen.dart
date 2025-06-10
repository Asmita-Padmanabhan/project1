import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class AudienceProfileScreen extends StatefulWidget {
  const AudienceProfileScreen({super.key});

  @override
  _AudienceProfileScreenState createState() => _AudienceProfileScreenState();
}

class _AudienceProfileScreenState extends State<AudienceProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String city = '';
  List<String> topArtists = List.filled(5, '');
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _submitProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Audience profile created for $name!')),
      );
      // Navigate to main app dashboard or home screen here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA),
      appBar: AppBar(
        title: Text('Create Audience Profile', style: TextStyle(color: Color(0xFF7B2E2E))),
        backgroundColor: Color(0xFFF5E9DA),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF7B2E2E)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 12),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF7B2E2E).withOpacity(0.2),
                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? Icon(Icons.camera_alt, size: 40, color: Color(0xFF7B2E2E))
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text('Tap to add profile picture', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'AmaticSC', fontWeight: FontWeight.bold, color: Color(0xFF7B2E2E))),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => name = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Preferred City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter your city' : null,
                onSaved: (value) => city = value!,
              ),
              SizedBox(height: 16),
              Text(
                'Top 5 Favorite Artists',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B2E2E)),
              ),
              ...List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Artist ${index + 1}',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => topArtists[index] = value ?? '',
                  ),
                );
              }),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B2E2E),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Create Profile', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
