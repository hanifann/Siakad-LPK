import 'package:siakad_lpk/features/schedule/domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({required super.data});
  
  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        data: List<ScheduleDataModel>.from(json["data"].map((x) => ScheduleDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => ScheduleDataModel(
          id: x.id, 
          materiId: x.materiId, 
          dari: x.dari, 
          sampai: x.sampai, 
          hari: x.hari, 
          isActive: x.isActive, 
          namaMateri: x.namaMateri
        ))),
    };
}

class ScheduleDataModel extends ScheduleData {
  const ScheduleDataModel({
    required super.id, 
    required super.materiId, 
    required super.dari, 
    required super.sampai, 
    required super.hari, 
    required super.isActive, 
    required super.namaMateri
  });

  factory ScheduleDataModel.fromJson(Map<String, dynamic> json) => ScheduleDataModel(
        id: json["id"],
        materiId: json["materi_id"],
        dari: json["dari"],
        sampai: json["sampai"],
        hari: json["hari"],
        isActive: json["is_active"],
        namaMateri: json["nama_materi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materi_id": materiId,
        "dari": dari,
        "sampai": sampai,
        "hari": hari,
        "is_active": isActive,
        "nama_materi": namaMateri,
    };
  
}