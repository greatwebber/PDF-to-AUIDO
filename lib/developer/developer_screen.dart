import 'package:flutter/material.dart';
import 'package:pdfaudio/developer/developer_list.dart';
import 'package:pdfaudio/models/developer.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Developer Profiles"),
      ),
      body: DeveloperList(
        developers: [
          Developer("Salaudeen Abdulbaki olamilekan", "CS20210203205",
              "https://www.federalpolyede.edu.ng/passport/RegCS20210203205.jpg"),
          Developer("Jane Smith", "HC20220104922",
              "https://www.federalpolyede.edu.ng/passport/RegHC20220104922.jpg"),
          Developer("Robert Johnson", "HC20220104922",
              "https://www.federalpolyede.edu.ng/passport/RegHC20220104922.jpg"),
          // Add more developers here
        ],
      ),
    );
  }
}
