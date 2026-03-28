import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class KonversiHijriahScreen extends StatefulWidget {
  const KonversiHijriahScreen({super.key});

  @override
  State<KonversiHijriahScreen> createState() => _KonversiHijriahScreenState();
}

class _KonversiHijriahScreenState extends State<KonversiHijriahScreen> {
  DateTime? _selectedDate;
  String _hasil = '';

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _konversi();
      });
    }
  }

  void _konversi() {
    if (_selectedDate == null) return;
    final h = HijriCalendar.fromDate(_selectedDate!);

    setState(() {
      _hasil =
          '${_selectedDate!.day} ${_getMonth(_selectedDate!.month)} ${_selectedDate!.year} =\n'
          '${h.hDay} ${h.getLongMonthName()} ${h.hYear} H';
    });
  }

  String _getMonth(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _selectedDate != null
        ? '${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}'
        : 'Pilih tanggal Masehi';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Masehi → Hijriah'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              color: Colors.green[50],
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Konversi tanggal dari Kalender Masehi ke Hijriah',
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
                      Icon(Icons.calendar_month, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tanggal Masehi',
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
                    children: [
                      const Text(
                        'Hasil Konversi:',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _hasil,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
            Card(
              color: Colors.teal[50],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.teal[800]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tahun Hijriah lebih pendek ~11 hari dari tahun Masehi',
                        style: TextStyle(fontSize: 12, color: Colors.teal[900]),
                      ),
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
