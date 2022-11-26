import 'package:festa/domain/models/discoteca.dart';
import 'package:festa/domain/repositories/disco_repository.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../domain/exceptions/app_exception.dart';

class DiscoMongodb extends DiscoRepository {
  final String connectionString;
  final String collection;

  DiscoMongodb({required this.connectionString, required this.collection});

  @override
  Future<List<Discoteca>> getDiscos() async{
    try {
      List<Discoteca> discoList = [];
      var db = await Db.create(connectionString);
      await db.open();
      var discoResponse =
          await db.collection(collection).find().toList();

      for (var discoMap in discoResponse) {
        discoList.add(Discoteca.fromJson(discoMap));
      }
      db.close();
      return discoList;
    } catch (e) {
      throw AppException(
          errorMessage:
              'Failed to establish connection with data repository. ${e.toString()}');
    }
  }
}