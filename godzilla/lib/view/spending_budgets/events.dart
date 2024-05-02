import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:intl/intl.dart';

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
                padding: const EdgeInsets.only(top: 20),
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
                          height: 198,
                          width: 350,
                          
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
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showEditEventDialog(context, data,
                                        document.reference);
                                  },
                                      ),
                                    PopupMenuButton(
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
                                  ],
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
 Future<void> showEditEventDialog(BuildContext context, Map<String, dynamic> data, DocumentReference reference) async {
  final _formKey = GlobalKey<FormState>();
  final _nombreEventoController = TextEditingController(text: data['nombreEvento']);
  final _fechaEventoController = TextEditingController(text: data['fechaEvento'] != null ? DateFormat('dd/MM/yyyy').format(data['fechaEvento'].toDate()) : '');
  final _tipoEventoController = TextEditingController(text: data['tipoEvento']);
  final _ubicacionController = TextEditingController(text: data['ubicacion']);
  final _lugarEventoController = TextEditingController(text: data['lugarEvento']);
  final _presupuestoController = TextEditingController(text: data['presupuesto']?.toString() ?? '');
  final _listaInvitadosController = TextEditingController(text: (data['listaInvitados'] ?? false).toString());
  final _numInvitadosController = TextEditingController(text: data['numInvitados']?.toString() ?? '');
  final _nombresInvitadosController = TextEditingController(text: data['nombresInvitados']?.join(', ') ?? '');

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
                  color:const Color.fromRGBO(63, 62, 76, 80),
                    borderRadius: BorderRadius.circular(16),
        ),
        child: AlertDialog(
          //backgroundColor: Color.fromARGB(255, 253, 207, 170),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color:const Color.fromRGBO(63, 62, 76, 80), width: 7)),
          title: const Center(child: const Text('Editar Evento')),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nombreEventoController,
                    decoration: const InputDecoration(labelText: 'Nombre del evento'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre para el evento';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _fechaEventoController,
                    decoration: const InputDecoration(labelText: 'Fecha del evento'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una fecha para el evento';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _tipoEventoController,
                    decoration: const InputDecoration(labelText: 'Tipo de evento'),
                  ),
                  TextFormField(
                    controller: _ubicacionController,
                    decoration: const InputDecoration(labelText: 'Ubicación'),
                  ),
                  TextFormField(
                    controller: _lugarEventoController,
                    decoration: const InputDecoration(labelText: 'Lugar del evento'),
                  ),
                  TextFormField(
                    controller: _presupuestoController,
                    decoration: const InputDecoration(labelText: 'Presupuesto'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _listaInvitadosController,
                    decoration: const InputDecoration(labelText: '¿Tiene lista de invitados?'),
                  ),
                  if (_listaInvitadosController.text.toLowerCase() == 'true')
                    TextFormField(
                      controller: _numInvitadosController,
                      decoration: const InputDecoration(labelText: 'Número de invitados'),
                      keyboardType: TextInputType.number,
                    ),
                  if (_listaInvitadosController.text.toLowerCase() == 'true')
                    TextFormField(
                      controller: _nombresInvitadosController,
                      decoration: const InputDecoration(labelText: 'Nombres de invitados'),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            
            TextButton(
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(TColor.secondary), // Cambia Colors.blue por el color que desees
  ),
              onPressed: () {
              
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  reference.update({
                    'nombreEvento': _nombreEventoController.text,
                    'fechaEvento': DateFormat('dd/MM/yyyy').parse(_fechaEventoController.text),
                    'tipoEvento': _tipoEventoController.text,
                    'ubicacion': _ubicacionController.text,
                    'lugarEvento': _lugarEventoController.text,
                    'presupuesto': _presupuestoController.text.isNotEmpty ? int.parse(_presupuestoController.text) : null,
                    'listaInvitados': _listaInvitadosController.text.toLowerCase() == 'true',
                    'numInvitados': _numInvitadosController.text.isNotEmpty ? int.parse(_numInvitadosController.text) : null,
                    'nombresInvitados': _nombresInvitadosController.text.split(', '),
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(TColor.secondary),),
              child: const Text('Guardar' ,
              style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      );
    },
  );
}
