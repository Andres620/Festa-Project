// ignore_for_file: implementation_imports, library_prefixes

import 'package:festa/domain/models/promocion.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/basic.dart' as Center;

import '../../config/provider/disco_provider.dart';
import '../../domain/models/evento.dart';

class ListPromotionsByDiscoScreen extends StatelessWidget {
  final ObjectId? discoId;
  const ListPromotionsByDiscoScreen(this.discoId, {super.key});

  @override
  Widget build(BuildContext context) {
    final discoProvider = Provider.of<DiscoProvider>(context);
    return SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      FutureBuilder<List<Promocion>>(
        future: discoProvider.cuListDisco.getPromosByDiscos(discoId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      Promocion promotion = snapshot.data![index];
                      return _buidCards(promotion);
                    }))
                : const Text("La discoteca no tiene eventos en este momento");
          } else if (snapshot.hasError) {
            return Text('${snapshot.hasError}',
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontSize: 18.0, color: Color.fromARGB(255, 235, 238, 39)));
          }
          return const Center.Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
          );
        },
      )
    ]));
  }

  /// Builds the structure to display the information of an event.
  Widget _buidCards(Promocion promotion) {
    return Card(
        child: ListTile(
            title: Text(promotion.descripcion),
            subtitle: Text(
                'Válido hasta: ${promotion.fechaFin.year} - ${promotion.fechaFin.month} - ${promotion.fechaFin.day}'),
            leading: Image.network(promotion.imagen),
            trailing: const Icon(Icons.arrow_forward_rounded)));
  }
}
