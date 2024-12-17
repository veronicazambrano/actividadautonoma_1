 import 'package:flutter/material.dart';
import 'package:movie_application_1/screen/listaExter.dart';
import 'package:movie_application_1/screen/listaLocal.dart';



void main(){
  runApp(app());
 }

 class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Cuerpo(),
    );
  }
}
class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inicio")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Ver Lista Completa"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaCompletaScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text("Buscar en la Lista"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaFiltradaScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
