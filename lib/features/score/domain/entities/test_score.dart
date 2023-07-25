import 'package:equatable/equatable.dart';

class TestScore extends Equatable{
    final List<TestScoreData> data;

    const TestScore({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}

class TestScoreData extends Equatable{
    final String fullName;
    final String nis;
    final String nilUjian;

    const TestScoreData({
        required this.fullName,
        required this.nis,
        required this.nilUjian,
    });
    
      @override
      List<Object?> get props => [
        fullName,
        nis,
        nilUjian
      ];

}
