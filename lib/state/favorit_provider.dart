import 'package:flutter/foundation.dart';

class FavoritProvider extends ChangeNotifier {
  int jumlahFavorit = 0;

  // Fungsi untuk menambah jumlah favorit.
  void tambahFavorit() {
    jumlahFavorit++;
    notifyListeners();
  }
}
