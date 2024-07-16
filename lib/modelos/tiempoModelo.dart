class Crono{
  String? idCrono;
  String? tiempo;
  String? comentario;
  String? usuario;


  //constructor
  Crono({
    this.idCrono,
    this.tiempo,
    this.comentario,
    this.usuario
  });

  //retornar mapa
  Map<String,dynamic> toMap(){
    return {
      'idCrono':idCrono,
      'tiempo':tiempo,
      'comentario':comentario,
      'usuario':usuario
    };
  }

  Crono.fromFirestore(Map<String,dynamic> firestore)
    : idCrono = firestore['idCrono'],
      tiempo = firestore['tiempo'],
      comentario = firestore['comentario'],
      usuario = firestore['usuario'];

}