import 'package:equatable/equatable.dart';

class Student extends Equatable{
    final List<StudentData> data;

    const Student({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}

class StudentData extends Equatable {
    final String idSiswa;
    final String fullName;
    final String nis;

    const StudentData({
        required this.idSiswa,
        required this.fullName,
        required this.nis,
    });
    
      @override
      List<Object?> get props => [
        idSiswa,
        fullName,
        nis
      ];

}
