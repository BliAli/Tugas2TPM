import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Timer? _timer;
  bool _isRunning = false;
  int _totalSeconds = 0; // total elapsed seconds

  final _jamController = TextEditingController(text: '0');
  final _menitController = TextEditingController(text: '0');
  final _detikController = TextEditingController(text: '0');

  final List<String> _laps = [];

  void _startStop() {
    if (_isRunning) {
      // Pause
      _timer?.cancel();
      setState(() => _isRunning = false);
    } else {
      // Start: jika belum pernah jalan, ambil dari input
      if (_totalSeconds == 0) {
        final jam = int.tryParse(_jamController.text) ?? 0;
        final menit = int.tryParse(_menitController.text) ?? 0;
        final detik = int.tryParse(_detikController.text) ?? 0;
        _totalSeconds = (jam * 3600) + (menit * 60) + detik;
      }
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          _totalSeconds++;
        });
      });
      setState(() => _isRunning = true);
    }
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _totalSeconds = 0;
      _laps.clear();
      _jamController.text = '0';
      _menitController.text = '0';
      _detikController.text = '0';
    });
  }

  void _lap() {
    if (_isRunning) {
      setState(() {
        _laps.add(_formatSeconds(_totalSeconds));
      });
    }
  }

  String _formatSeconds(int totalSec) {
    final hari = totalSec ~/ 86400;
    final sisaHari = totalSec % 86400;
    final jam = sisaHari ~/ 3600;
    final sisaJam = sisaHari % 3600;
    final menit = sisaJam ~/ 60;
    final detik = sisaJam % 60;

    if (hari > 0) {
      return '$hari hari, ${jam.toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')}:${detik.toString().padLeft(2, '0')}';
    }
    return '${jam.toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')}:${detik.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _jamController.dispose();
    _menitController.dispose();
    _detikController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _formatSeconds(_totalSeconds);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          // Input waktu mulai
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Waktu Mulai',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _jamController,
                            enabled: !_isRunning && _totalSeconds == 0,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'Jam',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(':', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _menitController,
                            enabled: !_isRunning && _totalSeconds == 0,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'Menit',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(':', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _detikController,
                            enabled: !_isRunning && _totalSeconds == 0,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'Detik',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Timer display
          Text(
            displayText,
            style: const TextStyle(
              fontSize: 48,
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
                  backgroundColor: _isRunning ? Colors.red : Colors.green,
                ),
                child: Icon(
                  _isRunning ? Icons.pause : Icons.play_arrow,
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
