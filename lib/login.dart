import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdg_sfax/home.dart';
import 'package:gdg_sfax/signup.dart';
import 'package:gdg_sfax/upload_avatar.dart';
import 'package:get/get.dart';

import 'main.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String id = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email;

  String? password;

  Future<UserCredential?> login(String mail, String pass) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: pass,
      );
    } catch (e) {
      Get.dialog(const Scaffold(
        body: Center(
          child: Text("Either wrong mail or password"),
        ),
      ));
      return null;
    }
  }

  bool isLoginBtnPressed = false;
  CollectionReference users = firestore.collection('user');
  dynamic userData;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/GDG.png",
                height: MediaQuery.sizeOf(context).height * .2,
                width: MediaQuery.of(context).size.width,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Getting Started",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Let's login",
                    style: TextStyle(
                        fontSize: 20,
                        //#9B9B9B
                        color: Color(0xff9B9B9B)),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  CustomTextField(
                    hintText: "example@gmail.com",
                    labelText: "Email",
                    icon: Icons.email,
                    isValidated: true,
                    validate: (val) {
                      if (!val.contains("@")) {
                        return "Enter a valid mail";
                      } else {
                        return null;
                      }
                    },
                    save: (val) {
                      email = val;
                    },
                  ),
                  CustomTextField(
                    hintText: "password",
                    labelText: "Password",
                    icon: Icons.lock,
                    obscure: true,
                    validate: (val) {
                      if (val.length < 8) {
                        return "Passowrd must be att least 8 characters";
                      } else {
                        return null;
                      }
                    },
                    save: (value) {
                      password = value;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        print("Forget Password");
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 20,
                        ),
                        child: Text(
                          "forget password ?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: !isLoginBtnPressed
                        ? () async {
                            setState(() {
                              isLoginBtnPressed = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              UserCredential? creds =
                                  await login(email!, password!);
                              setState(() {
                                isLoginBtnPressed = false;
                              });
                              if (creds != null) {
                                var allUsers = await users.get();
                                userData = allUsers.docs
                                    .where((element) {
                                      return element["email"] == email;
                                    })
                                    .map((e) => e.data())
                                    .first;
                                print(userData);
                                if (userData["imgPath"] == "") {
                                  Get.toNamed(UploadAvatar.id,
                                      arguments: email);
                                } else {
                                  String path = await storage
                                      .ref()
                                      .child(userData["imgPath"])
                                      .getDownloadURL();
                                  Get.toNamed(HomePage.id, arguments: {
                                    "username": userData["name"],
                                    "image": path
                                  });
                                }
                              }
                            }
                          }
                        : null,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUp.id);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 20,
                        ),
                        child: Text(
                          "Do not Have an account ?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
