import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:timer/time_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 10;
  bool _isStarted = false;
  bool _isPaused = false;
  late Timer _timer;
  final player = AudioPlayer();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   player.setAsset('assets/songs/digitalAlarm.wav');
  //   super.initState();
  // }

  @override
  void dispose() {
    _timer.cancel();
    player.dispose();
    super.dispose();
  }

  void _startButtonPress() async {
    if (player.playing) {
      // Stop the player if it is already playing
      await player.stop();
    }
    await player.setAsset('assets/songs/digitalAlarm.wav');
    if (_isStarted) {
      _stopButtonPress();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_counter > 0) {
            _counter--;
            _isStarted = true;
          } else {
            player.play();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const TimeUpClass(),
            ));
            _stopButtonPress();
          }
        });
      });
    }
  }

  void _stopButtonPress() {
    _timer.cancel();
    setState(() {
      _counter = 10;
      _isStarted = false;
      _isPaused = false;
    });
  }

  void _pauseButtonPress() {
    if (_isPaused) {
      _resumeButtonPress();
    } else {
      _timer.cancel();
      setState(() {
        _isPaused = true;
      });
    }
  }

  void _resumeButtonPress() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _isPaused = false;
        if (_counter > 0) {
          _counter--;
        } else {
          player.play();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const TimeUpClass(),
          ));
          // player.play();
          _stopButtonPress();
        }
      });
    });
  }

  String _formatTime(int time) {
    int hours = (time ~/ 3600);
    int minutes = ((time ~/ 60) % 60);
    int seconds = (time % 60);

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 8.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.grey,
                      value: _counter / 10,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    _formatTime(_counter),
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        color: Colors.blue,
                        letterSpacing: .5,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                  child: ElevatedButton.icon(
                    onPressed: _startButtonPress,
                    icon: Icon(_isStarted ? Icons.stop : Icons.play_arrow),
                    label: Text(
                      _isStarted ? 'Stop' : 'Start',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // child: Text(_isStarted ? 'Stop' : 'Start'),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 130,
                  child: ElevatedButton.icon(
                    onPressed: _pauseButtonPress,
                    icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                    label: Text(
                      _isPaused ? 'Resume' : 'Pause',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
