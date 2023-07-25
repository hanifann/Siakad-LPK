import 'package:equatable/equatable.dart';

class LpkScore extends Equatable{
    final List<LpkScoreData> data;

    const LpkScore({
        required this.data,
    });
    
      @override
      List<Object?> get props =>[
        data
      ];

}

class LpkScoreData extends Equatable{
    final String fullName;
    final String nis;
    final String namaMateri;
    final String nilai;

    const LpkScoreData({
        required this.fullName,
        required this.nis,
        required this.namaMateri,
        required this.nilai,
    });
    
      @override
      List<Object?> get props => [
        fullName,
        nis,
        namaMateri,
        nilai
      ];

}
