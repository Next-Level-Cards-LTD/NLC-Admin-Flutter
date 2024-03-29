library Database;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:next_level_admin/Authentication/ErrorMessageHandlers/ErrorMessages_Authentication.dart';
import 'package:next_level_admin/Authentication/Types/User.dart' as User;

part "package:next_level_admin/Authentication/Services/Auth.dart";


final String uid = FirebaseAuth.instance.currentUser!.uid;

final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");
final CollectionReference YuGiOhCardDatabase = FirebaseFirestore.instance.collection("YuGiOh Cards");
final CollectionReference APIConfigs = FirebaseFirestore.instance.collection("API Configs");
final CollectionReference orderCollection = FirebaseFirestore.instance.collection("Orders");

