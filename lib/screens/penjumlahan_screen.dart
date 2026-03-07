import 'package:flutter/material.dart';

class PenjumlahanScreen extends StatefulWidget {
  const PenjumlahanScreen({super.key});

  @override
  State<PenjumlahanScreen> createState() => _PenjumlahanScreenState();
}

class _PenjumlahanScreenState extends State<PenjumlahanScreen> {
  final _angka1Controller = TextEditingController();
  final _angka2Controller = TextEditingController();
  String _hasil = '';

  void _hitung(String operasi) {
    final a = double.tryParse(_angka1Controller.text);
    final b = double.tryParse(_angka2Controller.text);

    if (a == null || b == null) {
      setState(() => _hasil = 'Masukkan angka yang valid!');
      return;
    }

    double result;
    String op;
    if (operasi == 'tambah') {
      result = a + b;
      op = '+';
    } else {
      result = a - b;
      op = '-';
    }

    // Tampilkan integer jika hasilnya bulat
    final hasilStr = result == result.roundToDouble() && result.abs() < 1e15
        ? result.toInt().toString()
        : result.toString();

    setState(() {
      _hasil = '${_formatNum(a)} $op ${_formatNum(b)} = $hasilStr';
    });
  }

  String _formatNum(double n) {
    return n == n.roundToDouble() && n.abs() < 1e15
        ? n.toInt().toString()
        : n.toString();
  }

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjumlahan & Pengurangan'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _angka1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: InputDecoration(
                labelText: 'Angka pertama',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _angka2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: InputDecoration(
                labelText: 'Angka kedua',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _hitung('tambah'),
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _hitung('kurang'),
                    icon: const Icon(Icons.remove),
                    label: const Text('Kurang'),
                  ),
                ),
              ],
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
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
