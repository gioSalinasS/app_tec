import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_tecnoformas/pages/principalPage.dart';


class HomePageAdmin extends StatefulWidget {
  
  const HomePageAdmin({super.key});
  
  @override
  
  State<HomePageAdmin> createState() => _HomePageAdminState();
  
}

class _HomePageAdminState extends State<HomePageAdmin> { 
  
  int botonActual = 0;
  
  

  void _cerrarSesion()async{
     setState(() {});
     await FirebaseAuth.instance.signOut(); 
  }
  

  @override
  void initState() {
    // TODO: implement initState
    
    setState(() {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor:const Color.fromARGB(191, 90, 46, 98),
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.blue
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft
                  )
                ),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    /////////////////avatar//////////
                    const CircleAvatar(
                      backgroundColor: Color.fromARGB(108, 255, 255, 255),
                      radius: 80.0,
                      child: ClipOval(
                        child: Image(
                          width: 200.0,
                          height: 200.0,
                          image: AssetImage("assets/images/tubing_2.png"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Text("tecnoformas Automotrices S.A de C.V".toUpperCase(),
                      style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ), 
                    const SizedBox(height: 10.0,),
                    const Text("Seguridad y calidad para tu comodidad",style: TextStyle(color: Colors.white),),
                    const SizedBox(height: 10.0,),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                alignment: AlignmentDirectional.topStart,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.orange,
                    ]
                  )
                ),
                child: TextButton.icon(
                  icon: const Icon(Icons.person_add,color: Colors.white,),
                  label: const Text("Registrar nuevo administrador",style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.pushNamed(context, 'registro');
                  },
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Administrador TecnoAPP"),
        centerTitle: true,
        leading: const Icon(Icons.manage_accounts_sharp,size: 40,),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            iconSize: 30.0,
            onPressed: () {
              setState(() {});
              _cerrarSesion();
            },
          ),
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
      body: const PrincipalPage()
    );
  }
}