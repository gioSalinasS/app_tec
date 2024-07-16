import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_tecnoformas/providers/calculo.dart';
import 'package:proyecto_tecnoformas/services/firebase_services.dart';

class CalPage extends StatefulWidget {
  const CalPage({super.key});

  @override
  State<CalPage> createState() => _CalPageState();
}

class _CalPageState extends State<CalPage> {
  
  
  final formKeyC = GlobalKey<FormState>();


  FirestoreService bs = FirestoreService();
  var piezasController = TextEditingController();
  
  final diasController = TextEditingController();
  int minutosTotales = 0;

  
  @override
  void initState() {
    // TODO: implement initState
    setState(() {      
      super.initState();  
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    piezasController.dispose();
    diasController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    
    final calculoProvider = Provider.of<CalculoProvider>(context);
    return Stack(
      children: [
        _fondoCalculo(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Form(
                    key: formKeyC,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10.0)),
                        Container(
                              padding: const EdgeInsets.all(10),
                              height: 200,
                              alignment: Alignment.center,
                              decoration:const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 232, 117, 253),
                                    Color.fromARGB(255, 250, 253, 255)
                                  ]
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(-5,5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    blurStyle: BlurStyle.solid
                                  )
                                ]
                              ),
                              child: const Image(
                                height: 80,
                                //width: 20,
                                image: AssetImage("assets/images/logo_prev_ui.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                        const SizedBox(height: 10,),
                        const Divider(),
                        Text(
                          "Cálcular el personal requerido para sanac".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Caveat'
                          ),
                        ),
                        const SizedBox(height: 20.0,),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: piezasController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Piezas",
                            helperText: "Introduce la cantidad de piezas que requieres",
                            icon: const Icon(Icons.monitor_weight_outlined),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if(value == ""){
                              return "Coloca el # de piezas";
                            }
                          },
                          onChanged: (value) {
                            if(value.isEmpty){
                              return ;
                            }
                            int numP = int.parse(piezasController.text);
                            calculoProvider.setPiezas(numP);
                          },
                        ),
                        const SizedBox(height: 20.0,),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: diasController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                            suffixText: 'días',
                            hintText: "Los dias mínimos son 30",
                            helperText: "Introduce en cuantos días requieres las piezas",
                            icon: const Icon(Icons.timer),
                            fillColor: Colors.white,
                            filled: true,
                          ),                          
                          validator: (value) {
                            if(value == ""){
                              return "Coloca el # de días";
                            }
                            if(int.parse(value!) > 31){
                              return "No puedes colocar más de 31 días";
                            }                            
                          },
                          onChanged: (value) {
                            if(value.isEmpty){
                              return ;
                            }
                            int numP = int.parse(diasController.text);
                            calculoProvider.setDias(numP);
                          },
                          
                        ),
                        const SizedBox(height: 20.0,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color:const Color.fromARGB(129, 16, 54, 246),
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: TextButton(
                              child: Text(
                                "Realizar cálculo".toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              onPressed: () {
                                if(formKeyC.currentState!.validate()){
                                  showDialog(
                                    context: context, 
                                    builder: (context) {
                                      return AlertDialog(
                                        elevation: 10.0,
                                        scrollable: true,
                                        actions: [
                                          TextButton.icon(
                                            onPressed: () {
                                              calculoProvider.resultadoDeCalculoCorte();
                                              calculoProvider.resultadoRimado();
                                              calculoProvider.resultadoAbocardado();
                                              calculoProvider.resultadoInsPro();
                                              calculoProvider.resultadoEmpaque();
                                              Navigator.pop(context);
                                              setState(() {
                                                piezasController.text="";
                                                diasController.text="";
                                              });
                                            },
                                            label:const Text("Regresar",style: TextStyle(color: Colors.white),),
                                            icon:const Icon(Icons.arrow_circle_left_sharp,color: Colors.black,)
                                          )
                                        ],
                                        icon: const Icon(Icons.question_answer,color: Colors.white,size: 30,),
                                        backgroundColor: Colors.purple.shade200,
                                        title:const Text(
                                          "A continuacion, se muestra el personal sugerido para llevar a cabo el pedido",
                                          textAlign: TextAlign.justify,
                                        ),
                                        content: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding:const EdgeInsets.all(5),
                                              child: Text(
                                                'Total de operadores en corte: ${calculoProvider.resultadoDeCalculoCorte().toString()}',
                                                style:const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:const EdgeInsets.all(10),
                                              child: Text(
                                                'Total de operadores en rimado: ${calculoProvider.resultadoRimado().toString()}',
                                                style:const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:const EdgeInsets.all(10),
                                              child: Text(
                                                'Total de operadores en abocardado: ${calculoProvider.resultadoAbocardado().toString()}',
                                                style:const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                'Total de operadores en insepccion-proceso: ${calculoProvider.resultadoInsPro().toString()}',
                                                style:const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold, 
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                'Total de operadores en empaque: ${calculoProvider.resultadoEmpaque().toString()}',
                                                style:const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      );  
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
}

Widget _fondoCalculo(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
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
        ),
        
      ],
    ),
  );
}

