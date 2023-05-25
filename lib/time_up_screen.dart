import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class TimeUpClass extends StatelessWidget {
  final AudioPlayer player;

  const TimeUpClass({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await player.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Text(
            "Time's Up",
            // style: Theme.of(context).textTheme.headlineLarge,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.blue,
                letterSpacing: .5,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
