import 'package:flutter/material.dart';
import 'dart:async';

class HitungUmurScreen extends StatefulWidget {
  const HitungUmurScreen({super.key});

  @override
  State<HitungUmurScreen> createState() => _HitungUmurScreenState();
}

class _HitungUmurScreenState extends State<HitungUmurScreen> {
  DateTime? _selectedDate;
  Timer? _timer;
  String _hasil = '';

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _startTimer();
        _hitungUmur();
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _hitungUmur();
    });
  }

  void _hitungUmur() {
    if (_selectedDate == null) return;

    final now = DateTime.now();
    final birthDate = _selectedDate!;

    int tahun = now.year - birthDate.year;
    int bulan = now.month - birthDate.month;
    int hari = now.day - birthDate.day;
    int jam = now.hour - birthDate.hour;
    int menit = now.minute - birthDate.minute;
    int detik = now.second - birthDate.second;

    if (detik < 0) {
      menit--;
      detik += 60;
    }
    if (menit < 0) {
      jam--;
      menit += 60;
    }
    if (jam < 0) {
      hari--;
      jam += 24;
    }
    if (hari < 0) {
      bulan--;
      final prevMonth = DateTime(now.year, now.month, 0);
      hari += prevMonth.day;
    }
    if (bulan < 0) {
      tahun--;
      bulan += 12;
    }

    setState(() {
      _hasil =
          '📅 $tahun tahun\n'
          '📆 $bulan bulan\n'
          '📊 $hari hari\n'
          '🕐 $jam jam\n'
          '⏲️ $menit menit\n'
          '⏱️ $detik detik';
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _selectedDate != null
        ? '${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}'
        : 'Pilih tanggal lahir';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Umur'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              color: Colors.orange[50],
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Hitung umur Anda secara real-time dari tanggal lahir hingga sekarang',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: _selectDate,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.cake, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tanggal Lahir',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_hasil.isNotEmpty)
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Umur Anda:',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _hasil,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
