import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:godzilla/view/card/cards_view.dart';
import 'package:godzilla/view/main_tab/main_tab_view.dart';
import 'package:flutter/widgets.dart';
import 'package:godzilla/widget/form_container_widget.dart';
class NewUserPage extends StatelessWidget {
  NewUserPage({super.key});

  final nombreController = TextEditingController();
  final desController = TextEditingController();
  final efectivoController = TextEditingController();
  final instance = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String?;
    if (args != null) {
      instance.collection('bandas').doc(args).get().then((value) {
        nombreController.text = value['Nombre'];
        desController.text = value['Descripcion'];
        efectivoController.text = value['Monto'].toString();
      });
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if(details.velocity.pixelsPerSecond.dx <0){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const SpendingBudgetsView()));
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        home: PopScope(
          child: Scaffold(
            appBar: AppBar(title:  Text('Monarca - Gasto Mensual', style: TextStyle(fontWeight: FontWeight.bold, color: TColor.gray20),), backgroundColor:const Color.fromRGBO(63, 62, 76, 1),
            leading: IconButton(
              icon:  Icon(Icons.arrow_back_ios, color: TColor.gray20),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const MainTabView()));
              },
            )
            ,
            ),
            body: Center(
              
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                    "Gasto Mensual",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                      FormContainerWidget(
                        keyboardType: TextInputType.text,
                        controller: nombreController,
                        hintText: "Nombre del gasto",
                      ),
                      const SizedBox(height: 16.0),
                      FormContainerWidget(
                      keyboardType: TextInputType.text,
                        controller: desController,
                        hintText: "Descripcion",
                      ),
                      const SizedBox(height: 16.0),
                      FormContainerWidget(
                        controller: efectivoController,
                        keyboardType: TextInputType.number,
                        hintText: "Monto",
                      ),
                      const SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () async {
                          final data = {     
                            'Nombre': nombreController.text,
                            'Descripcion': desController.text,
                            'Monto': int.parse(efectivoController.text),
                              
                          };
                            final respuesta =  await instance.collection('Adpersonal').add(data);
                          print(respuesta);
                          //Navigator.pushAndRemoveUntil(
                            //    context,
                              //  MaterialPageRoute(
                                //    builder: (context) => const MainTabView()),
                                //(route) => false);
                              Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainTabView()),
                              (route) => false);
                        },
                        child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 121, 102, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Guardar',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )
                      ),
                        
                      ),
                    ),
                      ),        
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

      



}
