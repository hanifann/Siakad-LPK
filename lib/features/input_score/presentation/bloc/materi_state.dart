part of 'materi_bloc.dart';

abstract class MateriState extends Equatable {
  const MateriState();
  
  @override
  List<Object> get props => [];
}

class MateriInitial extends MateriState {}

class MateriLoaded extends MateriState {
  final Materi materi;

  const MateriLoaded(this.materi);
}

class MateriFailed extends MateriState {
  final ErrorModel error;

  const MateriFailed(this.error);
}

class MateriLoading extends MateriState {
  
}