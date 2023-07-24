import 'package:siakad_lpk/features/login/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id, 
    required super.fullName, 
    required super.email, 
    required super.role
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        role: json["role"],
    );

  
  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "role": role,
    };
  
}