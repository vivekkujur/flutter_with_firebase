import 'package:android_fb_flutter/controller/home_controller.dart';
import 'package:android_fb_flutter/view/add_firestore_posts.dart';
import 'package:android_fb_flutter/view/add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../controller/firestore_controller.dart';

class FirestoreHomeScreen extends StatelessWidget {
  const FirestoreHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreController homeController = Get.put(FirestoreController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'flutter firebase CRUD',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: homeController.searchInputController,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                homeController.setSearchTxt(value);
                homeController.setSearchRef();
              },
            ),
          ),
          // Text(
          //   "Firebase Animated List ",
          //   style: TextStyle(fontSize: 20),
          //   textAlign: TextAlign.start,
          // ),
          // Text(
          //   "show list from realtime firebase",
          //   style: TextStyle(fontSize: 12),
          //   textAlign: TextAlign.start,
          // ),
          //
          // Divider(),

          // Obx(()=> Expanded(
          //   child: FirebaseAnimatedList(
          //       defaultChild: Text("loading"),
          //       query: homeController.databaseRef.value,
          //       itemBuilder: (context, snapshot, animation, index) {
          //         final title = snapshot.child('title').value.toString();
          //         print(title);
          //         if (homeController.searchText.value.isEmpty) {
          //           return ListTile(
          //             title: Text(snapshot.child('title').value.toString()),
          //             subtitle: Text(snapshot.child('id').value.toString()),
          //           );
          //         } else if (title.toLowerCase().contains(homeController
          //             .searchText.value
          //             .toLowerCase())) {
          //           return ListTile(
          //             title: Text(snapshot.child('title').value.toString()),
          //             subtitle: Text(snapshot.child('id').value.toString()),
          //           );
          //         } else {
          //           return Container(
          //             child: Text("result not found"),
          //           );
          //         }
          //       }),
          // ),),

          const Divider(),
          const Text(
            "StreamBuilder and listView Builder ",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.start,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "get list from firebase in form of stream and show in listview. builder list widgets. ",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),

          const Divider(),
          Obx(() => Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: homeController.databaseRef.value.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    var list = snapshot.data?.docs ?? [];

                    if (homeController.searchText.value.isEmpty) {
                      list = snapshot.data?.docs ?? [];
                    } else {
                      list = snapshot.data?.docs
                              .where((s) => s['title'].toLowerCase().contains(
                                  homeController.searchText.value
                                      .toLowerCase()))
                              .toList() ??
                          [];
                    }

                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(list[index]['title']),
                              subtitle: Text(list[index]['id']),
                              trailing: PopupMenuButton(
                                  icon: const Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 0,
                                          child: const ListTile(
                                              leading: Icon(Icons.edit),
                                              title: Text('Edit')),
                                          onTap: () {
                                            Get.to(AddFirestorePosts(
                                              id: list[index]['id'],
                                              action: 'Edit',
                                            ));
                                          },
                                        ),
                                        PopupMenuItem(
                                            value: 1,
                                            child: ListTile(
                                              leading: Icon(Icons.delete),
                                              title: Text('Delete'),
                                              onTap: () {
                                                homeController.databaseRef.value.doc(list[index]['id']).delete();
                                              },
                                            ))
                                      ]),
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddFirestorePosts(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            action: 'Add',
          ));
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
