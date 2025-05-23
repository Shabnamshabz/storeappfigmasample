import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String? _pickedImageUrl;

  void _pickImage() {
    setState(() {
      if (_pickedImageUrl == null) {
        _pickedImageUrl = 'https://i.pravatar.cc/150?img=5';
      } else {
        _pickedImageUrl = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MITT KONTO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First black ListTile with standard height
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(0, 3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 24, // smaller radius for standard ListTile size
                    backgroundImage: _pickedImageUrl != null
                        ? NetworkImage(_pickedImageUrl!)
                        : null,
                    backgroundColor: Colors.grey[850],
                    child: _pickedImageUrl == null
                        ? const Icon(Icons.camera_alt, color: Colors.white, size: 24)
                        : null,
                  ),
                ),
                title: const Text(
                  'MITT KONTO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // so it doesn’t take extra vertical space
                  children: const [
                    SizedBox(height: 4),
                    Text(
                      'your.email@example.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '+46 XXXXXXXXXX',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Other ListTiles
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black, size: 28),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              title: const Text(
                'kontoinstallningar',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.photo, color: Colors.black, size: 28),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              title: const Text(
                'Mina betalmetoder',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.sports_soccer, color: Colors.black, size: 28),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              title: const Text(
                'support',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
