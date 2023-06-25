import 'package:flutter/material.dart';
import 'package:musicapp/piano_key.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
  //     .then((_) {
  runApp(const MyApp());
  //});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Piano Demo',
      routes: {
        '/': (context) => const PianoKey(),
        'piano-key': (context) => const PianoKey(),
      },
    );
  }
}
