import 'package:flutter/material.dart';

class JumlahAngkaFieldScreen extends StatefulWidget {
  const JumlahAngkaFieldScreen({super.key});

  @override
  State<JumlahAngkaFieldScreen> createState() => _JumlahAngkaFieldScreenState();
}

class _JumlahAngkaFieldScreenState extends State<JumlahAngkaFieldScreen> {
  final _controller = TextEditingController();
  String _hasil = '';

  void _hitungJumlahAngka() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() => _hasil = 'Masukkan data terlebih dahulu!');
      return;
    }

    // Ambil semua digit dari input
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      setState(() => _hasil = 'Tidak ada angka ditemukan!');
      return;
    }

    int total = 0;
    for (var ch in digits.split('')) {
      total += int.parse(ch);
    }

    setState(() {
      _hasil = 'Digit: ${digits.split('').join(' + ')} = $total';
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan angka',
                hintText: 'Contoh: 12345',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: _hitungJumlahAngka,
                icon: const Icon(Icons.functions),
                label: const Text('Hitung Jumlah Digit'),
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
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
