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
    return SingleChildScrollView(
      child: Visibility(
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
                  ),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13.0)),
                        ),
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
                    '      Nombres de invitados',
                  ),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: List.generate(widget.numInvitados, (index) {
                        return SizedBox(
                          height: 75,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Nombre del invitado',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(13.0)),
                              ),
                            ),
                            initialValue: _nombresInvitados[index],
                            onChanged: (value) {
                              setState(() {
                                _nombresInvitados[index] = value;
                              });
                              widget.onNombresInvitadosChanged(_nombresInvitados);
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}