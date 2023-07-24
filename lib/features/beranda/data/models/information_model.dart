import 'package:siakad_lpk/features/beranda/domain/entities/information.dart';

class InformationModel extends Information {
  const InformationModel({required super.information});

  factory InformationModel.fromJson(Map<String, dynamic> json) => InformationModel(
        information: List<InformationDataModel>.from(json["information"].map((x) => InformationDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "information": List<dynamic>.from(information.map((x) => InformationDataModel(
          id: x.id, 
          judul: x.judul, 
          konten: x.konten
        ))),
    };
  
}

class InformationDataModel extends InformationData {
  const InformationDataModel({required super.id, required super.judul, required super.konten});

  factory InformationDataModel.fromJson(Map<String, dynamic> json) => InformationDataModel(
        id: json["id"],
        judul: json["judul"],
        konten: json["konten"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "konten": konten,
    };
  
}