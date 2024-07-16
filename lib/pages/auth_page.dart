import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_tecnoformas/pages/homePageAdmin.dart';
import 'package:proyecto_tecnoformas/pages/loginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return const HomePageAdmin();
          }
          else{
            return const loginPage();
          }
        },
      ),
    );
  }
}