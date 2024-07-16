import 'package:proyecto_tecnoformas/modelos/usuarioModel.dart';
import 'package:proyecto_tecnoformas/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class UsuarioProvider with ChangeNotifier{

  //atributos
  final firestoreService = FirestoreService();
  var uuid =const Uuid();

  String? _usuId;
  String? _nombre;
  String? _appMat;
  String? _appPat;
  String? _direccion;
  String? _numero;
  String? _nomUsu;
  String? _contra;
  String? _rol;


  //getters
  String? get nombre => _nombre;
  String? get appMat => _appMat;
  String? get appPat => _appPat;
  String? get direccion => _direccion;
  String? get numero => _numero;
  String? get nomUsu => _nomUsu;
  String? get contra => _contra;
  String? get rol => _rol;

  //setters
  setNombre(String nombre){
    _nombre = nombre;
    notifyListeners();
  }

  setAppMat(String appMat){
    _appMat = appMat;
    notifyListeners();
  }

  setAppPat(String appPat){
    _appPat = appPat;
    notifyListeners();
  }

  setDireccion(String direccion){
    _direccion = direccion;
    notifyListeners();
  }

  setNumero(String numero){
    _numero = numero;
    notifyListeners();
  }

  setNomUsu(String nomUsu){
    _nomUsu = nomUsu;
    notifyListeners();
  }

  setContra(String contra){
    _contra = contra;
    notifyListeners();
  }
  
  setRol(String rol){
    _rol = rol;
    notifyListeners();
  }

  /*setImageUsu(XFile imagenUsu){
    _imagenUsu = imagenUsu;
    notifyListeners();
  }*/

  //método para asignar valores al provider
  cargarDatos(Usuario? usuario){
    _nombre = usuario!.nombre;
    _appMat = usuario.appMat;
    _appPat = usuario.appPat;
    _direccion = usuario.direccion;
    _numero = usuario.numero;
    _nomUsu = usuario.nomUsu;
    _contra = usuario.contra;
    _usuId = usuario.usuId;
    _rol=usuario.rol;
  }

  guardarUsuario(){
    if(_usuId == null){
      //nuevo usuario
      var nuevoUsu = 
        Usuario(
          usuId: uuid.v4(),
          nombre: _nombre,
          appMat: _appMat,
          appPat: _appPat,
          direccion: _direccion,
          numero: _numero,
          nomUsu: _nomUsu,
          contra: _contra,
          rol: _rol
        );
      firestoreService.guardarUsuario(nuevoUsu);
    }
  }
}