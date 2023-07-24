import 'package:siakad_lpk/features/login/domain/entities/login.dart';

class LoginModel extends Login {
  const LoginModel({
    required super.success, 
    required super.message, 
    required super.data
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
    };

}