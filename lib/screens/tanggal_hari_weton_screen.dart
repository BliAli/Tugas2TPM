import 'package:flutter/material.dart';

class TanggalHariWetonScreen extends StatefulWidget {
  const TanggalHariWetonScreen({super.key});

  @override
  State<TanggalHariWetonScreen> createState() => _TanggalHariWetonScreenState();
}

class _TanggalHariWetonScreenState extends State<TanggalHariWetonScreen> {
  DateTime? _selectedDate;
  String _hari = '';
  String _weton = '';

  final List<String> _namaHari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  final List<String> _namaPasaran = [
    'Pahing',
    'Pon',
    'Wage',
    'Kliwon',
    'Legi',
  ];

  String _getHari(DateTime date) {
    // weekday: 1=Senin, 7=Minggu
    int dayIndex = (date.weekday - 1) % 7;
    return _namaHari[dayIndex];
  }

  String _getWeton(DateTime date) {
    // Hitung pasaran (5 hari siklis)
    // Epoch = 1 Januari 1900 adalah hari Selasa Legi
    // Rumus: (total hari sejak epoch) % 5
    final epoch = DateTime(1900, 1, 1);
    final difference = date.difference(epoch).inDays;
    int pasaranIndex = difference % 5;
    String pasaran = _namaPasaran[pasaranIndex];

    // Ambil nama hari
    String hari = _getHari(date);

    return '$hari $pasaran';
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _hari = _getHari(picked);
        _weton = _getWeton(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _selectedDate != null
        ? '${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}'
        : 'Pilih tanggal';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanggal → Hari & Weton'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              color: Colors.blue[50],
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Konversi tanggal ke hari (Jawa) dan Weton',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            InkWell(
              onTap: _selectDate,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pilih Tanggal',
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
            if (_hari.isNotEmpty)
              Column(
                children: [
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text(
                            'Hari dalam Kalender Jawa:',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _hari,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 20),
                          const Text(
                            'Weton (Hari + Pasaran):',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _weton,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.amber[50],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.lightbulb_outline, color: Colors.amber[800]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pasaran berulang setiap 5 hari (Pahing, Pon, Wage, Kliwon, Legi)',
                              style: TextStyle(fontSize: 12, color: Colors.amber[900]),
                            ),
                          ),
                        ],
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
