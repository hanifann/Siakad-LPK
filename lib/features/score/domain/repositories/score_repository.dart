import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/features/score/domain/entities/lpk_score.dart';
import 'package:siakad_lpk/features/score/domain/entities/test_score.dart';

abstract class ScoreRepository {
  Future<Either<Failure, TestScore>>? getTestScore();
  Future<Either<Failure, LpkScore>>? getLpkScore();
}