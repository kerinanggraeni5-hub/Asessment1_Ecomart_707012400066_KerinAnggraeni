import 'package:flutter_bloc/flutter_bloc.dart';

class BelanjaCubit extends Cubit<int> {

  BelanjaCubit() : super(0);

  void tambahBarang([int jumlah = 1]) {
    if (jumlah > 0) {

  
      emit(state + jumlah);
    }
  }

  // Fungsi untuk mengurangi jumlah barang sebanyak 1.
  void kurangiBarang() {
    if (state > 0) {

      // Mengirimkan state baru dengan jumlah dikurangi 1.
      emit(state - 1);
    }
  }
}
