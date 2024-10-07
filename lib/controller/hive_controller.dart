import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HiveController extends GetxController{


  final postInputController = TextEditingController();
  var databaseRef= FirebaseDatabase.instance.ref('Posts').obs;
  final searchInputController = TextEditingController();
  var searchText = "".obs;



  setSearchTxt (value )=> searchText.value = value;

  setSearchRef()=>databaseRef.value = FirebaseDatabase.instance.ref('Posts');


}