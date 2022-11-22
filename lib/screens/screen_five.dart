import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/products_model.dart';

/*----------------------------- Very complex json data using Api calling --------------------------------*/
//nest objects - arrays in nests json objects

class ScreenFive extends StatefulWidget {
  const ScreenFive({Key? key}) : super(key: key);

  @override
  State<ScreenFive> createState() => _ScreenFiveState();
}

class _ScreenFiveState extends State<ScreenFive> {
  Future<ProductsModel> getProductsApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/603fa33c-4f3c-431f-b1a7-714706178396'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
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
            child: FutureBuilder<ProductsModel>(
              future: getProductsApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(color: Colors.green));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: ListTile(
                              title: Text(snapshot.data!.data![index]
                                  .products![index].description
                                  .toString()),
                              subtitle: Text(snapshot
                                  .data!.data![index].products![index].title
                                  .toString()),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data!
                                      .data![index]
                                      .products![index]
                                      .images![index]
                                      .url
                                      .toString())),
                            ),
                          ),
                          // Container(
                          //   height: MediaQuery.of(context).size.height * 0.5,
                          //   width: MediaQuery.of(context).size.width,
                          //   child: ListView.builder(itemBuilder: (context,position){
                          //     return Container(
                          //       decoration: BoxDecoration(
                          //         color: Colors.cyanAccent,
                          //         image: DecorationImage(
                          //           image: NetworkImage(snapshot.data!.data![index]
                          //               .products![index].images![index].url
                          //               .toString()),
                          //         ),
                          //       ),
                          //     );
                          //   }),
                          //
                          // )
                        ],
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
