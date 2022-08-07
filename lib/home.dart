import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<List<dynamic>> fetchUsers() async {
    var result =
    await http.get(Uri.parse("https://gorest.co.in/public/v2/users"));
    print('================');
    print(result.body);
    print('================');
    return jsonDecode(result.body);
  }
   dynamic response;
  @override
  void initState() {
    response = fetchUsers();
    super.initState();
  }

  myApiWidget() {
    return FutureBuilder(
      future: response,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Column(
                        children: [
                          Text('${(snapshot.data[index]['id']).toString()}'),
                          Text(snapshot.data[index]['name']),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Text(snapshot.data[index]['email']),
                          Text(snapshot.data[index]['gender']),
                          Text(snapshot.data[index]['status']),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     myApiWidget()
    );
  }
}
