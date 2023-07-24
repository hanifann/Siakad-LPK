import 'package:siakad_lpk/features/register/domain/entities/register.dart';

class RegisterModel extends Register {
  const RegisterModel({
    required super.fullName, 
    required super.email, 
    required super.password, 
    required super.image, 
    required super.ktp, 
    required super.kontak, 
    required super.kelas, 
    required super.alamat, 
    required super.tempatLahir, 
    required super.tglLahir, 
    required super.pendidikanTerakhir, 
    required super.status, 
    required super.agama, 
    required super.namaOrtu, 
    required super.pengalaman, 
    required super.metodeBayar, 
    required super.buktiBayar
  });

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "password": password,
        "image": image,
        "ktp": ktp,
        "kontak": kontak,
        "kelas": kelas,
        "alamat": alamat,
        "tempat_lahir": tempatLahir,
        "tgl_lahir": tglLahir,
        "pendidikan_terakhir": pendidikanTerakhir,
        "status": status,
        "agama": agama,
        "nama_ortu": namaOrtu,
        "pengalaman_kerja": pengalaman,
        "metode_bayar": metodeBayar,
        "bukti_bayar": buktiBayar,
    };
  
}