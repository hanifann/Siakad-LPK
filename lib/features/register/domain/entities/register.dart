import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String image;
  final String ktp;
  final String kontak;
  final String kelas;
  final String alamat;
  final String tempatLahir;
  final String tglLahir;
  final String pendidikanTerakhir;
  final String status;
  final String agama;
  final String namaOrtu;
  final String pengalaman;
  final String metodeBayar;
  final String buktiBayar;

  const Register({
    required this.fullName, 
    required this.email, 
    required this.password, 
    required this.image, 
    required this.ktp, 
    required this.kontak, 
    required this.kelas, 
    required this.alamat, 
    required this.tempatLahir, 
    required this.tglLahir, 
    required this.pendidikanTerakhir, 
    required this.status, 
    required this.agama, 
    required this.namaOrtu, 
    required this.pengalaman, 
    required this.metodeBayar, 
    required this.buktiBayar
  });

  @override
  List<Object?> get props => [
    fullName, 
    email, 
    password, 
    image, 
    ktp, 
    kontak, 
    kelas, 
    alamat, 
    tempatLahir, 
    tglLahir, 
    pendidikanTerakhir, 
    status, 
    agama, 
    namaOrtu, 
    pengalaman, 
    metodeBayar, 
    buktiBayar
  ];
  
}