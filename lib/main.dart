import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _jsonValue = await getJsonData();
  print(_jsonValue[0]);
  String _title = _jsonValue[0]['title'];
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Http Requests",
    home: Scaffold(
      appBar: AppBar(
        title: Text('HTTP Requests'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: _jsonValue.length,
            padding: EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) return Divider();
              final int index = position ~/ 2;
              return ListTile(
                  title: new Text(
                    "${_jsonValue[index]['title']}",
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  subtitle: Text(
                    "${_jsonValue[index]['body']}",
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Text(
                      "${_jsonValue[index]['title'][0]}",
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  onTap: () =>
                      _showMyMessage(context, "${_jsonValue[index]['title']}"));
            },
          )),
    ),
  ));
}

void _showMyMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text("My Alert"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('ok'),
      )
    ],
  );
  showDialog(context: context, child: alert);
}

Future<List> getJsonData() async {
  String urlApi = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(urlApi);
  return json.decode(response.body);
}
