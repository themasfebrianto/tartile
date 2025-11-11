import 'package:flutter/material.dart';

class AboutAppDialog extends StatelessWidget {
  const AboutAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.menu_book_rounded, size: 60, color: Colors.green),
                  const SizedBox(height: 10),
                  Text(
                    'Tartil.in',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Versi 1.0.0',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Tentang Aplikasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            const Text(
              'Tartil.in adalah aplikasi pembelajaran tajwid interaktif '
              'yang membantu kamu memahami cara membaca Al-Qur’an dengan benar, '
              'melalui penjelasan yang mudah dipahami dan gamifikasi yang menarik.',
              style: TextStyle(height: 1.4),
            ),

            const SizedBox(height: 16),

            const Text(
              'Team Pengembang',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 6),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Themas Febrianto', style: TextStyle(height: 1.4)),
                // Text('• Nama Lain', style: TextStyle(height: 1.4)),
              ],
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
