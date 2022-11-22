import 'dart:convert';
import 'package:api_demo/screens/screen_three.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*-------------------------- complex nested json data without making MODEL ---------------------------------*/
// use this approach only in any emargency statution...not recommended this way

class ScreenFour extends StatefulWidget {
  const ScreenFour({Key? key}) : super(key: key);

  @override
  State<ScreenFour> createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  var data;

  // code's for Api's.............
  Future<void> getUuserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Demo Tutorials'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          // action button
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUuserApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(color: Colors.green));
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.cyanAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReUsbaleRow(
                                title: 'Name',
                                value: data[index]['name'].toString()),
                            ReUsbaleRow(
                                title: 'Username',
                                value: data[index]['username'].toString()),

                            /*------------------------------- how to get data from nested json ---------------------------------------*/
                            ReUsbaleRow(
                                title: 'Address',
                                value:
                                    data[index]['address']['city'].toString()),
                            ReUsbaleRow(
                                title: 'lat',
                                value: data[index]['address']['geo']['lat']
                                    .toString()),
                            ReUsbaleRow(
                                title: 'lng',
                                value: data[index]['address']['geo']['lng']
                                    .toString()),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
