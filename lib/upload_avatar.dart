import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gdg_sfax/home.dart';
import 'package:gdg_sfax/main.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadAvatar extends StatefulWidget {
  const UploadAvatar({super.key});
  static const String id = "/UploadAvatar";
  @override
  State<UploadAvatar> createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  var image = Rxn<XFile>();
  XFile? imagex;
  final ImagePicker _picker = ImagePicker();

  final storageRef = storage.ref();

  Future uploadFile(File file) async {
    final avatarRef = storageRef.child(file.path.split('/').last);
    try {
      await avatarRef.putFile(file);
    } catch (e) {
      print("There was an Ecveption ====== $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 50,
          ),
        ),
        title: Text(args),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(Container(
                height: 200,
                width: 400,
                color: Colors.amber,
                child: Center(
                  child: Text("BOTTOM SHEET example"),
                ),
              ));
            },
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Upload your Avatar",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            GestureDetector(
              onTap: () async {
                XFile? _selected =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (_selected != null) {
                  image.value = XFile(_selected.path);
                  await uploadFile(File(image.value!.path));
                }
              },
              child: Obx(() => Container(
                    width: MediaQuery.sizeOf(context).width * .8,
                    height: MediaQuery.sizeOf(context).width * .8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: image.value == null
                        ? null
                        : Image.file(
                            File(image.value!.path),
                            fit: BoxFit.fill,
                          ),
                  )),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomePage.id,
                    arguments: {"username": args, "image": image.value!.path});
              },
              style: TextButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  fixedSize: Size(MediaQuery.sizeOf(context).width * .8, 20)),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String username;

  ScreenArguments(this.username);
}
