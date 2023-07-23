import 'dart:convert';

import 'package:equatable/equatable.dart';

ErrorModel errorFromJson(String str) => ErrorModel.fromJson(jsonDecode(str));

class ErrorModel extends Equatable{
    const ErrorModel({
      this.message,
    });

    factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["message"] == null ? null : json['message'],
    );

    final String? message;
    
    @override
    List<Object?> get props => [
      message,
    ];
}