// event_form.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'form_field.dart';

class EventForm extends StatefulWidget {
  const EventForm({
    super.key,
    required this.formKey,
    required this.onNombreEventoSaved,
    required this.onFechaEventoSaved,
    required this.onTipoEventoSaved,
    required this.onUbicacionSaved,
    required this.fechaEvento,
    required this.onPresupuestoSaved,
    required this.onLugarSaved,
  });

  final GlobalKey<FormState> formKey;
  final ValueSetter<String?> onNombreEventoSaved;
  final ValueSetter<DateTime?> onFechaEventoSaved;
  final ValueSetter<String?> onTipoEventoSaved;
  final ValueSetter<String?> onUbicacionSaved;
  final ValueSetter<String?> onPresupuestoSaved;
  final ValueSetter<String?> onLugarSaved;
  final DateTime? fechaEvento;

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  DateTime? _fechaEvento;
  final TextEditingController _fechaEventoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fechaEvento = widget.fechaEvento;
    _fechaEventoController.text = _fechaEvento != null
        ? DateFormat('yyyy-MM-dd').format(_fechaEvento!)
        : '';
  }

  @override
  void dispose() {
    _fechaEventoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomFormField(
            labelText: 'Nombre del evento',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre';
              }
              return null;
            },
            onSaved: widget.onNombreEventoSaved,
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Fecha del evento',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
            ),
            readOnly: true,
            controller: _fechaEventoController,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _fechaEvento ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() {
                  _fechaEvento = picked;
                  _fechaEventoController.text =
                      DateFormat('yyyy-MM-dd').format(_fechaEvento!);
                });
                widget.onFechaEventoSaved(_fechaEvento);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor seleccione una fecha';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CustomFormField(
            labelText: 'Tipo de evento',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un tipo de evento';
              }
              return null;
            },
            onSaved: widget.onTipoEventoSaved,
          ),
          const SizedBox(height: 24),
          CustomFormField(
            labelText: 'Ubicación',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una ubicación';
              }
              return null;
            },
            onSaved: widget.onUbicacionSaved,
          ),
          const SizedBox(height: 24),
          CustomFormField(
            labelText: 'Presupuesto',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un presupuesto';
              }
              return null;
            },
            onSaved: widget.onPresupuestoSaved,
          ),
          const SizedBox(height: 24),
          CustomFormField(
            labelText: 'Lugar del evento',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el lugar del evento';
              }
              return null;
            },
            onSaved: widget.onLugarSaved,
          ),
        ],
      ),
    );
  }
}