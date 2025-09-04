import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radio_player/radio_player.dart';
import 'package:radio_super_app/components/Common/contentCard.dart';
import 'package:radio_super_app/components/contentModal.dart';
import 'package:radio_super_app/managers/sharedPreferencesManager.dart';
import 'package:radio_super_app/models/radio/requests/getCurrentShowByStationRequest.dart';
import 'package:radio_super_app/models/radio/responses/getShowByStation.dart';
import 'package:radio_super_app/router/appRoutes.dart';
import 'package:radio_super_app/services/radioService.dart';
import '../../models/radio/entities/stationEntity.dart';
import '../../providers/radioChannelProvider.dart';
import '../../router/wrappers/ChatScreenArgs.dart';

class SuperRadioPlayer extends StatefulWidget {
  final RadioPlayer radioPlayer;
  final bool isPlaying;
  final VoidCallback onShowsButtonTapped;
  final LinearGradient gradient;

  const SuperRadioPlayer({
    super.key,
    required this.radioPlayer,
    required this.isPlaying,
    required this.onShowsButtonTapped,
    required this.gradient
  });

  @override
  State<SuperRadioPlayer> createState() => _SuperRadioPlayerState();
}

class _SuperRadioPlayerState extends State<SuperRadioPlayer> {

  GetShowByStationResponse? _currentShowResponse;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getCurrentShow(StationEntity? currentChannel) async {
    if (currentChannel == null) {
      return;
    }

    try {
      // Get the current local time
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm:ss').format(now); // Format

      // Request object
      final request = GetCurrentShowByStationRequest(stationId: currentChannel.id, currentTime: formattedTime);

      // Fetch the current show
      final response = await RadioService().fetchCurrentShowByStation(request: request);
      setState(() {
        _currentShowResponse = response;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching current show: $error');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final radioProvider = Provider.of<RadioChannelProvider>(context);
    final currentChannel = radioProvider.currentRadioChannel;

    if (currentChannel != null && _currentShowResponse == null) {
      getCurrentShow(currentChannel);
    }

    return Container(
      decoration: const BoxDecoration(
        gradient:
        //widget.gradient
        LinearGradient(
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
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentChannel?.name ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: screenWidth * 0.75,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(21)),
                  color: Color(0xEEFFFFFF),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(21)),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      currentChannel?.picUrl.replaceAll('Low', "High") ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                _currentShowResponse?.showName ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _currentShowResponse?.description ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ContentModal(
                              imagePath: currentChannel!.picUrl,
                              title: currentChannel.name,
                              description: currentChannel.description,
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.info_outline, color: Colors.white, size: 28),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.isPlaying ? widget.radioPlayer.stop() : widget.radioPlayer.play();
                      },
                      icon: Icon(
                        widget.isPlaying ? Icons.stop : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onShowsButtonTapped,
                      icon: const Icon(Icons.list, color: Colors.white, size: 28),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_currentShowResponse == null) {
                    // show alert dialog.
                    _showErrorDialog("No show data available.");
                    return;
                  }

                  final userId = await SharedPreferencesManager().getUserId();
                  final args = ChatScreenArgs(
                    stationEntity: currentChannel!,
                    currentShow: _currentShowResponse!,
                  );
                  if (userId.isNotEmpty) {
                    GoRouter.of(context).push(AppRoutes.chatScreen, extra: args);
                  } else {
                    GoRouter.of(context).push(AppRoutes.chatLogin, extra:args);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.05), // Semi-transparent background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Rounded corners
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2.0
                    )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Button size
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  child: Text(
                      'CHAT WITH HOST',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
