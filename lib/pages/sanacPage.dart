import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SanacPage extends StatefulWidget {
  const SanacPage({super.key});

  @override
  State<SanacPage> createState() => _SanacPageState();
}


class _SanacPageState extends State<SanacPage> {
  @override
  Widget build(BuildContext context) {

    final Map bitacora = ModalRoute.of(context)!.settings.arguments as Map;
    String nombre = bitacora['nombre'];
    String numParte = bitacora['numParte'];
    String torno = bitacora['torno'];
    int piezas = bitacora['piezasH'];
    //String cliente = bitacora['cliente'];
    String comentario = bitacora['comentario'];
    //double durezaMater = bitacora['durezaM'];
    double espeMa = bitacora['espeMa'];
    double espeMin = bitacora['espeMin'];
    Timestamp fecha = bitacora['fecha'];
    double longMax = bitacora['longMax'];
    double longMin = bitacora['longMin'];
    String tiempoTra = bitacora['tiempoTra'];
    double diametroMa = bitacora['diametro'];
    double diamentroMin = bitacora['diametroMin'];


    //comienza el scaffold
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [        
              Color.fromARGB(232, 247, 215, 249),
              Color.fromARGB(255, 227, 232, 255),
            ],
          )
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Registro de la bitacora"),
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
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text("A continuación, se muestra los datos registrados por el operador el día ${fecha.toDate().toString()}",),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                border: TableBorder.all(),
                                dataTextStyle:const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0
                                ),
                                sortColumnIndex: 0,
                                columns:const <DataColumn>[
                                  DataColumn(label: Text("Fecha"),),
                                  DataColumn(label: Text("# de parte")),
                                  DataColumn(label: Text("Tiempo Trabajado")),
                                  DataColumn(label: Text("Comentario sobre el tiempo trabajado")),
                                  DataColumn(label: Text("Diametro maximo de tubo")),
                                  DataColumn(label: Text("Diametro minimo de tubo")),
                                  DataColumn(label: Text("Espesor mínimo")),
                                  DataColumn(label: Text("Espesor máximo")),
                                  DataColumn(label: Text("Longitud mínimo")),
                                  DataColumn(label: Text("Longitud máxima")),
                                  DataColumn(label: Text("Cantidad")),
                                  DataColumn(label: Text("Operador")),
                                  DataColumn(label: Text("Torno")),
                                ],
                                rows: [
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(fecha.toDate().toString())),
                                      DataCell(Text(numParte)),
                                      DataCell(Text(tiempoTra)),
                                      DataCell(Text(comentario.toString())),
                                      DataCell(Text(diametroMa.toString())),
                                      DataCell(Text(diamentroMin.toString())),
                                      DataCell(Text(espeMin.toString())),
                                      DataCell(Text(espeMa.toString())),
                                      DataCell(Text(longMin.toString())),
                                      DataCell(Text(longMax.toString())),
                                      DataCell(Text(piezas.toString())),
                                      DataCell(Text(nombre)),
                                      DataCell(Text(torno)),
                                    ]
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }



}