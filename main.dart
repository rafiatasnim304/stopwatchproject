import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer & Stopwatch',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const TimerStopwatchPage(),
    );
  }
}

class TimerStopwatchPage extends StatelessWidget {
  const TimerStopwatchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Timer & Stopwatch'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Countdown Timer"),
              Tab(text: "Stopwatch"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CountdownTimer(),
            StopwatchWidget(),
          ],
        ),
      ),
    );
  }
}

// Countdown Timer
class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _start = 60;
  Timer? _timer;

  void startTimer() {
    if (_timer != null) _timer!.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() => _start--);
      }
    });
  }

  void resetTimer() {
    if (_timer != null) _timer!.cancel();
    setState(() => _start = 60);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$_start", style: const TextStyle(fontSize: 50)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: startTimer, child: const Text("Start")),
        ElevatedButton(onPressed: resetTimer, child: const Text("Reset")),
      ],
    );
  }
}

// Stopwatch
class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});
  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  void startStopwatch() {
    stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {});
    });
  }

  void stopStopwatch() {
    stopwatch.stop();
    _timer?.cancel();
  }

  void resetStopwatch() {
    stopwatch.reset();
    setState(() {});
  }

  String formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    int hours = (minutes / 60).floor();

    return "${hours.toString().padLeft(2, '0')}:"
        "${(minutes % 60).toString().padLeft(2, '0')}:"
        "${(seconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(formatTime(stopwatch.elapsedMilliseconds),
            style: const TextStyle(fontSize: 40)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: startStopwatch, child: const Text("Start")),
        ElevatedButton(onPressed: stopStopwatch, child: const Text("Stop")),
        ElevatedButton(onPressed: resetStopwatch, child: const Text("Reset")),
      ],
    );
  }
}
