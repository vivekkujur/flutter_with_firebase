import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key, required this.id, required this.action});
  final String id;
  final String action;


  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    homeController.postInputController.clear();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Posts",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: homeController.postInputController,
              maxLines: 4,
              decoration: const InputDecoration(
                  hintText: 'What is in your mind?',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 20)),
              onPressed: () {
                homeController.databaseRef.value.child(id).set({
                  'id':id,
                  "title": homeController.postInputController.text
                }).then((onValue) {
                  homeController.postInputController.clear();
                  Fluttertoast.showToast(msg: '$action Added');
                }).onError((error, stacktrace) {
                  Fluttertoast.showToast(msg: error.toString());
                });
              },
              child:  Text(
                "$action Posts",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
