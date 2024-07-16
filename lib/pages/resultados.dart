import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_tecnoformas/services/firebase_services.dart';

class restultadosCalc extends StatefulWidget {
  const restultadosCalc({super.key});

  @override
  State<restultadosCalc> createState() => _restultadosCalcState();
}


class _restultadosCalcState extends State<restultadosCalc> {

  final registros = FirestoreService();
  List registrosBit = [];
  int cantidadAcumulada= 0;
  
  
  @override
  void initState() {
    //SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    registros.getBitacora();
    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Registros de la bítacora"),
        leading: const Icon(Icons.dataset),
        actions:const [
            Icon(Icons.app_registration,size: 30,),
            SizedBox(width: 10,)
          ],
          flexibleSpace:  Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight             
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  blurStyle: BlurStyle.solid,
                  offset: Offset(0, 1)
                )
              ]
            ),
          ),
          elevation: 10.0,
      ),
      
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "A continuacion se muestran los registros generales",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(10),
                child: Scrollbar(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.blue
                        ]
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder(
                      future: registros.getBitacora(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          cantidadAcumulada = snapshot.data!.map((e) => (e['Piezas Hechas']),).reduce((value, element) => value+element);
                          String fecha = snapshot.data!.map((e) => ((e['Fecha']) as Timestamp).toDate()).toString();
                          
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DataTable(
                                      dataTextStyle: const TextStyle(fontSize: 15.0),
                                      headingTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                      headingRowColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 7, 255, 218)),
                                      dataRowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                      //decoration: BoxDecoration(color: Colors.green),
                                      border: TableBorder.all(
                                        color: Colors.black,
                                        width:1.5,
                                        style: BorderStyle.solid,
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      dividerThickness: 2.0,
                                      dataRowHeight: 50.0,
                                      headingRowHeight: 50.0,
                                      columns: const[
                                        DataColumn(label: Text("Operador",),),
                                        DataColumn(label: Text("Fecha"),),
                                        DataColumn(label: Text("# de Parte"),),
                                        DataColumn(label: Text("Diametro máximo del tubo"),),
                                        DataColumn(label: Text("Diametro mínimo del tubo"),),
                                        DataColumn(label: Text("Tiempo trabajado"),),
                                        DataColumn(label: Text("Espesor máximo"),),
                                        DataColumn(label: Text("Espesor Mínimo"),),
                                        DataColumn(label: Text("Longitud máxima de corte"),),
                                        DataColumn(label: Text("Longitud mínima de corte"),),
                                        DataColumn(label: Text("Cantidad de piezas"),),
                                        DataColumn(label: Text("Torno"),),
                                        DataColumn(label: Text("Comentario referente al tiempo"))
                                      ], 
                                      rows: snapshot.data!.map((eleme) => DataRow(color: MaterialStateProperty.all<Color>(Colors.transparent),
                                      cells: [
                                        DataCell(Text(eleme['Operador'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(
                                          Text(fecha,
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['# de Parte'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Diametro Maximo del Tubo'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Diametro Minimo del Tubo'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Tiempo Trabajado'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Espesor Máximo'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Espesor Mínimo'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Longitud Máxima de Corte'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Longitud Mínima de Corte'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Piezas Hechas'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Torno'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                        DataCell(Text(eleme['Comentario'].toString(),
                                          style: const TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center)
                                        ),
                                      ])).toList()
                                    ),
                                  ),
                                  const Divider(thickness: 50,),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("La cantidad de piezas acumuladas al momento es de:",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(213, 255, 255, 255)
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(cantidadAcumulada.toString(),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),                                      
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return  const Center(child: CircularProgressIndicator(),);
                      },
                    ),
                  ),
                ),
              ),
              //_encabezados(),
              const Divider(),
              //_datosenTabla3()
            ],
          ),
        ),
      )
    );
  }




}


