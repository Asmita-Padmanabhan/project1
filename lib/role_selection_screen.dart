import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E9DA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'I am an...',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B2E2E),
                  fontFamily: 'AmaticSC',
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                icon: Icon(Icons.mic, color: Colors.white),
                label: Text(
                  'ARTIST',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'AmaticSC',
                    letterSpacing: 1.2,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B2E2E),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                ),
                onPressed: () {
                  // Navigate to Artist Profile Creation
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArtistProfileScreen()),
                  );
                },
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                icon: Icon(Icons.headphones, color: Colors.white),
                label: Text(
                  'AUDIENCE',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'AmaticSC',
                    letterSpacing: 1.2,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B2E2E),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Color(0xFF7B2E2E).withOpacity(0.4),
                ),
                onPressed: () {
                  // Navigate to Audience Profile Creation
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AudienceProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder screens for profile creation
class ArtistProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Artist Profile Creation')),
    );
  }
}

class AudienceProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Audience Profile Creation')),
    );
  }
}
