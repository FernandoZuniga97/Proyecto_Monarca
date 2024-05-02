import 'package:flutter/material.dart';

class EventRow extends StatelessWidget {
  final Map<String, dynamic> eventData;

  const EventRow({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                color:const Color.fromRGBO(63, 62, 76, 1),
              ),
              color:const Color.fromRGBO(63, 62, 76, 1),
                borderRadius: BorderRadius.circular(16),
          ),
        child: Card(
          child: ListTile(
            title: Text(eventData['nombreEvento'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fecha: ${eventData['fechaEvento'] != null ? eventData['fechaEvento'].toDate().toString() : ''}'),
                Text('Tipo de evento: ${eventData['tipoEvento'] ?? ''}'),
                Text('Ubicación: ${eventData['ubicacion'] ?? ''}'),
                Text('Lugar del evento: ${eventData['lugarEvento'] ?? ''}'),
                Text('Presupuesto: ${eventData['presupuesto'] != null ? eventData['presupuesto'].toString() : ''}'),
                Text('Lista de invitados: ${eventData['listaInvitados'] ?? ''}'),
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }
}
