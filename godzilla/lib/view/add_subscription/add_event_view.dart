import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import 'event_form.dart';
import 'invitados_form.dart';

class EventosView extends StatefulWidget {
  
  const EventosView({super.key});
  

  @override
  State<EventosView> createState() => _EventosViewState();
}

class _EventosViewState extends State<EventosView> {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title:  Text('Añadir Eventos', style: TextStyle(fontWeight: FontWeight.bold, color: TColor.gray20),), backgroundColor:const Color.fromRGBO(63, 62, 76, 1),
        leading: IconButton(
              icon:  Icon(Icons.arrow_back_ios, color: TColor.gray20),
              onPressed: () {
                Navigator.defaultRouteName;
                Navigator.pop(context);
              },
            ),
            ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Formulario',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Lista de invitados',
                          
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
                          activeColor: TColor.secondary,
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
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _guardarEvento();
                      }
                    },
                  
                    child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 121, 102, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text(
                    "Guardar",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                ),
                  ),
                ),
              ],
            ),
          ),
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
