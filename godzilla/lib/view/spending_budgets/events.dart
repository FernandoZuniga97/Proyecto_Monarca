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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title:  Text('Eventos Registrados', style: TextStyle(fontWeight: FontWeight.bold, color: TColor.gray20),), backgroundColor:const Color.fromRGBO(63, 62, 76, 1),),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Eventos').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Algo salió mal');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 0),
              
              child: ListView (
                
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Column(
                    children: [
                      Dismissible(
                        key: Key(document.id),
                        onDismissed: (direction) {
                          document.reference.delete();
                        },
                        
                        child: SizedBox(
                          height: 170,
                          width: 340,
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            
                            decoration: BoxDecoration(        
                                    border: Border.all(
                                        color:const Color.fromRGBO(63, 62, 76, 1),
                                      ),
                                      color:const Color.fromRGBO(63, 62, 76, 1),
                                        borderRadius: BorderRadius.circular(16),
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
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
