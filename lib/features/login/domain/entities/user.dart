import 'package:equatable/equatable.dart';

class User extends Equatable{
    final int id;
    final String fullName;
    final String email;
    final String role;

    const User({
        required this.id,
        required this.fullName,
        required this.email,
        required this.role,
    });
    
      @override
      List<Object?> get props => [
        id,
        fullName,
        email,
        role
      ];

}
