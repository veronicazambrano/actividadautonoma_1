import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
class ListaCompletaScreen extends StatelessWidget {
  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse("https://jritsqmet.github.io/web-api/peliculas2.json"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista Completa")),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item['imagen'] ?? ''),
                  ),
                  title: Text(item['nombre'] ?? 'Sin nombre'),
                  subtitle: Text(item['especialidad'] ?? 'Sin especialidad'),
                );
              },
            );
          }
        },
      ),
    );
  }
}