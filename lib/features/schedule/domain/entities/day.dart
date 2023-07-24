import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Day extends Equatable {
  final String day;
  bool isSelected;

  Day({
    required this.day, 
    this.isSelected = false
  });

  @override
  List<Object?> get props => [
    day,
    isSelected
  ];
  
}