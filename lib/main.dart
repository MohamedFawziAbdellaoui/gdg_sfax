import 'package:flutter/material.dart';
import 'package:gdg_sfax/login.dart';
import 'package:gdg_sfax/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
      },
      initialRoute: "login",
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
