import 'package:android_fb_flutter/controller/hive_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HiveHomeScreen extends StatelessWidget {
  const HiveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HiveController homeController = Get.put(HiveController());

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
          const Divider(),
          const Text(
            "Hive Datatbase  ",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.start,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "save data to locally and show in text widgets",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
          const Divider(),
          FutureBuilder(
              future: Hive.openBox('authBox'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(snapshot.data!.get('name')),
                        subtitle:
                            Text(snapshot.data!.get('details').toString()),
                        trailing: IconButton(
                            onPressed: () {

                              snapshot.data!.put('name', "new name ");

                              // .delete('name')  // for delete

                            }, icon: Icon(Icons.edit)),
                      )
                    ],
                  );
                } else {
                  return Text("press add button to add data ");
                }
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('authBox');
          box.put('name', 'vivek');
          box.put('title', 'developer');
          box.put('details', {'address': 'raipur', 'state': 'chhattisgarh'});

          print(box.get('title'));
          print(box.get('details'));

          // Get.to(AddFirestorePosts(
          //   id: DateTime.now().microsecondsSinceEpoch.toString(),
          //   action: 'Add',
          // ));
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
