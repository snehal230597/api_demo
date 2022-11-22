import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

/*--------------------------------- complex nested json data (model_with_plugin) --------------------------------------*/

class ScreenThree extends StatefulWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  //codes for Api's
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userList;
    } else {
      return userList;
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
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(color: Colors.green));
                  }
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReUsbaleRow(
                                    title: 'Name',
                                    value:
                                        snapshot.data![index].name.toString()),
                                ReUsbaleRow(
                                    title: 'Username',
                                    value: snapshot.data![index].username
                                        .toString()),
                                ReUsbaleRow(
                                    title: 'Email',
                                    value:
                                        snapshot.data![index].email.toString()),

  /*------------------------------- how to get data from nested json ---------------------------------------*/
                                ReUsbaleRow(
                                    title: 'Address',
                                    value: snapshot.data![index].address!.city
                                            .toString() +" "+
                                        snapshot.data![index].address!.geo!.lat
                                            .toString() +" "+
                                        snapshot.data![index].address!.geo!.lng
                                            .toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

/*-------------------- Reusable componant class use any where no need to rewrite same code -------------------*/

class ReUsbaleRow extends StatelessWidget {
  String title, value;

  ReUsbaleRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
