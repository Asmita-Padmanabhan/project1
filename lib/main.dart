import 'package:flutter/material.dart';
import 'role_selection_screen.dart';

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

