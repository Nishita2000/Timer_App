import 'package:flutter/material.dart';

class TimeUpClass extends StatelessWidget {
  const TimeUpClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Time's Up",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
