import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}


class _loginPageState extends State<loginPage> {

  String mensaje="";
  final correoUsu = TextEditingController();
  final passController = TextEditingController();

  void _iniciarSesion() async{
    
    showDialog(
      context: context,
      builder: ((context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      })
    );
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: correoUsu.text,
      password: passController.text
    );
    Navigator.pop(context);
  }on FirebaseAuthException catch(e){
    Navigator.pop(context);
    print(e);
    if(e.code == 'unknown'){
      _isEmpty();
    }
    if(e.code == 'user-not-found'){
      _correoInva();
    }
    if(e.code == 'invalid-email'){
      _fomatInco();
    }
    if(e.code == 'wrong-password'){
      _passInva();
    }
    if(e.code == 'network-request-failed'){
      _probRed();
    }
    if(e.code == 'too-many-requests'){
      _manyReque();
    }
  }

  }

  void _isEmpty(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent.shade200,
          elevation: 10,
          iconColor: Colors.yellow,
          icon:const  Icon(Icons.error,size: 50,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          title: const Text("-- Sin datos --"),
          content: const Text("Algún campo esta en blanco, favor de llenarlo como es debido"),
        );
      },
    );
  }

  void _correoInva(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent.shade200,
          elevation: 10,
          iconColor: Colors.yellow,
          icon:const  Icon(Icons.error),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          title: const Text("Correo inválido"),
          content: const Text("El correo no se encuentra registrado"),
        );
      },
    );
  }

  void _probRed(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent.shade200,
          elevation: 10,
          iconColor: Colors.yellow,
          icon:const  Icon(Icons.error),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          title: const Text("Problema de conexión"),
          content: const Text("La conexion de red es inestable"),
        );
      },
    );
  }


  void _fomatInco(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent.shade200,
          elevation: 10,
          iconColor: Colors.yellow,
          icon:const  Icon(Icons.error),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          title: const Text("Formato de correo incorrecto"),
          content: const Text("Favor de ingresar un correo válido"),
        );
      },
    );
  }

  void _passInva(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent.shade200,
          elevation: 10,
          iconColor: Colors.yellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          icon: const Icon(Icons.error),
          title: const Text("Contraseña incorrecta"),
          content: const Text("La contraseña no coincide"),
        );
      },
    );
  }

  void _manyReque(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return  AlertDialog(
          backgroundColor: Colors.deepPurpleAccent.shade200,
          elevation: 10,
          iconColor: Colors.yellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          icon:const  Icon(Icons.error),
          title: const Text("Demasiados intentos"),
          content: const Text("Favor de salir y esperar 2 minutos, ya que lleva demasiados intentos y no logra acceder. Asegurese de escribir bien los datos solicitados"),
        );
      },
    );
  }

void validarCorreo(String correo){
    if(EmailValidator.validate(correo)){
      setState(() {
        mensaje = "Es válido el correo";
      });
    }else{
      mensaje = "Introduce un correo válido";
    }
  }
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    correoUsu.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        _fondoLogin(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _card01(context)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

Widget _fondoLogin(){
  return SingleChildScrollView(
    child: Column(    
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.5,
          decoration:const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(350)),
            gradient: LinearGradient(
              colors: [
                  Color.fromARGB(255, 155, 39, 176),
                  Color.fromARGB(255, 19, 138, 202),
                ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height*0.5,
          decoration:const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(350)),
            gradient: LinearGradient(
              colors: [
                  Color.fromARGB(175, 27, 112, 240),
                  Color.fromARGB(226, 155, 39, 176),
                ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
        ),
      ],
    ),
  );
}


//crear la card para dar mejor vista
Widget _card01(BuildContext context){
  return Card(
      shadowColor:const Color.fromARGB(255, 124, 43, 138),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer, 
      color:const Color.fromARGB(146, 238, 168, 247),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: const EdgeInsets.all(10.0), 
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          indicador(),
          const Divider(
            thickness: 10.0,
            color: Color.fromARGB(255, 90, 18, 118),
            height: 10.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
          const SizedBox(height: 10.0,),
          _camposInicio(),
          const SizedBox(height: 10.0,),
          const Divider(),
          botonAcceso(context),
          const SizedBox(height: 20.0,),
        ],
      ),
  );
}

//Campo de usuario
Widget _camposInicio(){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
    child: Form(
      child: Column(
        children: [
          TextFormField(
            controller: correoUsu,
            keyboardType: TextInputType.emailAddress,
            keyboardAppearance: Brightness.dark,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: "Correo electronico",
              suffixIcon: const Icon(Icons.alternate_email),
              helperText: "Ej: carutsjr@gmail.com",
              prefixIcon: const Icon(Icons.email_sharp),
              fillColor:const Color.fromARGB(73, 255, 255, 255),
              filled: true,
            ),
          ),
          const SizedBox(height: 10.0,),
          TextFormField(
            controller: passController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: "Contraseña",
              helperText: "Introduce tu contraseña",
              prefixIcon:const Icon(Icons.security),
              suffixIcon: const Icon(Icons.password),
              fillColor:const Color.fromARGB(73, 255, 255, 255),
              filled: true,
            ),
          ),
        ],
      ),
    ),
  );
}

//indicador y logo de tubing
Widget indicador(){
  return Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Container(
          height: 200,
          decoration:  BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue,Colors.purple,]
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                blurStyle: BlurStyle.solid,
                offset: Offset(0,10),
              )
            ],
            image:const  DecorationImage(
              image: AssetImage("assets/images/tubing_2.png"),
              fit: BoxFit.contain
            ),
            shape: BoxShape.circle,
            border: Border.all(
              width: 2
            )
          ),
        ),
        const SizedBox(height: 20.0,),
        Text(
          "Bienvenido a Tecnoformas APP".toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30.0,
            color: Color.fromARGB(255, 253, 250, 250),
            fontWeight: FontWeight.bold,    
            fontStyle: FontStyle.italic  
          ),
        ),
      ],
    ),
  );
}


//boton para acceder
Widget botonAcceso(BuildContext context){
  return ElevatedButton(
    style: TextButton.styleFrom(
      side: const BorderSide(
        style: BorderStyle.none,
      ),
      backgroundColor:const Color.fromARGB(128, 81, 1, 101),
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      elevation: 20.0
    ),onPressed: () => {
      _iniciarSesion(),
    },
    child: Text(
      "Iniciar sesión".toUpperCase(),
      style:const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}


}