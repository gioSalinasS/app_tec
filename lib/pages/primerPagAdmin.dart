import 'package:flutter/material.dart';
import 'package:proyecto_tecnoformas/services/firebase_services.dart';

class PrimerPageAdmin extends StatefulWidget {
  const PrimerPageAdmin({super.key});

  @override
  State<PrimerPageAdmin> createState() => _PrimerPageAdminState();
}

class _PrimerPageAdminState extends State<PrimerPageAdmin> {


  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    build(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            colors: [        
              Color.fromARGB(164, 28, 5, 236),
              Color.fromARGB(151, 216, 2, 232),
              Color.fromARGB(218, 58, 84, 232),
            ],
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(child: _cuerpoPrincPage(context))
        ),
      ),
      ],
    );
  }
}



Widget _cuerpoPrincPage(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        const SizedBox(height: 10.0,),
        _personal(),
        _listaPersonal(context),
        const Divider(),
        _regBitCom(),
        _cardReg(context),
        const Divider(),
        _registrosBit(),
        _cardBocar(context)
      ] 
    ),
  );
}

//Widget para titulo de la lista
Widget _personal(){
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 20.0,left: 20.0),
    child: Text(
      "Personal registrado".toUpperCase(),
      style: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 30.0,
        //fontFamily: "Caveat",
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}


//widget card para ir a la pantalla que mostrará todos los registros
Widget _cardReg(BuildContext context){
  return Card(
    shadowColor: Colors.black,
    elevation: 10.0,
    color:const Color.fromARGB(255, 241, 213, 250),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0)
    ),
    margin: const EdgeInsets.all(10.0),
    child: ListTile(
      title: Text("Registros globales".toUpperCase(),
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),),
      subtitle: const Text("Visualiza todos los registros"),
      leading: const Icon(Icons.table_rows),
      trailing: const Icon(Icons.arrow_circle_right_outlined,size: 40,),
      onTap: () {
        Navigator.pushNamed(context, 'resultados');
      },
    )
  );
}

//bocar-----------------
//Widget para titulo de la lista
Widget _registrosBit(){
  return Container(
    padding: const EdgeInsets.only(top:20.0),
    child: Text(
      "Registros de bocar".toUpperCase(),
      style: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 20.0,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}


Widget _cardBocar(BuildContext context){
  return Card(
    shadowColor: Colors.black,
    elevation: 10.0,
    color:const Color.fromARGB(255, 241, 213, 250),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0)
    ),
    margin: const EdgeInsets.all(10.0),
    child: ListTile(
      title: Text("Registros de bocar".toUpperCase(),
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),),
      subtitle: const Text("Visualiza todos los registros"),
      leading: const Icon(Icons.table_rows),
      trailing: const Icon(Icons.arrow_circle_right_outlined,size: 40,),
      onTap: () {
        Navigator.pushNamed(context, 'resultados');
      },
    )
  );
}



//Widget para titulo de la lista
/*Widget _registrosBita(){
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 20.0,left: 20.0),
    child: Text(
      "Registros de la bitácora".toUpperCase(),
      style: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 30.0,
        //fontFamily: "Caveat",
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}*/

//Widget para titulo de la lista
Widget _regBitCom(){
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 20.0,left: 20.0),
    child: Text(
      "Registros de SANAC".toUpperCase(),
      style: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 20.0,
        //fontFamily: "Caveat",
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}



////////////////Lista personal/////////////
Widget _listaPersonal(BuildContext context){
  final usuarios = FirestoreService();
  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    height: 150,
    child: FutureBuilder(
      future: usuarios.getUsuarios(),
      builder: (context, snapshot) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            if(snapshot.hasData){
              return Column(
                children: [
                  const ClipOval(
                    child: Image(
                      image: AssetImage('assets/images/foto2.jpg'),
                      height: 90,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    child: Text(snapshot.data?[index]['user'],
                      style: const TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  const SizedBox(width: 150.0),
                ],
              ); 
            }
            return const Center(
              widthFactor: 10.0,
              child: CircularProgressIndicator(color: Colors.purple,),
            );
          },
        );
      },
    ),
  );
}




//Registros individuales
/*Widget _registroBitacora(BuildContext context){
  final registros = FirestoreService();
  return Container(
    padding:const EdgeInsets.all(10),
    height: 350,
    child: FutureBuilder(
      future: registros.getBitacora(),
      builder: (context, snapshot) {
        return  ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            if(snapshot.hasData){
              Timestamp tiempo = (snapshot.data![index]['Fecha']);
              return Card(
                shadowColor: Colors.black,
                elevation: 10.0,
                color:const Color.fromARGB(255, 241, 213, 250),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                  title: Text("Cliente ${snapshot.data?[index]['Cliente']} - En torno: ${snapshot.data?[index]['Torno']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic
                  ),),
                  subtitle: Text("Operador: ${snapshot.data![index]['Operador']}"),
                  trailing: const Icon(Icons.arrow_circle_right_outlined,size: 30.0,),
                  leading: Text('${tiempo.toDate().day}-${tiempo.toDate().month} ${tiempo.toDate().hour}:${tiempo.toDate().minute}:${tiempo.toDate().second}'),//tiempo.toDate().toString()),
                  iconColor: Colors.black,
                  onTap: () {
                    Navigator.pushNamed(context, 'sanac',arguments: {
                      "nombre":snapshot.data![index]['Operador'],
                      "numParte":snapshot.data![index]['# de Parte'],
                      "torno":snapshot.data![index]['Torno'],
                      "piezasH":snapshot.data![index]['Piezas Hechas'],
                      "cliente":snapshot.data![index]['Cliente'],
                      "comentario":snapshot.data![index]['Comentario'],
                      "durezaM":snapshot.data![index]['Dureza del Material'],
                      "espeMa":snapshot.data![index]['Espesor Máximo'],
                      "espeMin":snapshot.data![index]['Espesor Mínimo'],
                      "fecha":snapshot.data![index]['Fecha'],
                      "hora":snapshot.data![index]['Hora'],
                      "longMax":snapshot.data![index]['Longitud Máxima de Corte'],
                      "longMin":snapshot.data![index]['Longitud Mínima de Corte'],
                      "tiempoTra":snapshot.data![index]['Tiempo Trabajado'],
                      "diametro":snapshot.data![index]['Diametro Maximo del Tubo'],
                      "diametroMin":snapshot.data![index]['Diametro Minimo del Tubo']
                    });
                  },
                ),
              );
            }
            return const Center(
              heightFactor:10.0,
              child: CircularProgressIndicator(
                color: Colors.purple,
                )
              );
          },
        );
      },
    ),
  );
}*/
