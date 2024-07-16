import 'package:proyecto_tecnoformas/pages/calculoPage.dart';
import 'package:proyecto_tecnoformas/pages/primerPagAdmin.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {

  int _pagActual=0;

  final List<Widget> _paginas=[
    const PrimerPageAdmin(),
    const CalPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: 
      _paginas[_pagActual],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        backgroundColor:const Color.fromARGB(255, 115, 7, 142),
        onTap: (index){
          setState(() {
            _pagActual = index;
          });
        },
        fixedColor:const Color.fromARGB(255, 255, 255, 255),
        currentIndex: _pagActual,
        items: [
          BottomNavigationBarItem(
            label: "Inicio".toUpperCase(),
            icon: const Icon(Icons.home),
            
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calculate),
            label: "Cálculo".toUpperCase()
          )
        ],
      ),
    );
  }
}