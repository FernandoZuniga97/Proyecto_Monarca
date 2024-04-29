
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String NombreEvento;
  final DateTime FechaEvento;
  final String TipoEvento;
  final String Ubicacion;
  final String Presupuesto;
  final String Lugar;
  Event({
    required this.NombreEvento,
    required this.FechaEvento,
    required this.TipoEvento,
    required this.Ubicacion,
    required this.Presupuesto,
    required this.Lugar,
  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      NombreEvento: data['NombreEvento'],
      FechaEvento: data['FechaEvento'].toDate(),
      TipoEvento: data['TipoEvento'],
      Ubicacion: data['Ubicacion'],
      Presupuesto: data['Presupuesto'],
      Lugar: data['Lugar'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "FechaEvento": Timestamp.fromDate(FechaEvento),
      "TipoEvento" : TipoEvento,
      "Ubicacion" : Ubicacion,
      "Presupuesto" : Presupuesto,
      "Lugar" : Lugar
    };
  }
}
