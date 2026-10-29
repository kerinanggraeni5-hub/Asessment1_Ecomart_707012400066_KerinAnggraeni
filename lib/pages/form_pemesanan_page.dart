import 'package:flutter/material.dart';
class FormPemesananPage extends StatefulWidget {
  const FormPemesananPage({super.key});

  @override
  State<FormPemesananPage> createState() =>
      _FormPemesananPageState();
}

class _FormPemesananPageState
    extends State<FormPemesananPage> {

  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  String metodePengiriman = 'Diantar';

  bool setuju = false;

  @override
  void dispose() {
    namaController.dispose();
    alamatController.dispose();

    super.dispose();
  }

  void kirimPesanan() {

    if (!setuju) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Centang persetujuan terlebih dahulu'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pesanan berhasil dibuat'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan')),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          TextField(
            controller: namaController,
            decoration: const InputDecoration(
              labelText: 'Nama Pembeli',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: alamatController,
            decoration: const InputDecoration(
              labelText: 'Alamat Pengiriman',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          const Text('Metode Pengiriman'),

          RadioListTile<String>(
            title: const Text('Diantar'),

          
            value: 'Diantar',

            groupValue: metodePengiriman,
            onChanged: (value) {
              setState(() => metodePengiriman = value!);
            },
          ),

          RadioListTile<String>(
            title: const Text('Ambil di Tempat'),
            value: 'Ambil di Tempat',

            groupValue: metodePengiriman,
            onChanged: (value) {
              setState(() => metodePengiriman = value!);
            },
          ),

          Row(
            children: [
              Checkbox(
                value: setuju,
                onChanged: (value) {

                  setState(() => setuju = value ?? false);
                },
              ),

              const Expanded(
                child: Text('Saya menyetujui pesanan ini'),
              ),
            ],
          ),

          FilledButton(
            onPressed: kirimPesanan,
            child: const Text('Kirim Pesanan'),
          ),
        ],
      ),
    );
  }
}
