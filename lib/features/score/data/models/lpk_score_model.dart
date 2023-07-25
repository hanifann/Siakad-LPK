import 'package:siakad_lpk/features/score/domain/entities/lpk_score.dart';

class LpkScoreModel extends LpkScore {
  const LpkScoreModel({required super.data});

  factory LpkScoreModel.fromJson(Map<String, dynamic> json) => LpkScoreModel(
        data: List<LpkScoreDataModel>.from(json["data"].map((x) => LpkScoreDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => LpkScoreDataModel(
          fullName: x.fullName, 
          nis: x.nis,
          namaMateri: x.namaMateri, 
          nilai: x.nilai
        ).toJson())),
    };
  
}

class LpkScoreDataModel extends LpkScoreData {
  const LpkScoreDataModel({
    required super.fullName, 
    required super.nis, 
    required super.namaMateri, 
    required super.nilai
  });

  factory LpkScoreDataModel.fromJson(Map<String, dynamic> json) => LpkScoreDataModel(
        fullName: json["full_name"],
        nis: json["nis"],
        namaMateri: json["nama_materi"],
        nilai: json["nilai"],
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "nis": nis,
        "nama_materi": namaMateri,
        "nilai": nilai,
    };
  
}