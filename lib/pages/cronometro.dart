import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_tecnoformas/providers/crono_provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CronometroPage extends StatefulWidget {
  const CronometroPage({super.key});

  @override
  State<CronometroPage> createState() => _CronometroPageState();
}



class _CronometroPageState extends State<CronometroPage> {

  final inicioCrono = StopWatchTimer();
  String? _tiempoEmpleadoMin;
  String? _tiempoEmpleadoSeg;
  String? _tiempoFin="El tiempo inicial es de 0 minutos y 0 segundos";
  
  

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await inicioCrono.dispose();  // Need to call dispose function.
  }

  void timFin(String min,String sec){
    _tiempoFin="El tiempo final es de: $min minutos y $sec segundos";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(          
        centerTitle: true,
        title: Text(
          "Cronómetro".toUpperCase(),
          style: const TextStyle(
            fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
          ),
        ),
        actions:const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.alarm_add_sharp,size: 40.0,),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new,size: 30.0,)
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 191, 2, 249),
                Color.fromARGB(255, 103, 186, 255)
              ]
            ),
          ),
        ),
        elevation: 10,
      ),
      ///comienza el body
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 158, 74, 127),
              Color.fromARGB(255, 143, 40, 171), 
              Color.fromARGB(255, 103, 186, 255),
            ]
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
              children: [
                _cuerpoCrono(context),
              ],
            ),
        ),
      ),
    );
  }

  Widget _cuerpoCrono(BuildContext context){
    final cronoProvider = Provider.of<CronoProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0,),
           Center(
            child: Container(
              height: 260.0,
              //radius: 150.0,
              //backgroundColor: Color.fromARGB(210, 240, 244, 246),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 231, 151, 245),
                    Color.fromARGB(255, 217, 231, 242)
                  ]
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4
                )
              ),
              child: Center(
                child: StreamBuilder<int>(
                    stream: inicioCrono.rawTime,
                    initialData: inicioCrono.rawTime.value,
                    builder: (context, snapshot) {
                    final value = snapshot.data;
                    final displayTime = StopWatchTimer.getDisplayTime(value!);
                    return Text(
                      displayTime,
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    );
                  },),
              ),
            ),
          ),
          const SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.4,
                height: 100.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                child: FloatingActionButton(
                  heroTag: 'bnt1',
                  child: const Icon(Icons.play_circle_sharp,size: 80.0,),
                  onPressed: () {
                    inicioCrono.onStartTimer();
                  },
                ),
              ),
              Container(///contenedor para el boton de stop /////////////
                width: MediaQuery.of(context).size.width*0.4,
                height: 100.0,
                child: FloatingActionButton(
                  heroTag: 'bnt2',
                  child: const Icon(Icons.stop_circle_sharp,size: 80.0,),
                  onPressed: () {
                    inicioCrono.onStopTimer();
                    setState(() {
                      inicioCrono.minuteTime.listen((valFin) {
                        _tiempoEmpleadoMin = valFin.toString();
                        inicioCrono.secondTime.listen((valFinSec) {
                          _tiempoEmpleadoSeg = ((valFinSec)%60).toString();
                          timFin(_tiempoEmpleadoMin.toString(), _tiempoEmpleadoSeg.toString());
                        });
                      },);
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: const Color.fromARGB(146, 255, 255, 255)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            width: MediaQuery.of(context).size.width,
            height: 225.0,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  _tiempoFin.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    //color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 10.0,),
                TextField(///////espacio para hacer el comentario
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    hintText: "Realiza un comentario",
                    helperText: "El comentario te ayudará a justificar el tiempo",
                    prefixIcon: const Icon(Icons.comment),
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    cronoProvider.setComentario(value);
                  },
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Enviar datos",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black54
                      ),
                    ),
                    const SizedBox(width: 10.0,),
                    FloatingActionButton(
                      heroTag: 'bnt3',
                      child:const Icon(Icons.send_rounded,size: 30.0,),
                      onPressed: () {
                        cronoProvider.setTiempo(_tiempoFin.toString());
                        cronoProvider.guardarTiempo();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}