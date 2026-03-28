import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'penjumlahan_screen.dart';
import 'tebak_bilangan_screen.dart';
import 'jumlah_angka_field_screen.dart';
import 'stopwatch_screen.dart';
import 'piramid_screen.dart';
import 'login_screen.dart';
import 'tanggal_hari_weton_screen.dart';
import 'hitung_umur_screen.dart';
import 'konversi_hijriah_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserModel loggedInUser;

  const HomeScreen({super.key, required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      _MenuItem('Penjumlahan & Pengurangan', Icons.calculate, Colors.blue, const PenjumlahanScreen()),
      _MenuItem('Ganjil/Genap & Prima', Icons.filter_1, Colors.orange, const TebakBilanganScreen()),
      _MenuItem('Tanggal → Hari & Weton', Icons.calendar_today, Colors.teal, const TanggalHariWetonScreen()),
      _MenuItem('Hitung Umur', Icons.cake, Colors.pink, const HitungUmurScreen()),
      _MenuItem('Konversi Hijriah', Icons.event, Colors.indigo, const KonversiHijriahScreen()),
      _MenuItem('Jumlah Angka Field', Icons.format_list_numbered, Colors.green, const JumlahAngkaFieldScreen()),
      _MenuItem('Stopwatch', Icons.timer, Colors.red, const StopwatchScreen()),
      _MenuItem('Luas & Volume Piramid', Icons.change_history, Colors.purple, const PiramidScreen()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        loggedInUser.nama[0],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang!',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(loggedInUser.nama),
                          Text('NIM: ${loggedInUser.nim}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Data Kelompok
            Text(
              'Data Kelompok',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Column(
                children: dataKelompok.asMap().entries.map((entry) {
                  final i = entry.key;
                  final user = entry.value;
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${i + 1}'),
                        ),
                        title: Text(user.nama),
                        subtitle: Text('NIM: ${user.nim}'),
                      ),
                      if (i < dataKelompok.length - 1) const Divider(height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Menu
            Text(
              'Menu Aplikasi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Card(
                  elevation: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item.screen),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, size: 40, color: item.color),
                        const SizedBox(height: 8),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Color color;
  final Widget screen;

  _MenuItem(this.title, this.icon, this.color, this.screen);
}
