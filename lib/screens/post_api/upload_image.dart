import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

/*------------------ Upload File/Image to rest API/Server using Multiport Http Request ----------------------*/

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      print('No image selected');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var requset = new http.MultipartRequest('POST', uri);
    requset.fields['title'] = 'Static field';
    var multiport = new http.MultipartFile('image', stream, length);
    requset.files.add(multiport);
    var response = await requset.send();
      print(response.stream.toString());
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('Image Uploaded!!!');
    } else {
      setState(() {
        showSpinner = false;
      });
      print('Failed!!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Image API'),
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
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: image == null
                    ? Center(child: InkWell(
                     onTap: (){
                       getImage();
                     },
                    child: Text('Pick Image')))
                    : Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(image!.path).absolute,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              SizedBox(height: 100),
              InkWell(
                onTap: () {
                  uploadImage();
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "muli",
                        fontStyle: FontStyle.normal,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
