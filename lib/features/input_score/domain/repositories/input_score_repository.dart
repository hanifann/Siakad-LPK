import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/materi.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student_score.dart';

abstract class InputScoreRepository {
  Future<Either<Failure, Student>>? getStudent();
  Future<Either<Failure, Materi>>? getMateri();
  Future<Either<Failure, String>>? postNilai(
    String idSiswa,
    String idMateri,
    String nilai
  );
  Future<Either<Failure, String>>? editNilai(
    String idNilai,
    String idSiswa,
    String idMateri,
    String nilai
  );
  Future<Either<Failure, String>>? deleteNilai(
    String idNilai,
  );
  Future<Either<Failure, StudentScore>>? getNilai(
    String idMateri
  );
}