class Usuario{
    
  //atributos
  String? usuId;
  String? nombre;
  String? appMat;
  String? appPat;
  String? direccion;
  String? numero;
  String? nomUsu;
  String? contra;
  String? rol;
  //XFile? imagenUsu;
  
  //constructor 
  Usuario({
    this.usuId,
    this.nombre,
    this.appMat,
    this.appPat,
    this.direccion,
    this.numero,
    this.nomUsu,
    this.contra,
    this.rol
    //this.imagenUsu
  });

  //método que retorna un usuario como mapa
  Map<String,dynamic> toMap(){
    return {
      'usuId': usuId,
      'nombre': nombre,
      'appMat': appMat,
      'appPat':appPat,
      'direccion':direccion,
      'numero':numero,
      'nomUsu':nomUsu,
      'contra':contra,
      'rol':rol
      //'imagenUsu':imagenUsu
    };
  }

  //constructor que convierte de Firestore a un objeto de flutter
  Usuario.fromFirestore(Map<String,dynamic> firestore)
    : usuId = firestore['usuId'],
      nombre = firestore['nombre'],
      appMat = firestore['appMat'],
      appPat = firestore['appPat'],
      direccion = firestore['direccion'],
      numero = firestore['numero'],
      nomUsu = firestore['nomUsu'],
      contra = firestore['contra'],
      rol = firestore['rol'];
      //imagenUsu = firestore['imagenUsu'];


}