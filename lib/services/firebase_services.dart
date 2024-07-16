import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_tecnoformas/modelos/usuarioModel.dart';
import 'package:proyecto_tecnoformas/modelos/tiempoModelo.dart';

class FirestoreService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //método para insertar datos
  Future guardarUsuario(Usuario usuario){
    return _db
    .collection('Personal')
    .doc(usuario.usuId)
    .set(usuario.toMap());
  }

  
  Stream<List<Usuario>> getUsu(){
    return _db.collection('Personal').snapshots().map((snapshot) => snapshot
    .docs
    .map((document) => Usuario.fromFirestore(document.data()))
    .toList());
  }

  Future<List> getUsuarios()async{
    List usuarios=[];
    CollectionReference collectionRefUsuarios = _db.collection('Personal');
    QuerySnapshot consulUsu = await collectionRefUsuarios.get();
    

    consulUsu.docs.forEach((documento) {
      usuarios.add(documento.data());
    });
  return usuarios;
}



//Todo lo necesario para los datos del cronometro //////////////////////////////////////////AGSS
  Future guardarTiempo(Crono crono){
    return _db
    .collection('cronometro')
    .doc(crono.idCrono)
    .set(crono.toMap());
  }

  //obtenemos los datos de la coleccion crono
  Future<List> getCronometro()async{
    List cronometro=[];
    CollectionReference collectionRefCrono = _db.collection('cronometro');
    QuerySnapshot consulCrono = await collectionRefCrono.get();

    consulCrono.docs.forEach((element) {
      cronometro.add(element.data());
    });
    return cronometro;
  }

  //obtener datos de los registros de la bitacora

  Future<List> getBitacora()async{
    List bitacora=[];
    CollectionReference collectionRefBit = _db.collection('BitacoraSanac');
    QuerySnapshot consultBit = await collectionRefBit.orderBy('Fecha').get();

    consultBit.docs.forEach((element) {
      bitacora.add(element.data());
    });

    return bitacora;
  }

  Future<List> getBitacoraBocar()async{
    List bitacora =[];
    CollectionReference collectionReferencebocar = _db.collection('BitacoraBocar');
    QuerySnapshot consul = await collectionReferencebocar.orderBy('Fecha').get();

    consul.docs.forEach((element) {
      bitacora.add(element.data());
    });

    return bitacora;

  }



}

