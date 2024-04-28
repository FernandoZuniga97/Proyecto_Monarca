import 'package:flutter/material.dart';

class InvitadosForm extends StatefulWidget {
  const InvitadosForm({
    super.key,
    required this.listaInvitados,
    required this.numInvitados,
    required this.onNumInvitadosChanged,
    required this.onNombresInvitadosChanged,
  });

  final bool listaInvitados;
  final int numInvitados;
  final ValueChanged<int> onNumInvitadosChanged;
  final ValueChanged<List<String>> onNombresInvitadosChanged;

  @override
  State<InvitadosForm> createState() => _InvitadosFormState();
}

class _InvitadosFormState extends State<InvitadosForm> {
  late List<String> _nombresInvitados;

  @override
  void initState() {
    super.initState();
    _nombresInvitados = List.generate(widget.numInvitados, (index) => '');
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.listaInvitados,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Número de invitados',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: widget.numInvitados.toString(),
                    onChanged: (value) {
                      widget.onNumInvitadosChanged(int.tryParse(value) ?? 0);
                      _nombresInvitados = List.generate(int.tryParse(value) ?? 0, (index) => '');
                      widget.onNombresInvitadosChanged(_nombresInvitados);
                    },
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nombres de invitados',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    children: List.generate(widget.numInvitados, (index) {
                      return TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _nombresInvitados[index],
                        onChanged: (value) {
                          setState(() {
                            _nombresInvitados[index] = value;
                          });
                          widget.onNombresInvitadosChanged(_nombresInvitados);
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}