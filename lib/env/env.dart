import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(obfuscate: true, varName: 'URL')
  static String url = _Env.url;
  @EnviedField(obfuscate: true, varName: 'TOKEN_KEY')
  static String token = _Env.token;
  @EnviedField(obfuscate: true, varName: 'USER_KEY')
  static String user = _Env.user;
  @EnviedField(obfuscate: true, varName: 'INFO_KEY')
  static String info = _Env.info;
  @EnviedField(obfuscate: true, varName: 'JADWAL_KEY')
  static String jadwal = _Env.jadwal;
  @EnviedField(obfuscate: true, varName: 'LPK_KEY')
  static String lpk = _Env.lpk;
  @EnviedField(obfuscate: true, varName: 'TEST_KEY')
  static String test = _Env.test;
  @EnviedField(obfuscate: true, varName: 'STUDENT_KEY')
  static String student = _Env.student;
  @EnviedField(obfuscate: true, varName: 'MATERI_KEY')
  static String materi = _Env.materi;
}
