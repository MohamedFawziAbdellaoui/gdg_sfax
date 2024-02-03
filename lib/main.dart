import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
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




                    
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final bool obscure;
  final bool isValidated;
  final String? Function(String) validate;
  final void Function(String?) save;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.validate,
    required this.save,
    this.isValidated = false,
    this.obscure = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isValid = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 35,
        right: 15,
        left: 15,
      ),
      child: TextFormField(
        obscureText: widget.obscure,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          hintText: widget.hintText,
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isValidated
              ? Icon(
                  Icons.done,
                  color: isValid ? Colors.green : Colors.red,
                )
              : null,
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        validator: (value) {
          if (value == null) {
            return "Cannot be null";
          } else {
            return widget.validate(value);
          }
        },
        onChanged: (value) {
          setState(() {
            print(isValid);
          if (value.contains("@")) {
            isValid = true;
            print(isValid);
          } else {
            isValid = false;
            print(isValid);
          }
          });
        },
        onSaved: (val) {
          widget.save(val);
        },
      ),
    );
  }
}
