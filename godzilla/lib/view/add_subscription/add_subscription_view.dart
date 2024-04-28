import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:godzilla/widget/primary_button.dart';
import 'package:godzilla/widget/round_textfield.dart';
import '../../widget/image_button.dart';

class AddSubScriptionView extends StatefulWidget {
  const AddSubScriptionView({super.key});

  @override
  State<AddSubScriptionView> createState() => _AddSubScriptionViewState();
}

class _AddSubScriptionViewState extends State<AddSubScriptionView> {
  TextEditingController txtDescription = TextEditingController();

  String eventName = '';
  String eventType = '';
  String eventLocation = '';
  double budget = 0.0;
  String eventAddress = '';
  List<String> guests = [];
  DateTime selectedDate = DateTime.now();
  List<String> items = [];
  List<double> values = [];
  String eventDescription = '';

  double calculateTotal() {
    double total = 0.0;
    for (int i = 0; i < items.length; i++) {
      total += values[i];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Nombre del Evento'),
                  onChanged: (value) {
                    setState(() {
                      eventName = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Tipo de Evento'),
                  onChanged: (value) {
                    setState(() {
                      eventType = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Lugar del Evento'),
                  onChanged: (value) {
                    setState(() {
                      eventLocation = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Presupuesto'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    setState(() {
                      budget = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Ubicación'),
                  onChanged: (value) {
                    setState(() {
                      eventAddress = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Lista de Invitados'),
                  onChanged: (value) {
                    setState(() {
                      guests = value.split(',').map((e) => e.trim()).toList();
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate.toString()),
                    ),
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != selectedDate)
                          setState(() {
                            selectedDate = picked;
                          });
                      },
                      child: Text('Seleccionar Fecha'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Descripción del Evento'),
                  onChanged: (value) {
                    setState(() {
                      eventDescription = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                Text(
                  'Cosas para el evento:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(labelText: 'Nombre'),
                            onChanged: (value) {
                              items[index] = value;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(labelText: 'Valor'),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) {
                              values[index] = double.tryParse(value) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${calculateTotal().toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            calculateTotal() <= budget ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes guardar los datos del evento
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}