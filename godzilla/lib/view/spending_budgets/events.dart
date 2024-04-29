import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Eventos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Algo salió mal');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Dismissible(
                key: Key(document.id),
                onDismissed: (direction) {
                  document.reference.delete();
                },
                background: Container(
                  color: const Color.fromARGB(255, 139, 16, 8),
                  child: const Icon(Icons.delete, color: Colors.white),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                ),
                child: Card(
                  child: ListTile(
                    title: Text(data['nombreEvento'] ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fecha: ${data['fechaEvento'] != null ? data['fechaEvento'].toDate().toString() : ''}'),
                        Text('Tipo de evento: ${data['tipoEvento'] ?? ''}'),
                        Text('Ubicación: ${data['ubicacion'] ?? ''}'),
                        Text('Lugar del evento: ${data['lugarEvento'] ?? ''}'),
                        Text('Presupuesto: ${data['presupuesto'] != null ? data['presupuesto'].toString() : ''}'),
                        Text('Lista de invitados: ${data['listaInvitados'] ?? ''}'),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'eliminar') {
                          document.reference.delete();
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem(
                            value: 'eliminar',
                            child: Text('Eliminar'),
                          ),
                        ];
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}