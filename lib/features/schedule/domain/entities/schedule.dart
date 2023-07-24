import 'package:equatable/equatable.dart';

class Schedule extends Equatable{
    final List<ScheduleData> data;

    const Schedule({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}

class ScheduleData extends Equatable {
    final String id;
    final String materiId;
    final String dari;
    final String sampai;
    final String hari;
    final String isActive;
    final String namaMateri;

    const ScheduleData({
        required this.id,
        required this.materiId,
        required this.dari,
        required this.sampai,
        required this.hari,
        required this.isActive,
        required this.namaMateri,
    });
    
      @override
      List<Object?> get props => [
        id,
        materiId,
        dari,
        sampai,
        hari,
        isActive,
        namaMateri
      ];

}
