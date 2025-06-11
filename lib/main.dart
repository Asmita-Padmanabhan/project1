import 'package:flutter/material.dart';
import 'role_selection_screen.dart';
import 'artist_profile_screen.dart' as artist_profile;
import 'audience_profile_screen.dart' as audience_profile;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:country_picker/country_picker.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Artist Connect',
      theme: ThemeData(
        primarySwatch: Colors.green, // Fixed: primarySwatch must be a MaterialColor
      ),
      home: ChoiceScreen(),
    );
  }
}

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA), // ivory
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ARTIST CONNECT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B2E2E),
                  fontFamily: 'Savate',
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B2E2E),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6, // shadow for depth
                  shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                ).copyWith(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                        return Color(0xFF9C3D3D); // lighter maroon on hover/press
                      }
                      return null;
                    },
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_add_alt_1, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'SIGN UP',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B2E2E),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                ).copyWith(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                        return Color(0xFF9C3D3D);
                      }
                      return null;
                    },
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String mobile = '';
  String username = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed up as $username')),
      );
      // Proceed to next page or save to DB
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA), // ivory
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ARTIST CONNECT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B2E2E),
                    fontFamily: 'Savate',
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'NAME',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.person, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your name' : null,
                        onSaved: (value) => name = value!,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'MOBILE NUMBER',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.phone, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit number';
                          }
                          return null;
                        },
                        onSaved: (value) => mobile = value!,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'USERNAME',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.account_circle, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) =>
                            value!.isEmpty ? 'Please choose a username' : null,
                        onSaved: (value) => username = value!,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.lock, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a password' : null,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7B2E2E),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                          shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                        ).copyWith(
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                                return Color(0xFF9C3D3D);
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person_add_alt_1, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'SIGN UP',
                              style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged in with phone number $phoneNumber')),
      );
      // Proceed to next page or authentication
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA), // ivory
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOGIN NOW',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B2E2E),
                    fontFamily: 'AmaticSC',
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'PHONE NUMBER',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.phone, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit number';
                          }
                          return null;
                        },
                        onSaved: (value) => phoneNumber = value!,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.lock, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your password' : null,
                        onSaved: (value) => password = value!,
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          // Navigate to forgot password screen (to be implemented)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Forgot password not implemented yet')),
                          );
                        },
                        child: Text(
                          'FORGOT PASSWORD?',
                          style: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', letterSpacing: 1.2),
                        ),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7B2E2E),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                          shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                        ).copyWith(
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                                return Color(0xFF9C3D3D);
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock, color: Colors.white),
                            SizedBox(width: 10),
                            Text('LOGIN', style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2)),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phoneNumber = '';
  String username = '';
  String password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RoleSelectionScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed up as $username')),
      );
      // Proceed to next page or save to DB
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA), // ivory
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SIGN UP NOW',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B2E2E),
                    fontFamily: 'AmaticSC',
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'NAME',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.person, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your name' : null,
                        onSaved: (value) => name = value!,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'MOBILE NUMBER',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.phone, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit number';
                          }
                          return null;
                        },
                        onSaved: (value) => phoneNumber = value!,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'USERNAME',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.account_circle, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) =>
                            value!.isEmpty ? 'Please choose a username' : null,
                        onSaved: (value) => username = value!,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold), // maroon
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0), // maroon
                          ),
                          prefixIcon: Icon(Icons.lock, color: Color(0xFF7B2E2E)), // maroon
                        ),
                        style: TextStyle(color: Color(0xFF222222)),
                        cursorColor: Color(0xFF7B2E2E), // maroon
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a password' : null,
                        onSaved: (value) => password = value!,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7B2E2E),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                          shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                        ).copyWith(
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                                return Color(0xFF9C3D3D);
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person_add_alt_1, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'SIGN UP',
                              style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CHOOSE YOUR ROLE',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B2E2E),
                  fontFamily: 'AmaticSC',
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => artist_profile.ArtistProfileScreen()),
                      );
                    },
                    icon: Icon(Icons.brush, color: Colors.white),
                    label: Text(
                      'ARTIST',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7B2E2E),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                    ).copyWith(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                            return Color(0xFF9C3D3D);
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => audience_profile.AudienceProfileScreen()),
                      );
                    },
                    icon: Icon(Icons.headset, color: Colors.white),
                    label: Text(
                      'AUDIENCE',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7B2E2E),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                    ).copyWith(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                            return Color(0xFF9C3D3D);
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ArtistProfileScreen changes
class ArtistProfileScreen extends StatefulWidget {
  const ArtistProfileScreen({super.key});

  @override
  State<ArtistProfileScreen> createState() => _ArtistProfileScreenState();
}

class _ArtistProfileScreenState extends State<ArtistProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA),
      appBar: AppBar(
        title: Text('Artist Profile', style: TextStyle(fontFamily: 'AmaticSC', fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF7B2E2E),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            GestureDetector(
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
            SizedBox(height: 12),
            Text('Tap to add profile picture', style: TextStyle(fontFamily: 'AmaticSC', fontWeight: FontWeight.bold, color: Color(0xFF7B2E2E))),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'STAGE NAME',
                      labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.star, color: Color(0xFF7B2E2E)),
                    ),
                    style: TextStyle(color: Color(0xFF222222)),
                    cursorColor: Color(0xFF7B2E2E),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'BIOGRAPHY',
                      labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.info, color: Color(0xFF7B2E2E)),
                    ),
                    style: TextStyle(color: Color(0xFF222222)),
                    cursorColor: Color(0xFF7B2E2E),
                    maxLines: 3,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Save profile action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7B2E2E),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                    ).copyWith(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                            return Color(0xFF9C3D3D);
                          }
                          return null;
                        },
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.save, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'SAVE PROFILE',
                          style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// AudienceProfileScreen changes
class AudienceProfileScreen extends StatefulWidget {
  const AudienceProfileScreen({super.key});

  @override
  State<AudienceProfileScreen> createState() => _AudienceProfileScreenState();
}

class _AudienceProfileScreenState extends State<AudienceProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA),
      appBar: AppBar(
        title: Text('Audience Profile', style: TextStyle(fontFamily: 'AmaticSC', fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF7B2E2E),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            GestureDetector(
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
            SizedBox(height: 12),
            Text('Tap to add profile picture', style: TextStyle(fontFamily: 'AmaticSC', fontWeight: FontWeight.bold, color: Color(0xFF7B2E2E))),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'FAVORITE GENRE',
                      labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.music_note, color: Color(0xFF7B2E2E)),
                    ),
                    style: TextStyle(color: Color(0xFF222222)),
                    cursorColor: Color(0xFF7B2E2E),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'BIOGRAPHY',
                      labelStyle: TextStyle(color: Color(0xFF7B2E2E), fontFamily: 'AmaticSC', fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF7B2E2E), width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.info, color: Color(0xFF7B2E2E)),
                    ),
                    style: TextStyle(color: Color(0xFF222222)),
                    cursorColor: Color(0xFF7B2E2E),
                    maxLines: 3,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Save profile action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7B2E2E),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                    ).copyWith(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                            return Color(0xFF9C3D3D);
                          }
                          return null;
                        },
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.save, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'SAVE PROFILE',
                          style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

