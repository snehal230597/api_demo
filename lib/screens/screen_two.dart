import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*--------------------------- How to make model manual with out automatic plugin ------------------------*/

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  // codes for fetch data from API's.....

  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getPhotosApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photos = PhotosModel(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
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
              future: getPhotosApi(),
              builder: (context,AsyncSnapshot<List<PhotosModel>> snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(color: Colors.green));
                }else {
                  return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                        ),
                        title: Text('Notes ID' +':'+ snapshot.data![index].id.toString()),
                        subtitle: Text(snapshot.data![index].title.toString()),
                      );
                    },
                  );
                }

              },
            ),
          ),
        ],
      ),
    );
  }
}

class PhotosModel {
  String title, url;
  int id;
  PhotosModel({required this.title, required this.url, required this.id});
}
