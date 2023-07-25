import 'package:siakad_lpk/features/score/domain/entities/test_score.dart';

class TestScoreModel extends TestScore {
  const TestScoreModel({required super.data});

  factory TestScoreModel.fromJson(Map<String, dynamic> json) => TestScoreModel(
        data: List<TestScoreDataModel>.from(json["data"].map((x) => TestScoreDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => TestScoreDataModel(
          fullName: x.fullName, 
          nis: x.nis, 
          nilUjian: x.nilUjian
        ).toJson())),
    };
  
}

class TestScoreDataModel extends TestScoreData {
  const TestScoreDataModel({
    required super.fullName, 
    required super.nis, 
    required super.nilUjian
  });
  

  factory TestScoreDataModel.fromJson(Map<String, dynamic> json) => TestScoreDataModel(
        fullName: json["full_name"],
        nis: json["nis"],
        nilUjian: json["nil_ujian"],
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "nis": nis,
        "nil_ujian": nilUjian,
    };
}