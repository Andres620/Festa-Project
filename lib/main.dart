import 'package:festa/app.dart';
import 'package:festa/services/local_notifications_service.dart';
import 'package:flutter/material.dart';
import 'data/datasources/mongodb/mongodb.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await MongoDatabase.connect();
  runApp(const Festa());
}
