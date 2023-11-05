import 'package:flutter/material.dart';
import 'package:pdfaudio/models/developer.dart';

class DeveloperList extends StatelessWidget {
  final List<Developer> developers;

  DeveloperList({required this.developers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: developers.length,
      itemBuilder: (context, index) {
        return DeveloperCard(developer: developers[index]);
      },
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final Developer developer;

  DeveloperCard({required this.developer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder<String?>(
              future: _fetchImage(), // Replace with your image fetching logic
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ); // Display a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final imageUrl =
                      snapshot.data ?? ''; // Use a default empty string if null
                  return ClipOval(
                    // Wrap the image with ClipOval
                    child: Image.network(
                      imageUrl, // Use the fetched image URL (with default value)
                      height: 100, // Set a smaller height
                      width: 100, // Set a smaller width
                      fit: BoxFit.cover,
                    ),
                  );
                }
              },
            ),
            ListTile(
              title: Text(
                developer.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Matric No: " + developer.matricNo),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _fetchImage() async {
    // Replace this with your image fetching logic, e.g., using a network request
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    return developer.profilePicture; // Replace with the actual image URL
  }
}
