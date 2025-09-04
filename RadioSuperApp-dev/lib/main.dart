import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:radio_super_app/providers/playerEpisodeProvider.dart';
import 'package:radio_super_app/providers/stationProvider.dart';
import 'package:radio_super_app/router/appRouter.dart';
import 'package:radio_super_app/services/chatLoginService.dart';

import 'managers/sharedPreferencesManager.dart';
import 'models/login/requests/insertGuestRequest.dart';
import 'providers/radioChannelProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RadioChannelProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StationProvider(),
        ),
        ChangeNotifierProvider(
            create: (_) => PlayerEpisodeProvider()
        )
      ],
      child: const RadioApp(),
    ));
  });

  final deviceId = await SharedPreferencesManager().getDeviceId();
  if (deviceId.isEmpty) {
    // Fetch Device info
    final uuid = await getDeviceUUID();
    if (uuid != null) {
      SharedPreferencesManager().setDeviceId(uuid);
      final response = await ChatLoginService().insertGuest(insertGuestRequest: InsertGuestRequest(guestId: uuid, languageId: 1));
      if (response != null) {
        SharedPreferencesManager().setDeviceIdIUpdated(true);
      }
    } else {
      print('Could not fetch device UUID.');
    }
  }
}

Future<String?> getDeviceUUID() async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    // Android-specific implementation
    final androidInfo = await deviceInfoPlugin.androidInfo;
    return androidInfo.id;
  } else if (Platform.isIOS) {
    // iOS-specific implementation
    final iosInfo = await deviceInfoPlugin.iosInfo;
    return iosInfo.identifierForVendor;
  } else {
    // Handle other platforms or unsupported devices
    return null;
  }
}

class RadioApp extends StatelessWidget {
  const RadioApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );

  }
}

