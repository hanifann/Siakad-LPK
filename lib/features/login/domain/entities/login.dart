import 'package:equatable/equatable.dart';

class Login extends Equatable{
    final bool success;
    final String message;
    final String data;

    const Login({
        required this.success,
        required this.message,
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        success,
        message,
        data
      ];

}
