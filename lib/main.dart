import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'pages/beranda_page.dart';

import 'state/belanja_cubit.dart';

import 'state/favorit_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritProvider(),

      child: BlocProvider(
        create: (_) => BelanjaCubit(),
        child: const EcoMartApp(),
      ),
    ),
  );
}

// Widget utama yang mengatur konfigurasi aplikasi.
class EcoMartApp extends StatelessWidget {
  const EcoMartApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      // Menetapkan nama aplikasi.
      title: 'EcoMart',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),

        useMaterial3: true,
      ),

      home: const BerandaPage(),
    );
  }
}
