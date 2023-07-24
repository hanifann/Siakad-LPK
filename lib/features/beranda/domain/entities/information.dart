import 'package:equatable/equatable.dart';

class Information extends Equatable{
    final List<InformationData> information;

    const Information({
        required this.information,
    });
    
      @override
      List<Object?> get props => [information];

}

class InformationData extends Equatable {
    final int id;
    final String judul;
    final String konten;

    const InformationData({
        required this.id,
        required this.judul,
        required this.konten,
    });
    
      @override
      List<Object?> get props => [
        id,
        judul,
        konten
      ];

}
