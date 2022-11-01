import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'album.dart';


Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http://techintor.online/flutter.json'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}


class home extends StatefulWidget{
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Fetch Data',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Fetch Data'),
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.title,style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 30,),
                      Image.network(snapshot.data!.img,width: 240,height: 240),
                    ],
                  );
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

}
