import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/materi.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';

abstract class InputScoreRepository {
  Future<Either<Failure, Student>>? getStudent();
  Future<Either<Failure, Materi>>? getMateri();
}