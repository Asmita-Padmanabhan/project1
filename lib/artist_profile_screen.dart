import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ArtistProfileScreen extends StatefulWidget {
  const ArtistProfileScreen({super.key});

  @override
  _ArtistProfileScreenState createState() => _ArtistProfileScreenState();
}

class _ArtistProfileScreenState extends State<ArtistProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String stageName = '';
  String genre = '';
  String instrument = '';
  String bio = '';

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
        SnackBar(content: Text('Artist profile created for $stageName!')),
      );
      // Navigate to main app dashboard or home screen here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA),
      appBar: AppBar(
        title: Text('Create Artist Profile', style: TextStyle(color: Color(0xFF7B2E2E))),
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
                  labelText: 'Stage Name',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                  ),
                  fillColor: Color(0xFFF5E9DA),
                  filled: true,
                ),
                validator: (value) => value!.isEmpty ? 'Enter your stage name' : null,
                onSaved: (value) => stageName = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Genre (Carnatic/Bharatanatyam)',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                  ),
                  fillColor: Color(0xFFF5E9DA),
                  filled: true,
                ),
                validator: (value) => value!.isEmpty ? 'Enter your genre' : null,
                onSaved: (value) => genre = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Instrument (if any)',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                  ),
                  fillColor: Color(0xFFF5E9DA),
                  filled: true,
                ),
                onSaved: (value) => instrument = value ?? '',
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Short Bio',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                  ),
                  fillColor: Color(0xFFF5E9DA),
                  filled: true,
                ),
                maxLines: 3,
                onSaved: (value) => bio = value ?? '',
              ),
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
