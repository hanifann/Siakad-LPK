import 'package:siakad_lpk/features/input_score/domain/entities/student_score.dart';

class StudentScoreModel extends StudentScore {
  const StudentScoreModel({required super.data});

  factory StudentScoreModel.fromJson(Map<String, dynamic> json) => StudentScoreModel(
        data: List<StudentScoreDataModel>.from(json["data"].map((x) => StudentScoreDataModel.fromJson(x))),
    );
  
}

class StudentScoreDataModel extends StudentScoreData {
  const StudentScoreDataModel({required super.id, required super.fullName, required super.nis, required super.namaMateri,required super.idSiswa, required super.nilai});
  
  factory StudentScoreDataModel.fromJson(Map<String, dynamic> json) => StudentScoreDataModel(
        id: json["id"],
        fullName: json["full_name"],
        nis: json["nis"],
        namaMateri: json["nama_materi"],
        idSiswa: json["id_siswa"],
        nilai: json["nilai"],
    );
}