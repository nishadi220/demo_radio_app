import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_super_app/components/common/futureBuilderWidget.dart';
import 'package:radio_super_app/managers/sharedPreferencesManager.dart';
import 'package:radio_super_app/services/radioService.dart';
import '../../components/RadioProgramme/radioStationTile.dart';
import '../../providers/radioChannelProvider.dart';
import '../../models/radio/responses/getStationListResponse.dart';
import '../../providers/stationProvider.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  String? favoriteStationId; // Holds the name of the currently favorited station
  late Future<GetStationListResponse> _stationListResponse;

  void toggleFavorite(String stationId) {
    setState(() {
      print("favoriteStationId : $favoriteStationId");
      // Set the new favorite station, or clear it if the same station is toggled
      favoriteStationId = (favoriteStationId == stationId) ? null : stationId;
    });
    SharedPreferencesManager().setFavoriteStationId(stationId);
    Provider.of<StationProvider>(context, listen: false).setSelectedStationId(stationId);
  }

  @override
  void initState() {
    super.initState();
    _stationListResponse = RadioService().fetchRadioStations();

    SharedPreferencesManager().getFavoriteStationId().then((value) {
      favoriteStationId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFD5576E),
            Color(0xFFE68382),
            Color(0xFFF7B075),
          ],
          stops: [0.12, 0.56, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FutureBuilderWidget<GetStationListResponse>(
        future: _stationListResponse,
        onSuccess: (radioStations) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                child: Text(
                  "All Radio Stations",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: radioStations.stations.isEmpty
                    ? const Center(child: Text('No data'))
                    : ListView.builder(
                        itemCount: radioStations.stations.length,
                        itemBuilder: (context, index) {
                          final station = radioStations.stations[index];
                          return InkWell(
                            onTap: () {
                              // context.push(AppRoutes.radioPage + AppRoutes.radioPlayer);
                              Provider.of<RadioChannelProvider>(context, listen: false)
                                  .setCurrentRadioChannel(station);
                            },
                            child: RadioStationTile(
                              imagePath: station.picUrl,
                              // Adjust to match the API response
                              stationName: station.name,
                              isFavorite : station.id == favoriteStationId,
                              onFavoriteToggle: () => toggleFavorite(station.id)
                            ),
                          );
                        },
                    ),
              ),
            ],
          );
        },
        onError: (error) {
          return const Center(
              child: Text('Failed to load data, please try again.'));
        },
      ),
    );
  }
}

