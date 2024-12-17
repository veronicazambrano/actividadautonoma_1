import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';


class ListaFiltradaScreen extends StatefulWidget {
  @override
  _ListaFiltradaScreenState createState() => _ListaFiltradaScreenState();
}

class _ListaFiltradaScreenState extends State<ListaFiltradaScreen> {
  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("https://jritsqmet.github.io/web-api/peliculas2.json"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _data = data;
        _filteredData = data;
        _isLoading = false;
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  void _filterList(String query) {
    final filtered = _data.where((item) {
      final name = item['nombre']?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredData = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filtrar Lista")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: _filterList,
                    decoration: InputDecoration(
                      labelText: "Buscar",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredData.length,
                    itemBuilder: (context, index) {
                      final item = _filteredData[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item['imagen'] ?? ''),
                        ),
                        title: Text(item['nombre'] ?? 'Sin nombre'),
                        subtitle: Text(item['especialidad'] ?? 'Sin especialidad'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
