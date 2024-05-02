import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa la librería intl

class EventRow extends StatelessWidget {
  final Map<String, dynamic> eventData;
  const EventRow({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(eventData['nombreEvento'] ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha: ${eventData['fechaEvento'] != null ? DateFormat('yyyy-MM-dd').format(eventData['fechaEvento'].toDate()) : ''}'),
            Text('Tipo de evento: ${eventData['tipoEvento'] ?? ''}'),
            Text('Ubicación: ${eventData['ubicacion'] ?? ''}'),
            Text('Lugar del evento: ${eventData['lugarEvento'] ?? ''}'),
            Text('Presupuesto: ${eventData['presupuesto'] != null ? eventData['presupuesto'].toString() : ''}'),
            Text('Lista de invitados: ${eventData['listaInvitados'] ?? ''}'),
          ],
        ),
      ),
    );
  }
}
