import 'package:equatable/equatable.dart';

class StudentScore extends Equatable{
    final List<StudentScoreData> data;

    const StudentScore({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}

class StudentScoreData extends Equatable {
    final String id;
    final String fullName;
    final String nis;
    final String namaMateri;
    final String nilai;

    const StudentScoreData({
        required this.id,
        required this.fullName,
        required this.nis,
        required this.namaMateri,
        required this.nilai,
    });
    
      @override
      List<Object?> get props => [
        id,
        fullName,
        nis,
        namaMateri,
        nilai
      ];

}
