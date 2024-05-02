import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:godzilla/view/card/new_users_page.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    final users = firestore.collection('bandas').snapshots();

    return Scaffold(
      
      appBar: AppBar(title:  Text('Administración personal', style: TextStyle(fontWeight: FontWeight.bold, color: TColor.gray20),), backgroundColor:const Color.fromRGBO(63, 62, 76, 1),),
      body: StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listaAdpersonal = snapshot.data!.docs;

            return ListView.builder(
              itemCount: listaAdpersonal.length,
              itemBuilder: (context, index) {
                final user = listaAdpersonal[index];       
                return ListTile(
                  title: Text(user['Nombre']),
                  subtitle: Text('${user['Descripcion']}'),
                  trailing: Text('${user['Monto']}'),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_user');
        },
        tooltip: 'Agregar nueva banda',
        child: const Icon(Icons.add),
      ),
    );
  }
}
