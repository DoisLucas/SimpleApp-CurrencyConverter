import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: Home(),
    ));

const request = "https://api.hgbrasil.com/finance?format=json&key=499c0f92";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Moedas"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center (child:
                    Text("Carregando Dados...", style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,)
                );
              default:
                if(snapshot.hasError){
                  return Center (child:
                  Text("Erro ao carregar dados...", style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,)
                  );
                }else{
                  return Container(color: Colors.green);
                }
            }
          }),
    );
  }
}
