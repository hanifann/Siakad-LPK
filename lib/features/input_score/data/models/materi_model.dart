import 'package:siakad_lpk/features/input_score/domain/entities/materi.dart';

class MateriModel extends Materi {
  const MateriModel({required super.data});

  factory MateriModel.fromJson(Map<String, dynamic> json) => MateriModel(
        data: List<MateriDataModel>.from(json["data"].map((x) => MateriDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => MateriDataModel(
          id: x.id, 
          namaMateri: x.namaMateri
        ).toJson())),
    };
  
}

class MateriDataModel extends MateriData {
  const MateriDataModel({required super.id, required super.namaMateri});

  factory MateriDataModel.fromJson(Map<String, dynamic> json) => MateriDataModel(
        id: json["id"],
        namaMateri: json["nama_materi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_materi": namaMateri,
    }; 
}