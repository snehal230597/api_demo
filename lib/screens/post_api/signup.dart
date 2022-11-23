import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

/*------------------------------- POST API - Login & Signup Api -----------------------------*/

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool valueFirst = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // post Api's for login & signup...
  void login(String email, password) async {
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/register'), body: {
        'email': email,
        'password': password,
      });
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print(data['id']);
        print(data);
        print('Account created successfully!!');
      }else{
        print('Failed!!!');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup-Login API'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 70,
                  child: ClipRRect(
                    child: Image.network(
                      'https://miro.medium.com/max/320/0*ObJbOfJnx4QIPUq9.png',
                    ),
                    borderRadius: BorderRadius.circular(70.0),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Welcome Back To Post Api",
                style: const TextStyle(
                    // color: const Color(0xffff2e36),
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontFamily: "muli",
                    fontStyle: FontStyle.normal,
                    fontSize: 22.0),
              ),
              SizedBox(height: 10),
              Text(
                "Sign in to continue",
                style: const TextStyle(
                    color: const Color(0xff262b2e),
                    fontWeight: FontWeight.w400,
                    fontFamily: "muli",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0),
              ),
              SizedBox(height: 70),
              TextFormField(
                controller: emailController,
                onTap: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email id";
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Enter a valid email id";
                  }
                  return null;
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  fillColor: Color(0xfff4f5f7),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                    size: 30,
                    color: Colors.grey,
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                      fontSize: 15, height: 4 / 5, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                onTap: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
               // obscureText: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  fillColor: Color(0xfff4f5f7),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 30,
                    //  color: Colors.grey,
                    color: Colors.grey,
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                      fontSize: 15, height: 4 / 5, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Color(0xffFF2E36),
                            value: this.valueFirst,
                            onChanged: (bool? value) {
                              setState(() {
                                this.valueFirst = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Text(
                        "Remember me",
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontFamily: "muli",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => ForgetPassword1()));
                        },
                        child: Text(
                          "Forget password ?",
                          style: const TextStyle(
                              color: const Color(0xffff2e36),
                              fontFamily: "muli",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  login(emailController.text.toString(),
                      passwordController.text.toString());
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontFamily: "muli",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                  SizedBox(width: 6),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (_) => SignUpScreen2()));
                    },
                    child: Text(
                      "Sign up!",
                      style: const TextStyle(
                          color: Color(0xffff2e36),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "email: eve.holt@reqres.in",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontFamily: "muli",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0),
                  ),
                  SizedBox(width: 6),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (_) => SignUpScreen2()));
                    },
                    child: Text(
                      "pw : pistol",
                      style: const TextStyle(
                          //color: Color(0xffff2e36),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
