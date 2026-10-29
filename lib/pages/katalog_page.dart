import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../state/belanja_cubit.dart';

import '../state/favorit_provider.dart';

class Produk {
  final String produk;
  final int harga;

  const Produk({required this.produk, required this.harga});
}

String formatRupiah(int nilai) {
  final angka = nilai.toString();

  // StringBuffer digunakan untuk menyusun teks hasil
  // dengan lebih praktis.
  final hasil = StringBuffer('Rp');

  for (var i = 0; i < angka.length; i++) {

    if (i > 0 && (angka.length - i) % 3 == 0) {
      hasil.write('.');
    }

    hasil.write(angka[i]);
  }

  return hasil.toString();
}

class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {

  // Daftar produk yang tersedia.
  // const menunjukkan data produk ini bersifat tetap.
  final List<Produk> produk = const [
    Produk(
      produk: 'Pupuk Kompos Organik',
      harga: 15000,
    ),
    Produk(
      produk: 'Pot Tanaman Daur Ulang',
      harga: 25000,
    ),
    Produk(
      produk: 'Tas Kemasan Daur Ulang',
      harga: 35000,
    ),
  ];

  final List<int> jumlahPembelian = [1, 1, 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Produk')),

      body: Column(
        children: [


          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [

                // Consumer mendengarkan perubahan jumlah favorit
                // dari FavoritProvider.
                Consumer<FavoritProvider>(
                  builder: (context, favorit, child) =>
                      Text(
                        'Jumlah favorit: ${favorit.jumlahFavorit}',
                      ),
                ),

       
                BlocBuilder<BelanjaCubit, int>(
                  builder: (context, jumlah) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Menampilkan jumlah barang di keranjang.
                      Text('Barang di keranjang: $jumlah'),

                      // Tombol untuk mengurangi jumlah keranjang.
                      IconButton(
                        tooltip: 'Kurangi barang dari keranjang',

                        onPressed: () => context
                            .read<BelanjaCubit>()
                            .kurangiBarang(),

                        icon: const Icon(
                          Icons.remove_circle_outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Expanded menggunakan sisa ruang yang tersedia
          // untuk menampilkan daftar produk.
          Expanded(
            child: ListView.builder(

              // Jumlah item yang dibuat sesuai jumlah produk.
              itemCount: produk.length,
              itemBuilder: (context, index) {

                final item = produk[index];

                // Card membungkus informasi setiap produk.
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          item.produk,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        // Menampilkan harga yang telah diformat.
                        Text(formatRupiah(item.harga)),

                        Row(
                          children: [


                            IconButton(
                              // Tombol dinonaktifkan jika jumlah
                              // sudah 1 agar tidak kurang dari 1.
                              onPressed: jumlahPembelian[index] > 1
                                  ? () => setState(
                                        () => jumlahPembelian[index]--,
                                      )
                                  : null,
                              icon: const Icon(Icons.remove),
                            ),

                            // Menampilkan jumlah pembelian saat ini.
                            Text('${jumlahPembelian[index]}'),

                            // Tombol untuk menambah jumlah pembelian.
                            IconButton(
                              onPressed: () => setState(
                                () => jumlahPembelian[index]++,
                              ),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),

                        // Wrap membuat tombol dapat berpindah
                        // ke baris berikutnya jika ruang tidak cukup.
                        Wrap(
                          spacing: 8,
                          children: [

                            // Tombol untuk menambah jumlah favorit.
                            OutlinedButton.icon(
                              onPressed: () => context
                                  .read<FavoritProvider>()
                                  .tambahFavorit(),

                              icon: const Icon(Icons.favorite_border),
                              label: const Text('Tambah Favorit'),
                            ),

                            // Tombol untuk menambahkan jumlah barang
                            // yang dipilih ke keranjang melalui Cubit.
                            FilledButton.icon(
                              onPressed: () => context
                                  .read<BelanjaCubit>()
                                  .tambahBarang(
                                    jumlahPembelian[index],
                                  ),
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text('Tambah ke Keranjang'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Tombol kembali menutup halaman katalog
          // dan kembali ke halaman sebelumnya.
          Padding(
            padding: const EdgeInsets.all(12),
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ),
        ],
      ),
    );
  }
}
