import 'package:flutter/material.dart';
import 'dart:math';

class PiramidScreen extends StatefulWidget {
  const PiramidScreen({super.key});

  @override
  State<PiramidScreen> createState() => _PiramidScreenState();
}

class _PiramidScreenState extends State<PiramidScreen> {
  final _alasController = TextEditingController();
  final _tinggiController = TextEditingController();
  final _tinggiSisiController = TextEditingController();
  String _hasilLuas = '';
  String _hasilVolume = '';

  void _hitung() {
    final a = double.tryParse(_alasController.text);
    final t = double.tryParse(_tinggiController.text);
    final ts = double.tryParse(_tinggiSisiController.text);

    if (a == null || t == null || ts == null) {
      setState(() {
        _hasilLuas = 'Masukkan semua angka yang valid!';
        _hasilVolume = '';
      });
      return;
    }

    if (a <= 0 || t <= 0 || ts <= 0) {
      setState(() {
        _hasilLuas = 'Semua nilai harus lebih dari 0!';
        _hasilVolume = '';
      });
      return;
    }

    // Piramid segi empat (square pyramid)
    // Luas alas = a * a
    // Luas selimut = 4 * (1/2 * a * tinggi sisi) = 2 * a * tinggi sisi
    // Luas permukaan = luas alas + luas selimut
    final luasAlas = a * a;
    final luasSelimut = 2 * a * ts;
    final luasPermukaan = luasAlas + luasSelimut;

    // Volume = 1/3 * luas alas * tinggi
    final volume = (1.0 / 3.0) * luasAlas * t;

    setState(() {
      _hasilLuas = 'Luas Permukaan = ${luasPermukaan.toStringAsFixed(2)}';
      _hasilVolume = 'Volume = ${volume.toStringAsFixed(2)}';
    });
  }

  @override
  void dispose() {
    _alasController.dispose();
    _tinggiController.dispose();
    _tinggiSisiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luas & Volume Piramid'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Info card
            Card(
              color: Colors.purple[50],
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.purple),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Piramid segi empat (alas persegi)',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _alasController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Panjang sisi alas (a)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tinggiController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Tinggi piramid (t)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tinggiSisiController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Tinggi sisi miring (ts)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: _hitung,
                icon: const Icon(Icons.calculate),
                label: const Text('Hitung'),
              ),
            ),
            const SizedBox(height: 32),
            if (_hasilLuas.isNotEmpty)
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
                          const Icon(Icons.square_foot, color: Colors.purple),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              _hasilLuas,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      if (_hasilVolume.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.view_in_ar, color: Colors.deepPurple),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                _hasilVolume,
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
