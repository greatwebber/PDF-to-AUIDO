import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
      ),
      body: SingleChildScrollView(
        // Wrap your content in SingleChildScrollView
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.library_books,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "PDF to Audio Converter",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "Effortlessly convert your PDF documents into audio files and enjoy the convenience of listening on the go.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "Key Features",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                _buildFeature(
                  icon: Icons.audiotrack,
                  title: "Convert to Audio",
                  description: "Transform PDFs into audio files with ease.",
                ),
                _buildFeature(
                  icon: Icons.headset,
                  title: "Listen Anywhere",
                  description:
                      "Enjoy your documents on the go, at your convenience.",
                ),
                _buildFeature(
                  icon: Icons.settings_voice,
                  title: "Customize Playback",
                  description:
                      "Adjust voice, speed, and format for a tailored experience.",
                ),
                _buildFeature(
                  icon: Icons.insert_chart,
                  title: "User-Friendly",
                  description:
                      "Intuitive and user-friendly interface for a seamless experience.",
                ),
                // Add more features or benefits as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(
          icon,
          size: 36,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
