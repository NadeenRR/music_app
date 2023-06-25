import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano/piano.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'dart:typed_data';

import 'package:url_launcher/url_launcher.dart';

class PianoKey extends StatefulWidget {
  const PianoKey({super.key});

  @override
  State<PianoKey> createState() => _PianoKeyState();
}

List<String> list = <String>['Guitars', 'Yamaha', 'SOO'];

class _PianoKeyState extends State<PianoKey> {
  final FlutterMidi flutterMidi = FlutterMidi();
  //String path = 'assets/sf2/Yamaha-Grand-Lite-SF-v1.1.sf2';
  String? choice;

  @override
  void initState() {
    load('assets/sf2/guitars.sf2');
    super.initState();
  }

  void load(String asset) async {
    flutterMidi.unmute();
    ByteData byte = await rootBundle.load(asset);
    flutterMidi.prepare(
        sf2: byte, name: 'assets/sf2/$choice.sf2'.replaceAll('assets/', ''));
  }

  final Uri _url = Uri.parse('https://flutter.dev');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Piano'),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.info),
            onPressed: _launchUrl,
          ),
          actions: [
            DropdownButton(
              dropdownColor: Colors.black,
              value: choice ?? 'Guitars',
              elevation: 16,
              style: const TextStyle(color: Colors.white),
              items: const [
                DropdownMenuItem(
                  child: Text('Guitars'),
                  value: 'Guitars',
                ),
                DropdownMenuItem(
                  child: Text('Yamaha'),
                  value: 'Yamaha',
                ),
                const DropdownMenuItem(
                  child: Text('SOO'),
                  value: 'SOO',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  choice = value;
                });
                // flutterMidi.stopMidiNote();
                load('assets/$choice.sf2');
              },
            )
          ],
        ),
        body: Center(
          child: InteractivePiano(
            highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
            naturalColor: Colors.white,
            accidentalColor: Colors.black,
            keyWidth: 60,
            noteRange: NoteRange.forClefs([
              Clef.Bass,
              //Clef.Alto,
              //Clef.Treble,
            ]),
            onNotePositionTapped: (position) {
              // Use an audio library like flutter_midi to play the sound
              print(position.pitch);
              flutterMidi.playMidiNote(midi: position.pitch);

              // flutterMidi.stopMidiNote(midi: 60);
            },
          ),
        ),
      ),
    );
  }
}
