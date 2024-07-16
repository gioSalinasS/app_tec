import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_tecnoformas/providers/usuario_provider.dart';
import 'package:email_validator/email_validator.dart';



class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}


class _RegistroPageState extends State<RegistroPage> {

  final formKey = GlobalKey<FormState>(); 
  
  String mensaje="";
  String nomValid="";
  String contraValid="";
  //datos de las variables con TextEditingController
  final nombreController = TextEditingController();
  final appMatController = TextEditingController();
  final appPatController=TextEditingController();
  final direccionController = TextEditingController();
  final numeroController = TextEditingController();
  final nomUsuController = TextEditingController();
  final passController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    nombreController.dispose();
    appMatController.dispose();
    appPatController.dispose();
    direccionController.dispose();
    numeroController.dispose();
    nomUsuController.dispose();
    passController.dispose();
    super.dispose();
  }

  //formato del número
  var maskPhone = MaskTextInputFormatter(mask: '###-###-####',filter: {"#":RegExp(r'[0-9]')});

  Future crearUsuario()async{
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try{
      if(nomUsuController.text != null && passController.text != null){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: nomUsuController.text.trim(),
          password: passController.text.trim()
        );
      }
    }on FirebaseAuthException catch(error){
      Navigator.pop(context);      
    }
  }/////aqui termina el metodo para crear usuario en firebase de login
  
  //////validar correo///////////////////*
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
  Widget build(BuildContext context) {
    final usuarioProvider =  Provider.of<UsuarioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de administradores"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.blue
              ]
            )
          ),
        ),
      ),
      body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 10.0)),
              const Text("Llena todos los campos que se presentan a continuación",
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15.0,),
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: "Nombre(s)",
                  helperText: nomValid,
                  icon: const Icon(Icons.person),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  usuarioProvider.setNombre(value.toUpperCase());
                },
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: TextFormField(
                      controller: appPatController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        hintText: "Apellido Paterno",
                        icon: const Icon(Icons.person),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (value) {
                        usuarioProvider.setAppPat(value.toUpperCase());
                      },
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width*0.4,
                    child: TextFormField(
                      controller: appMatController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        hintText: "Apellido Materno",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (value) {
                        usuarioProvider.setAppMat(value.toUpperCase());
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15.0,),
              TextFormField(
                controller: direccionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: "Domicilio Mz. Lt. Col. Municipio.",
                  icon: const Icon(Icons.directions),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  usuarioProvider.setDireccion(value);   
                },
              ),
              const SizedBox(height: 15.0,),
              TextFormField(
                inputFormatters: [maskPhone],
                controller: numeroController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: "Número de teléfono",
                  icon: const Icon(Icons.phone),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  usuarioProvider.setNumero(value);        
                },
              ),              
              const SizedBox(height: 10.0,),
              const Text(
                "Escribe el correo electronico exlusivo para la empresa, ya que será usado para iniciar sesión y, al mismo tiempo, escribe una contraseña.",
                style: TextStyle(fontSize: 15.0),textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 15.0,),
              /////correo de usuario////////////////////
              TextFormField(
                controller: nomUsuController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Ej: juan@dominio.com',
                  icon: const Icon(Icons.email),
                  fillColor: Colors.white,
                  filled: true,
                  helperText: mensaje
                ),
                onChanged: (value) {
                  EmailValidator.validate(value);
                  usuarioProvider.setNomUsu(value);
                },
              ),
              const SizedBox(height: 5.0,),
              TextFormField(
                controller: passController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: "Contraseña",
                  helperText: contraValid,
                  icon:const Icon(Icons.security),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  usuarioProvider.setContra(value);
                },
              ),
              
              const SizedBox(height: 10.0,),
        
              //boton para enviar los datos/////////////////////////////////
              ElevatedButton(
              style: TextButton.styleFrom(
                elevation: 10.0,
                alignment:const Alignment(10,10),
                backgroundColor: const Color.fromARGB(255, 96, 96, 212),
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              ),onPressed: ()async{
                if(formKey.currentState!.validate()){
                  await usuarioProvider.guardarUsuario();
                  crearUsuario();
                  Navigator.pop(context);
                }
                setState(() {
                  nomUsuController.text="";
                  passController.text="";
                  numeroController.text="";
                  direccionController.text="";
                  appMatController.text="";
                  appPatController.text="";
                  nombreController.text="";
                });
              },
              child: const Text("Registrarme", style: TextStyle(fontSize: 20),)
              )
            ],
          ),
        ),
      ),
      )
      
    );
  }
}


