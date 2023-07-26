import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';

class StudentModel extends Student {
  const StudentModel({required super.data});

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        data: List<StudentDataModel>.from(json["data"].map((x) => StudentDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => StudentDataModel(
          idSiswa: x.idSiswa, 
          fullName: x.fullName, 
          nis: x.nis
        ).toJson())),
    };
  
}

class StudentDataModel extends StudentData {
  const StudentDataModel({
    required super.idSiswa, required super.fullName, required super.nis
  });

  factory StudentDataModel.fromJson(Map<String, dynamic> json) => StudentDataModel(
        idSiswa: json["id_siswa"],
        fullName: json["full_name"],
        nis: json["nis"],
    );

    Map<String, dynamic> toJson() => {
        "id_siswa": idSiswa,
        "full_name": fullName,
        "nis": nis,
    };
  
}