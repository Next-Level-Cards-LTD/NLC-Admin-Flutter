library Database;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:next_level_admin/Authentication/ErrorMessageHandlers/ErrorMessages_Authentication.dart';
import 'package:next_level_admin/Authentication/Types/User.dart' as User;
import 'package:next_level_admin/Shared/FirestoreDB.dart';

part "package:next_level_admin/Authentication/Services/Auth.dart";


final String uid = FirebaseAuth.instance.currentUser!.uid;

//final String userCollection = "Users";
//final String YuGiOhCardDatabase = "YuGiOh Cards";
//final String APIConfigsCollection = "API Configs";
//final String orderCollection = "Orders";


