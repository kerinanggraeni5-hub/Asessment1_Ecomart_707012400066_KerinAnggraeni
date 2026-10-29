import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../state/belanja_cubit.dart';
import '../state/favorit_provider.dart';

import 'form_pemesanan_page.dart';
import 'katalog_page.dart';
import 'lokasi_page.dart';

// StatelessWidget digunakan karena halaman beranda tidak
// memiliki state lokal yang perlu diubah secara langsung.
class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EcoMart - Produk Daur Ulang')),

      // Padding memberikan jarak antara isi halaman
      body: Padding(
        padding: const EdgeInsets.all(20),

        // ListView memungkinkan isi halaman digulir
        child: ListView(
          children: [
            const Text(
              'Selamat Datang di EcoMart',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Memberikan jarak vertikal sebesar 10.
            const SizedBox(height: 10),

            const Text(
              'Aplikasi EcoMart memiliki fitur katalog produk '
              'keranjang belanja, formulir pemesanan, dan peta lokasi ',
            ),

            // Memberikan jarak sebelum tombol navigasi.
            const SizedBox(height: 24),

            // Tombol untuk membuka halaman katalog produk.
            ElevatedButton(
              onPressed: () {
                // Navigator.push membuka halaman baru
                // di atas halaman yang sedang ditampilkan.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const KatalogPage(),
                  ),
                );
              },
              child: const Text('Lihat Produk'),
            ),
            const SizedBox(height: 15),

            // Tombol untuk membuka formulir pemesanan.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FormPemesananPage(),
                  ),
                );
              },
              child: const Text('Form Pemesanan'),
            ),
              const SizedBox(height: 15),

            // Tombol untuk membuka halaman lokasi.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LokasiPage(),
                  ),
                );
              },
              child: const Text('Lokasi Komunitas'),
            ),

            const SizedBox(height: 20),

            Consumer<FavoritProvider>(
              builder: (context, favorit, child) {
                // favorit adalah objek Provider yang digunakan
                // untuk membaca jumlah favorit terbaru.
                return Text(
                  'Jumlah favorit: ${favorit.jumlahFavorit}',
                );
              },
            ),

            const SizedBox(height: 8),

            // BlocBuilder mendengarkan perubahan state
            // dari BelanjaCubit yang bertipe int.
            BlocBuilder<BelanjaCubit, int>(
              builder: (context, jumlah) {
                // jumlah berisi state terbaru dari Cubit,
                // yaitu jumlah barang dalam keranjang.
                return Text(
                  'Barang dalam keranjang: $jumlah',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
