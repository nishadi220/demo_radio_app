import 'package:flutter/material.dart';
import 'package:radio_super_app/components/RadioProgramme/radioProgrammeTile.dart';
import '../../components/Common/futureBuilderWidget.dart';
import '../../components/programmeTile.dart';
import '../../components/RadioProgramme/currentPlayingWidget.dart';
import '../../configs/assets/appImages.dart';
import '../../models/radio/responses/getShowListResponse.dart';
import '../../services/radioService.dart'; // Adjust the import according to your project structure

// Define the programmes list outside of the widget class
const List<Map<String, String>> programmes = [
  {
    "imagePath": "https://i.imgur.com/YmPvyqi.png", // Use the defined constant
    "title": "YFM Hit 20",
    "genre": "",
    "description": "Welcome to suited & Booted: 2023"
  },
  {
    "imagePath": "https://i.imgur.com/Q9tyOM2.png", // Use the defined constant
    "title": "Night Style",
    "genre": "",
    "description": "Welcome to suited & Booted: 2023"
  },
  {
    "imagePath": "https://i.imgur.com/dF02Kf0.png", // Use the defined constant
    "title": "My Y FM",
    "genre": "",
    "description": "Welcome to suited & Booted: 2023"
  },
  {
    "imagePath": "https://i.imgur.com/8K3woTn.png", // Use the defined constant
    "title": "Magic Show",
    "genre": "",
    "description": "Welcome to suited & Booted: 2023"
  },
  {
    "imagePath": "https://i.imgur.com/sEhSupz.png", // Use the defined constant
    "title": "Cool",
    "genre": "",
    "description": "Welcome to suited & Booted: 2023"
  },
];

class RadioProgrammeScreen extends StatelessWidget {
  const RadioProgrammeScreen({super.key});

  final String stationId = "STA001";

  @override
  Widget build(BuildContext context) {

    // Get the screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD5576E), // Blue at 8%
              Color(0xFFE68382), // Purple at 46%
              Color(0xFFF7B075), // Pink at 100%
            ],
            stops: [0.12, 0.56, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Upcoming Programmes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              child: FutureBuilderWidget<GetShowListResponse>(
                future: RadioService().fetchRadioShowsForStation(stationId: stationId, upcomming: false),
                onSuccess: (programmeResponse) {
                  final programmes = programmeResponse.shows;
                  return programmes.isEmpty
                      ? const Center(child: Text('No upcoming programmes'))
                      : ListView.builder(
                    itemCount: programmes.length,
                    itemBuilder: (context, index) {
                      final programme = programmes[index];
                      return RadioProgrammeTile(
                        entity: programme,
                      );
                    },
                  );
                },
                onError: (error) {
                  return const Center(
                    child: Text('Failed to load data, please try again.'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
