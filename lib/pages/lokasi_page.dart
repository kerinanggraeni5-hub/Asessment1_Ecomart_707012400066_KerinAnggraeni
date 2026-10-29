import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiPage extends StatelessWidget {
  const LokasiPage({super.key});

  static const LatLng lokasiEcoMart = LatLng(
    -6.914744,
    107.609810,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Komunitas'),
      ),

      body: GoogleMap(

        initialCameraPosition: const CameraPosition(
          target: lokasiEcoMart,
          zoom: 15,
        ),

        // Marker digunakan untuk menandai lokasi tertentu.
        markers: {
          const Marker(

            // ID unik untuk mengidentifikasi marker.
            markerId: MarkerId('Bank Sampah Hijau'),

            position: lokasiEcoMart,
            infoWindow: InfoWindow(
              title: 'Bank Sampah Hijau',
            ),
          ),
        },
      ),
    );
  }
}
