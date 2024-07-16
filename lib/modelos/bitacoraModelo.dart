class Bitacora{

  String? bitacoraId;
  String? cliente;
  String? parte;
  String? torno;
  int? piezas;
  String? comentario;
  String? tiempo;
  String? nombre;
  double? medidMin;
  double? medidMax;
  double? dureza;
  double? espesmin;
  double? espesMax;

  Bitacora({
    this.bitacoraId,
    this.cliente,
    this.comentario,
    this.dureza,
    this.espesMax,
    this.espesmin,
    this.medidMax,
    this.medidMin,
    this.nombre,
    this.parte,
    this.piezas,
    this.tiempo,
    this.torno
  });


  Map<String,dynamic> toMap(){
    return {
      'bitacoraId':bitacoraId,
      'tiempo':tiempo,
      'comentario':comentario,
      'operador':nombre
    };
  }

  Bitacora.fromFirestore(Map<String,dynamic> firestore)
    : bitacoraId = firestore['bitacoraId'],
      tiempo = firestore['Tiempo Trabajado'],
      comentario = firestore['Comentario'],
      nombre = firestore['Operador'];


}