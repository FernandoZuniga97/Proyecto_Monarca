import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({super.key});


  @override
  State<Start> createState() => _Start();
}

class _Start extends State<Start> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Screen'),
      ),
      body: const Center(
        child: Text('Start Screen'),
      ),
    );
}

}
