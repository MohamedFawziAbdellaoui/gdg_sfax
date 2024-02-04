import 'package:flutter/material.dart';

import 'main.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  static const String id = "Signup";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? name;
  String? password;
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
                    hintText: "example name",
                    labelText: "Username",
                    icon: Icons.person,
                    validate: (val) {
                      return null;
                    },
                    save: (val) {
                      name = val;
                    },
                  ),
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
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
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
                        print("Do not Have an account ?");
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
