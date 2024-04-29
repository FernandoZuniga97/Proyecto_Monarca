import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/view/add_subscription/event_form.dart';
import 'package:godzilla/view/add_subscription/invitados_form.dart';

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const AddEvent(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      this.selectedDate})
      : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDate;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _nombreEvento;
  DateTime? _fechaEvento;
  bool _listaInvitados = false;
  String? _lugarEvento;
  String? _presupuesto;
  String? _tipoEvento;
  String? _ubicacion;
  int _numInvitados = 0;
  List<String> _nombresInvitados = [];
  
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text("Add Event")),
        
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            InputDatePickerFormField(
              firstDate: widget.firstDate,
              lastDate: widget.lastDate,
              initialDate: _selectedDate,
              onDateSubmitted: (date) {
                print(date);
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
            EventForm(
              
                  formKey: _formKey,
                  onNombreEventoSaved: (value) {
                    _nombreEvento = value;
                  },
                  onFechaEventoSaved: (value) {
                    _fechaEvento = value;
                  },
                  onTipoEventoSaved: (value) {
                    _tipoEvento = value;
                  },
                  onUbicacionSaved: (value) {
                    _ubicacion = value;
                  },
                  onPresupuestoSaved: (value) {
                    _presupuesto = value;
                  },
                  onLugarSaved: (value) {
                    _lugarEvento = value;
                  },
                  fechaEvento: _fechaEvento,
                ),
      
            const SizedBox(height: 16.0),
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Lista de invitados',
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(width: 16),
                        Switch(
                          value: _listaInvitados,
                          onChanged: (value) {
                            setState(() {
                              _listaInvitados = value;
                              if (!value) {
                                _numInvitados = 0;
                                _nombresInvitados.clear();
                              }
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                InvitadosForm(
                  listaInvitados: _listaInvitados,
                  numInvitados: _numInvitados,
                  onNumInvitadosChanged: (int value) {
                    setState(() {
                      _numInvitados = value;
                    });
                  },
                  onNombresInvitadosChanged: (List<String> value) {
                    setState(() {
                      _nombresInvitados = value;
                    });
                  },
                ),
              const SizedBox(height: 48),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                  
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _guardarEvento();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  

  Future<void> _guardarEvento() async {
    final firestore = FirebaseFirestore.instance;
    try {
      print('Guardando evento: $_nombreEvento');
      await firestore.collection('Eventos').add({
        'nombreEvento': _nombreEvento,
        'fechaEvento': _fechaEvento,
        'listaInvitados': _listaInvitados,
        'lugarEvento': _lugarEvento,
        'presupuesto': _presupuesto,
        'tipoEvento': _tipoEvento,
        'ubicacion': _ubicacion,
        'numInvitados': _numInvitados,
        'nombresInvitados': _nombresInvitados,
      });
      print('Evento guardado correctamente');

      Navigator.pushNamed(context, '/eventos').then((_) {
        setState(() {});
      });
    } catch (e) {
      print('Error al guardar el evento: $e');
    }
  }

}