import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget{
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Future<List<dynamic>> getdata()async{
    var res =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    return jsonDecode(res.body);
  }

  dynamic response;

  @override
  void initState() {
    response = getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: response,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context ,int i){
                  return ListTile(
                    leading:ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      child: Image.network('https://scontent.fcai20-1.fna.fbcdn.net/v/t39.30808-6/292290941_1753532181651819_6391967672588301943_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=174925&_nc_ohc=Pz2G0M4eXH4AX_AEx7X&_nc_ht=scontent.fcai20-1.fna&oh=00_AT9QRQ4pDKYvhIvT4mEBdfB3JrwyR7yt7GD6qMIYoehdSQ&oe=62F3A906'),
                    ), 
                    title: Text('${(snapshot.data[i]['id']).toString()}'),
                    subtitle: Text(snapshot.data[i]['title']),
                  );
                });
          }else{
            return Center(
              child:CircularProgressIndicator() ,
            );
          }
        },

      ),
    );
  }
}