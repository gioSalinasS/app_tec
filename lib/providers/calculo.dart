import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CalculoProvider with ChangeNotifier{



  int? _dias;
  int? _cantidadPiezas;

  int? get cantidadPiezas => _cantidadPiezas;
  int? get dias => _dias;



  setPiezas(int cantidadPiezas){
    _cantidadPiezas = cantidadPiezas;
    notifyListeners();
  }

  setDias(int dias){
    _dias = dias;
    notifyListeners();
  }


  resultadoDeCalculoCorte(){

    //personal requerido (var globales)
    double personalReq=0;
    double eficiencia=0.80;
    
    //solo para corte
    //int _piezasReales = 35;
    //double _tiempoReal = 0.60;
    int tiempo= _dias! *(1440);
    double operNece;

    //opcion (manejar la eficiencia estandar del 80%)
    double tiempoPromeOp=0.050;

    double ip = (_cantidadPiezas! / tiempo); //indice de productividad 
    operNece = (ip*tiempoPromeOp)/eficiencia;

    personalReq = personalReq +operNece.ceil();
    return personalReq.ceil();
  }


  resultadoRimado(){
    double personalReq=0;
    double eficiencia=0.80;
    int tiempo= _dias! *(1440);


    double tiempoPromR=0.148;
    int lavadoRimado = _cantidadPiezas! * 4;
    double ipRim = (lavadoRimado/tiempo);
    double operNeceR=(ipRim*tiempoPromR)/eficiencia;
    personalReq = personalReq +operNeceR.ceil();

    return personalReq.ceil();
  }

  resultadoAbocardado(){
    double personalReq=0;
    double eficiencia=0.80;
    int tiempo= _dias! *(1440);

    double tiempoPromAbo=0.061;
    int abocardado = _cantidadPiezas! * 2;    
    double ipAbo= abocardado / tiempo;

    double operNecAbo=(ipAbo*tiempoPromAbo)/eficiencia;

    personalReq = personalReq +operNecAbo.ceil();

    return personalReq.ceil();

  }

  resultadoInsPro(){
    double personalReq=0;
    double eficiencia=0.80;
    int tiempo= _dias! *(1440);

    double tiempoPromIns= 0.050;
    int inspeccionProceso = _cantidadPiezas! *4;
    double ipIns = inspeccionProceso /tiempo;
    double opernecIns=(ipIns*tiempoPromIns)/eficiencia;
    personalReq = personalReq +opernecIns.ceil();

    return personalReq.ceil();

  }


  resultadoEmpaque(){
    double personalReq=0;
    double eficiencia=0.80;
    int tiempo= _dias! *(1440);

    double tiempoPromEm=0.029;
    double ipEmpa=_cantidadPiezas! / tiempo;

    double operNecEmp= (ipEmpa*tiempoPromEm)/eficiencia;
    personalReq = personalReq +operNecEmp.ceil();

    return personalReq.ceil();

  }



}
  
  