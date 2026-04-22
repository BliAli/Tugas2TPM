import 'package:flutter/material.dart';

class JumlahAngkaFieldScreen extends StatefulWidget {
  const JumlahAngkaFieldScreen({super.key});

  @override
  State<JumlahAngkaFieldScreen> createState() => _JumlahAngkaFieldScreenState();
}

class _JumlahAngkaFieldScreenState extends State<JumlahAngkaFieldScreen> {
  final _controller = TextEditingController();
  String _hasil = '';
  List<String> _angkaDitemukan = [];

  void _hitungJumlahAngka() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        _hasil = 'Masukkan teks terlebih dahulu!';
        _angkaDitemukan = [];
      });
      return;
    }

    // Ambil setiap digit (0-9) secara individual dari teks
    final digits = input.split('').where((ch) => RegExp(r'\d').hasMatch(ch)).toList();

    if (digits.isEmpty) {
      setState(() {
        _hasil = 'Tidak ada angka ditemukan dalam teks!';
        _angkaDitemukan = [];
      });
      return;
    }

    setState(() {
      _angkaDitemukan = digits;
      _hasil = 'Ditemukan ${digits.length} angka dalam teks';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jumlah Angka Field'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Masukkan teks',
                hintText: 'Contoh: Saya mau makan 4 buah di kamar 12',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: _hitungJumlahAngka,
                icon: const Icon(Icons.search),
                label: const Text('Hitung Jumlah Angka'),
              ),
            ),
            const SizedBox(height: 32),
            if (_hasil.isNotEmpty)
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text('Hasil:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text(
                        _hasil,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      if (_angkaDitemukan.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 8),
                        const Text(
                          'Angka yang ditemukan:',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _angkaDitemukan
                              .map((angka) => Chip(
                                    label: Text(
                                      angka,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    backgroundColor: Colors.blue[100],
                                  ))
                              .toList(),
                        ),
                      ],
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
