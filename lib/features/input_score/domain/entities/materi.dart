import 'package:equatable/equatable.dart';

class Materi extends Equatable{
    final List<MateriData> data;

    const Materi({
        required this.data,
    });
    
      @override
      List<Object?> get props =>[
        data
      ];

}

class MateriData extends Equatable {
    final String id;
    final String namaMateri;

    const MateriData({
        required this.id,
        required this.namaMateri,
    });
    
      @override
      List<Object?> get props => [
        id,
        namaMateri
      ];

}
