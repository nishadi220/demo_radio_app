import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_super_app/components/Carousal/buildChannelCard.dart';
import '../../models/radio/entities/stationEntity.dart';
import '../../providers/radioChannelProvider.dart';
import '../../models/radio/responses/getStationListResponse.dart';
import '../../providers/stationProvider.dart';
import '../../services/radioService.dart';
import '../Common/futureBuilderWidget.dart';

class RadioChannelCarousel extends StatefulWidget {
  final String? favoriteStationId;
  final Function(String) onStationChanged;

  const RadioChannelCarousel({super.key, required this.favoriteStationId, required this.onStationChanged});

  @override
  _RadioChannelCarouselState createState() => _RadioChannelCarouselState();
}

class _RadioChannelCarouselState extends State<RadioChannelCarousel> {
  int _currentIndex = 0; // Track the current index of the carousel
  List<StationEntity> _stations = []; // Store fetched station data locally

  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      Provider.of<StationProvider>(context, listen: false)
          .addListener(_onStationChanged);
    });
  }

  void _onStationChanged() {
    final stationProvider = Provider.of<StationProvider>(context, listen: false);
    final currentStationId = stationProvider.selectedStationId;
    setState(() {
      _currentIndex = _stations.indexWhere((station) => station.id == currentStationId);
    });
    _controller.jumpToPage(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {

    return _stations.isEmpty
        ? FutureBuilderWidget<GetStationListResponse>(
            future: RadioService().fetchRadioStations(),
            onSuccess: (data) {
              // Save the fetched data to the local list
              _stations = data.stations;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Find the index of the favorite station
                if (widget.favoriteStationId != null) {
                  setState(() {
                    _currentIndex = _stations.indexWhere((station) => station.id == widget.favoriteStationId);
                  });
                } else {
                  setState(() {
                    _currentIndex = 0;
                  });
                }

                widget.onStationChanged(_stations[_currentIndex].id);
              });

              return _buildCarousel();
            },
            loadingWidget: const Center(child: CircularProgressIndicator()),
            onError: (error) {
              return Center(child: Text('Error: $error'));
            },
          )
        : _buildCarousel(); // Render carousel directly when data is available
  }

  Widget _buildCarousel() {
    List<String> channels = _stations.map((station) => station.name).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                'Live Radio Stations',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 08),
        CarouselSlider(
          carouselController: _controller,
          items: _stations.map((station) {
            return InkWell(
              onTap: () {
                // Play the radio stream in mini player
                Provider.of<RadioChannelProvider>(context, listen: false)
                    .setCurrentRadioChannel(station);
                // context.push(AppRoutes.radioPage + AppRoutes.radioPlayer);
                _controller.jumpToPage(_stations.indexWhere((station1) => station1.id == station.id));
              },
              child: buildChannelCard(context, station.picUrl, station.name),
            );
          }).toList(),
          options: CarouselOptions(
            height: 160,
            initialPage: _currentIndex,
            aspectRatio: 0.45,
            animateToClosest: true,
            autoPlay: false,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: 0.36,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index; // Update the current index
              });
              final currentStation = _stations[index];
              widget.onStationChanged(currentStation.id); // Notify parent
              print('Currently centered station ID: ${currentStation.id}');
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(channels.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CircleAvatar(
                radius: 4,
                backgroundColor: index == _currentIndex ? Colors.white : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
