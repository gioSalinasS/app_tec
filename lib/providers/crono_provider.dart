import 'package:flutter/material.dart';
import 'package:proyecto_tecnoformas/modelos/tiempoModelo.dart';
import 'package:proyecto_tecnoformas/services/firebase_services.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class CronoProvider with ChangeNotifier{
  final firestoreService = FirestoreService();
  var uuid =const Uuid();



  //atributos
  String? _idCrono;
  String? _tiempo;
  String? _comentario;
  String? _usuario;

  //getters
  String? get idCrono => _idCrono;
  String? get tiempo => _tiempo;
  String? get comentario => _comentario;
  String? get usuario => _usuario;

  //setters
  setTiempo(String tiempo){
    _tiempo = tiempo;
    notifyListeners();
  }

  setComentario(String comentario){
    _comentario = comentario;
    notifyListeners();
  }

  setUsuario(String usuario){
    _usuario = comentario;
    notifyListeners();
  }


  //metodo para asignar los valores
  cargarDatos(Crono? crono){
    _tiempo = crono!.tiempo;
    _comentario = crono.comentario;
    _idCrono = crono.idCrono;
    _usuario = crono.usuario;
  }

  guardarTiempo(){
    if(_idCrono == null){
      //nuevo usuario
      var nuevoTiem = 
        Crono(
          idCrono: uuid.v4(),
          tiempo: _tiempo,
          comentario: _comentario,
          usuario: _usuario
        );
      firestoreService.guardarTiempo(nuevoTiem);
    }
  }


}