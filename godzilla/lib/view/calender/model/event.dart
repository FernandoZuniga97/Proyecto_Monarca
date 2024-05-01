
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String nombreEvento;
  final DateTime fechaEvento;
  final String tipoEvento;
  final String ubicacion;
  final String presupuesto;
  final String lugar;
  Event({
    required this.nombreEvento,
    required this.fechaEvento,
    required this.tipoEvento,
    required this.ubicacion,
    required this.presupuesto,
    required this.lugar,
  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      nombreEvento: data['nombreEvento'],
      fechaEvento: data['fechaEvento'].toDate(),
      tipoEvento: data['tipoEvento'],
      ubicacion: data['ubicacion'],
      presupuesto: data['presupuesto'],
      lugar: data['lugarEvento'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "nombreEvento": nombreEvento,
      "fechaEvento": Timestamp.fromDate(fechaEvento),
      "tipoEvento" : tipoEvento,
      "ubicacion" : ubicacion,
      "presupuesto" : presupuesto,
      "lugarEvento" : lugar
    };
  }
}
