import 'package:festa/data/datasources/test_local/Event/events_generator.dart';

import '../../../../domain/models/evento.dart';
import '../../../../domain/repositories/events_repository.dart';

class EventsdbFake extends EventsRepository {
  @override
  Future<List<Evento>> getEvents() async {
    List<Evento> response = EventsGenerator(number_events: 3).createEvents();
    return response;
  }
}