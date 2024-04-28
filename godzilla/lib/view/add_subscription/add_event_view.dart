import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  String _lugarEvento = '';
  int _presupuesto = 0;
  String? _tipoEvento;
  String? _ubicacion;
  int _numInvitados = 0;
  List<String> _nombresInvitados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const Text(
                'Eventos',
                style: TextStyle(
                  color: Colors.white,
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
                fechaEvento: _fechaEvento,
              ),
              const SizedBox(height: 24),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Lugar del evento',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un lugar';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lugarEvento = value!; // Asegurarse de usar value!
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Presupuesto',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un presupuesto';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _presupuesto = int.parse(value!); // Usar int.parse
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Lps.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Lista de invitados',
                        style: TextStyle(color: Colors.white),
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
