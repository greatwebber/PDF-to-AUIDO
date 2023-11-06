import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pdfaudio/about/about_app.dart';
import 'package:pdfaudio/developer/developer_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

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

  FlutterTts flutterTts = FlutterTts();

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

  Future<void> _uploadPDF() async {
    await Permission.storage.request();
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        convertPDFToAudio(file.path!);
      } else {
        // User canceled the file picker
        print("File selection canceled.");
      }
    } catch (e) {
      // Handle any errors that may occur during file selection
      print("Error: $e");
    }
  }

  void convertPDFToAudio(String pdfFilePath) async {
    // Read the PDF content
    String pdfContent = await readPDFContent(pdfFilePath);
    print("fikls" + pdfFilePath);
    print(pdfContent);

    // Initialize TTS (Text-to-Speech) engine
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);

    // Convert the PDF content to speech
    await flutterTts.speak(pdfContent);
  }

  Future<String> readPDFContent(String pdfFilePath) async {
    PdfDocument document =
        PdfDocument(inputBytes: File(pdfFilePath).readAsBytesSync());
    String text = PdfTextExtractor(document).extractText(startPageIndex: 0);
    document.dispose();

    return text;
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
              _uploadPDF();
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
          SizedBox(height: 20),
          AudioControlWidget(flutterTts: flutterTts),
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

class AudioControlWidget extends StatefulWidget {
  final FlutterTts flutterTts;

  AudioControlWidget({required this.flutterTts});

  @override
  _AudioControlWidgetState createState() => _AudioControlWidgetState();
}

class _AudioControlWidgetState extends State<AudioControlWidget> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            if (isPlaying) {
              widget.flutterTts.stop();
            } else {
              widget.flutterTts.speak("Your PDF content here");
            }
            setState(() {
              isPlaying = !isPlaying;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            // Implement volume control logic here
            // You can use the flutterTts.setVolume() method to set the volume.
          },
        ),
        // Add more playback controls as needed (e.g., seek, rewind, fast forward, etc.)
      ],
    );
  }
}
