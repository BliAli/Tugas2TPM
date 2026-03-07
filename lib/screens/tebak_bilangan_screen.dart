import 'package:flutter/material.dart';
import 'dart:math';

class TebakBilanganScreen extends StatefulWidget {
  const TebakBilanganScreen({super.key});

  @override
  State<TebakBilanganScreen> createState() => _TebakBilanganScreenState();
}

class _TebakBilanganScreenState extends State<TebakBilanganScreen> {
  final _controller = TextEditingController();
  String _hasilGanjilGenap = '';
  String _hasilPrima = '';

  bool _isPrima(int n) {
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;
    for (int i = 3; i <= sqrt(n).toInt(); i += 2) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void _cek() {
    final angka = int.tryParse(_controller.text.trim());
    if (angka == null) {
      setState(() {
        _hasilGanjilGenap = 'Masukkan bilangan bulat yang valid!';
        _hasilPrima = '';
      });
      return;
    }

    setState(() {
      _hasilGanjilGenap = angka % 2 == 0
          ? '$angka adalah bilangan Genap'
          : '$angka adalah bilangan Ganjil';
      _hasilPrima = _isPrima(angka)
          ? '$angka adalah bilangan Prima'
          : '$angka bukan bilangan Prima';
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
        title: const Text('Ganjil/Genap & Prima'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: InputDecoration(
                labelText: 'Masukkan bilangan',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: _cek,
                icon: const Icon(Icons.search),
                label: const Text('Cek Bilangan'),
              ),
            ),
            const SizedBox(height: 32),
            if (_hasilGanjilGenap.isNotEmpty)
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text('Hasil:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _hasilGanjilGenap.contains('Genap')
                                ? Icons.looks_two
                                : Icons.looks_one,
                            color: _hasilGanjilGenap.contains('Genap')
                                ? Colors.blue
                                : Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              _hasilGanjilGenap,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      if (_hasilPrima.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _hasilPrima.contains('bukan')
                                  ? Icons.close
                                  : Icons.star,
                              color: _hasilPrima.contains('bukan')
                                  ? Colors.red
                                  : Colors.amber,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                _hasilPrima,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
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
