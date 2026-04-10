import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final List<String> _laps = [];

  void _startStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(minutes: 30), (_) {
        setState(() {});
      });
    }
    setState(() {});
  }

  void _reset() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    setState(() {
      _laps.clear();
    });
  }

  void _lap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.add(_formatDuration(_stopwatch.elapsed));
      });
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final millis = (d.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$millis';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          // Timer display
          Text(
            _formatDuration(_stopwatch.elapsed),
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w300,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 32),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.grey[300],
                ),
                child: const Icon(Icons.refresh, color: Colors.black),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _startStop,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28),
                  backgroundColor: _stopwatch.isRunning ? Colors.red : Colors.green,
                ),
                child: Icon(
                  _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _lap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.blue[100],
                ),
                child: const Icon(Icons.flag, color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Lap list
          if (_laps.isNotEmpty)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _laps.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 14,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    title: Text(
                      _laps[index],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Text('Lap'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
