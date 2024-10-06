import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController{


  final postInputController = TextEditingController();
  // var databaseRef= FirebaseDatabase.instance.ref('Posts').obs;
  var databaseRef = FirebaseFirestore.instance.collection('posts').obs;
  final searchInputController = TextEditingController();
  var searchText = "".obs;



  setSearchTxt (value )=> searchText.value = value;

  setSearchRef()=>databaseRef.value = FirebaseFirestore.instance.collection('posts');


}