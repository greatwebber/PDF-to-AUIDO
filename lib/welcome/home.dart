import 'package:flutter/material.dart';
import 'package:pdfaudio/about/about_app.dart';
import 'package:pdfaudio/developer/developer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> recentFiles = [
    "Document.pdf",
    "Presentation.pdf",
    "Report.pdf",
  ];

  int _selectedIndex = 1; // Initially set "Upload" as the active item

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToDeveloperScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DeveloperScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Convert PDF to Audio",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // Implement the PDF upload functionality here
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.add,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Upload PDF",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Text(
            "Recent Files",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: recentFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.picture_as_pdf),
                  title: Text(recentFiles[index]),
                  onTap: () {
                    // Implement the PDF viewing functionality here
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
                size: 40), // Larger plus icon for the middle item
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Developer',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            // Check if the "About" item is selected
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AboutAppScreen(),
            ));
          } else if (index == 2) {
            // Check if the "Developer" item is selected
            _navigateToDeveloperScreen(context);
          } else {
            _onItemTapped(
                index); // Handle other items based on your existing logic
          }
        },

        selectedItemColor: Colors.blue, // Color for the active item
      ),
    );
  }
}
