import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:godzilla/view/calender/screens/edit_event.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/event.dart';
import '../widgets/event_item.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}   

class _MyHomePageState extends State<MyHomePage> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    final snap = await FirebaseFirestore.instance
        .collection('Eventos')
        .where('fechaEvento', isGreaterThanOrEqualTo: firstDay)
        .where('fechaEvento', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: Event.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.fechaEvento.year, event.fechaEvento.month, event.fechaEvento.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
    setState(() {});
  }
  
  List<Event> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title:  Text('Calendario', style: TextStyle(fontWeight: FontWeight.bold, color: TColor.gray20),), backgroundColor:const Color.fromRGBO(63, 62, 76, 1),),
        body: ListView(
          children: [
            TableCalendar(                    
              eventLoader: _getEventsForTheDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              focusedDay: _focusedDay,
              firstDay: _firstDay,
              lastDay: _lastDay,
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
                _loadFirestoreEvents();
              },
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                print(_events[selectedDay]);
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle:  CalendarStyle(
                markerDecoration: const ShapeDecoration(color: Colors.cyan, shape: CircleBorder()),
                markersMaxCount: 1,
                weekendTextStyle: TextStyle(
                  color: TColor.secondary,
                ),
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: TColor.secondary,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                headerTitleBuilder: (context, day) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(day.toString()),
                  );
                },
              ),
            ),
            ..._getEventsForTheDay(_selectedDay).map(
              (event) => EventItem(
                  event: event,
                  onTap: () async {
                    final res = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditEvent(
                            firstDate: _firstDay,
                            lastDate: _lastDay,
                            event: event),
                      ),
                    );
                    if (res ?? false) {
                      _loadFirestoreEvents();
                    }
                  },
                  ),
            ),
          ],
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
            color: const Color.fromRGBO(63, 62, 76, 80),
            borderRadius: BorderRadius.circular(16),
          ),
          child: AlertDialog(
            //backgroundColor: Color.fromARGB(255, 253, 207, 170),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: const Color.fromRGBO(63, 62, 76, 80), width: 7),
            ),
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
                          return 'Ingrese un nombre para el evento';
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
  
