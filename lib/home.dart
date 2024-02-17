import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gdg_sfax/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = "/Home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final gsReference = storage.refFromURL("gs://gdg-sfax-01.appspot.com");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 50,
            foregroundImage: args["image"] != null
                ? NetworkImage(args["image"])
                : null,
          ),
        ),
        title: Text(args["username"]),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active_outlined),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
