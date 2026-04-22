import 'package:flutter/material.dart';

class KonversiSakaScreen extends StatefulWidget {
  const KonversiSakaScreen({super.key});

  @override
  State<KonversiSakaScreen> createState() => _KonversiSakaScreenState();
}

class _KonversiSakaScreenState extends State<KonversiSakaScreen> {
  DateTime? _selectedDate;
  String _hasil = '';


  // Nama-nama bulan Saka (Sasih Bali)
  static const List<String> _bulanSaka = [
    'Kasa',     // 1
    'Karo',     // 2
    'Katiga',   // 3
    'Kapat',    // 4
    'Kalima',   // 5
    'Kanem',    // 6
    'Kapitu',   // 7
    'Kawalu',   // 8
    'Kasanga',  // 9
    'Kadasa',   // 10
    'Jyestha',  // 11
    'Sadha',    // 12
  ];

  static const List<String> _bulanMasehi = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

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

    final date = _selectedDate!;

    // Tahun Saka dimulai dari 78 M
    // Tahun baru Saka (Nyepi) jatuh sekitar Maret-April
    // Jika sebelum Nyepi (~Maret), masih tahun Saka sebelumnya
    int tahunSaka;
    if (date.month < 3) {
      // Sebelum Maret: masih tahun Saka = Gregorian - 79
      tahunSaka = date.year - 79;
    } else if (date.month == 3 && date.day < 15) {
      // Awal Maret: kemungkinan masih tahun Saka sebelumnya
      // (Nyepi biasanya jatuh di pertengahan Maret atau setelahnya)
      tahunSaka = date.year - 79;
    } else {
      // Setelah pertengahan Maret: tahun Saka baru
      tahunSaka = date.year - 78;
    }

    // Perkiraan bulan Saka berdasarkan bulan Masehi
    // Tahun baru Saka dimulai ~Maret/April (bulan Kadasa/ke-10)
    // Mapping perkiraan: Maret→Kadasa(10), April→Jyestha(11), dst.
    final Map<int, int> bulanMapping = {
      1: 8,   // Januari  → Kawalu (8)
      2: 9,   // Februari → Kasanga (9)
      3: 10,  // Maret    → Kadasa (10)
      4: 11,  // April    → Jyestha (11)
      5: 12,  // Mei      → Sadha (12)
      6: 1,   // Juni     → Kasa (1)
      7: 2,   // Juli     → Karo (2)
      8: 3,   // Agustus  → Katiga (3)
      9: 4,   // September→ Kapat (4)
      10: 5,  // Oktober  → Kalima (5)
      11: 6,  // November → Kanem (6)
      12: 7,  // Desember → Kapitu (7)
    };

    final indexSasih = bulanMapping[date.month]!;
    final namaSasih = _bulanSaka[indexSasih - 1];

    setState(() {
      _hasil =
          '${date.day} ${_bulanMasehi[date.month - 1]} ${date.year} M\n'
          '≈\n'
          'Sasih $namaSasih, Tahun $tahunSaka Saka';


    });
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _selectedDate != null
        ? '${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}'
        : 'Pilih tanggal Masehi';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Tahun Saka'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

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

          ],
        ),
      ),
    );
  }
}
