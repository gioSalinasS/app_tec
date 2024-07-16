import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:proyecto_tecnoformas/modelos/usuarioModel.dart';
import 'package:proyecto_tecnoformas/services/firebase_services.dart';

class VerUsuariosPage extends StatefulWidget {
  const VerUsuariosPage({super.key});

  @override
  State<VerUsuariosPage> createState() => _VerUsuariosPageState();
}

class _VerUsuariosPageState extends State<VerUsuariosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
    );
  }
}

//Widget para titulo de la lista
Widget textBocar(){
  return Container(
    alignment: Alignment.topLeft,
    padding:const EdgeInsets.only(top: 20.0,left: 20.0),
    child: Text(
      "Personal registrado".toUpperCase(),
      style:const TextStyle(
        color: Color.fromARGB(255, 74, 68, 75),
        fontSize: 30.0,
        //fontFamily: "Caveat",
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}

//cuerpo de la página
Widget cuerpo(BuildContext context){
  return Container(
    child: ListView(
      scrollDirection: Axis.vertical,
      children: <Widget> [
        textBocar(),
        const Padding(padding: EdgeInsets.only(top: 10.0)),
        listaBocar(context),
      ],
    ),
  );
}

////////////////Lista Bocar/////////////
Widget listaBocar(BuildContext context){
  final usuarios = FirestoreService();
  //final usuarios = Provider.of<List<Usuario>?>(context);
  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    height: 150,
    child: FutureBuilder(
      future: usuarios.getUsuarios(),
      builder: (context, snapshot) {
        return ListView.builder(
          //padding: const EdgeInsets.all(10),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            if(snapshot.hasData){
              return Column(
                children: [
                  const Image(image: AssetImage("assets/images/tubing_2.png"),width: 35,),
                  Text(snapshot.data?[index]['user'],),
                  const SizedBox(width: 150.0,height: 20.0,),
                ],
              ); 
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.purple,),
            );
          },
        );
      },
    ),
  );
}
