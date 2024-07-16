import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_tecnoformas/pages/auth_page.dart';
import 'package:proyecto_tecnoformas/pages/calculoPage.dart';
import 'package:proyecto_tecnoformas/pages/compBocar.dart';
import 'package:proyecto_tecnoformas/pages/cronometro.dart';
import 'package:proyecto_tecnoformas/pages/homePageAdmin.dart';
import 'package:proyecto_tecnoformas/pages/loginPage.dart';
import 'package:proyecto_tecnoformas/pages/primerPagAdmin.dart';
import 'package:proyecto_tecnoformas/pages/principalPage.dart';
import 'package:proyecto_tecnoformas/pages/registroPage.dart';
import 'package:proyecto_tecnoformas/pages/resultados.dart';
import 'package:proyecto_tecnoformas/pages/sanacPage.dart';
import 'package:proyecto_tecnoformas/pages/verUsuariosPage.dart';
import 'package:proyecto_tecnoformas/providers/calculo.dart';
import 'package:proyecto_tecnoformas/providers/crono_provider.dart';
import 'package:proyecto_tecnoformas/providers/usuario_provider.dart';
import 'package:proyecto_tecnoformas/services/firebase_services.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        StreamProvider(
          create: (context) => firestoreService.getUsu(),
          initialData: null,
        ),
        ChangeNotifierProvider(create: (_)=>CronoProvider()),
        FutureProvider(
          create: (context) => firestoreService.getCronometro(),
          initialData: null,
        ),
        ChangeNotifierProvider(create: ((context) => CalculoProvider()))        
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Proyecto",
            initialRoute: 'auth',
            routes: {
              'auth':(context) => const AuthPage(),
              'login':(context) => const loginPage(),
              'principal':(context) => const  PrincipalPage(),
              'registro':(context) => const RegistroPage(),
              'bocar':(context) => const CompBocar(),
              'calculo':(context) => const CalPage(),
              'homeAdmin':(context) => const HomePageAdmin(),
              'primerAdmin':(context) => const PrimerPageAdmin(),
              'verUsuPage':(context) => const VerUsuariosPage(),
              'crono':(context) => const CronometroPage(),
              'sanac':(context) => const SanacPage(),
              'resultados':(context) => const restultadosCalc(),
            },
            onGenerateRoute: (settings){
              return MaterialPageRoute(
                builder: (context) => const loginPage()
              );
            }
          );
      },),
    );
  }
}

    