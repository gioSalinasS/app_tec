import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';


class CompBocar extends StatefulWidget {
  const CompBocar({super.key});

  @override
  State<CompBocar> createState() => _CompBocarState();
}

class _CompBocarState extends State<CompBocar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(151, 10, 3, 109),
      body: Container(
        width: double.infinity,
        height: double.infinity, 
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ball.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: _cuerpoOperad(context)
      )
    );
  }
}

//widget swiper
Widget _swiper(){
  List<String> imagenes = [
    "assets/images/foto1.jpg",
    "assets/images/foto2.jpg",
    "assets/images/foto3.jpg",
    "assets/images/foto4.jpg",
  ];
  return Container(
    //duration: Duration(seconds: 1),
    //padding: EdgeInsets.only(top: 10.0),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(width: 5.0),
    ),
    width: double.infinity,
    height: 250.0,
    child: Swiper(
      //scale: 0.5,
      viewportFraction: 1,
      autoplayDelay: 5000,
      autoplay: true,
      itemCount: imagenes.length,
      itemBuilder: (context, index) {
        return Image.asset(
          imagenes[index],
          fit: BoxFit.cover,
        );
      },
      pagination: const SwiperPagination(),
    ),
  );
}

//Widget para titulo de la lista
Widget _actOper(){
  return Container(
    padding: const EdgeInsets.only(top: 20.0,left: 20.0),
    child: Text(
      "Operaciones".toUpperCase(),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color.fromARGB(255, 244, 245, 246),
        fontSize: 40.0,
        fontFamily: "Caveat",
        fontWeight: FontWeight.bold
      ),
    ),
  );
}

//cuerpo de la página
/*Widget _cuerpoOper(BuildContext context){
  return SafeArea(
    child: Column(
      children: <Widget>[
        //SizedBox(height: 10.0,),
        _swiper(),        
        _actOper(),
        const Divider(color: Color.fromARGB(255, 248, 244, 248),indent: 20.0,endIndent: 20.0,thickness: 5.0),
        /*Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: 150.0,
            /*decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 192, 49, 218),
                  Color.fromARGB(255, 116, 167, 255)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              ),
              image: DecorationImage(
                      image: AssetImage("assets/images/fondo2.jpg"),
                      fit: BoxFit.cover
              )
            ),*/
          ),
        ),*/
        //const Divider(color: Color.fromARGB(255, 7, 6, 7),indent: 20.0,endIndent: 20.0,thickness: 5.0),
        Expanded(child: _gridViewAct(context)),
      ],
    )
  );
}*/
Widget _cuerpoOperad(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        const SizedBox(height: 100.0,),
        _swiper(),
        _actOper(),
        _gridViewAct(context),
        _actOper(),
        _gridViewAct(context),
      ] 
    ),
  );
}



Widget _gridViewAct(BuildContext context){
  List<Widget> actividadesTec=[
    _cronometro(context),
    _bitacora(context),
    _pesoMat(context),
    _pesoMat(context),
    _pesoMat(context),   
  ];

  return Container(
    padding: const EdgeInsets.only(top: 10),
    height: 230,
    child: GridView.count(
        crossAxisCount: 1,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(20.0),
        children: actividadesTec.map((e) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          elevation: 5.0,        
          clipBehavior: Clip.antiAliasWithSaveLayer, 
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 10, 163, 228),
                  Color.fromARGB(224, 198, 24, 125),
                ],
              ),
            ),
            child: e,
          ),
        )
        ).toList()
      ),
  );
}


Widget _cronometro(BuildContext context){
  return Column(
    children: [      
      IconButton(
        icon: const Icon(Icons.watch_later),
        iconSize: 80.0,
        color:const Color.fromARGB(209, 255, 255, 255),
        onPressed: () {
          Navigator.pushNamed(context, 'crono');
        },
      ),
      Container(
        margin: const EdgeInsets.all(5.0),
        child: Text(
          "Cronómetro para mantenimiento o ajuste".toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}


Widget _bitacora(BuildContext context){
  return Column(
    children: [
      IconButton(
        icon: const Icon(Icons.book),
        iconSize: 80.0,
        color: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, 'bita');
        },
      ),
      Container(
        margin: const EdgeInsets.all(5.0),
        child: Text(
          "Llenar bítacora".toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}

Widget _pesoMat(BuildContext context){
  return Column(
    children: [
      IconButton(
        icon: const Icon(Icons.monitor_weight_outlined),
        iconSize: 80.0,
        color: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, 'bita');
        },
      ),
      Container(
        margin: const EdgeInsets.all(5.0),
        child: Text(
          "Enviar peso de las piezas en mal estado".toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}
