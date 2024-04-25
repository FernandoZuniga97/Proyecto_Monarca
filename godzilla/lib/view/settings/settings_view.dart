import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/common/toast.dart';
import 'package:godzilla/loginandsign/login.dart';
import '../../common/color_extension.dart';
import '../../widget/icon_item_row.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    //var media = MediaQuery.sizeOf(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset("assets/img/back.png",
                              width: 25, height: 25, color: TColor.gray30))
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Configuración",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/u1.png",
                    width: 70,
                    height: 70,
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Proyecto Monarca",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ejemplo.com",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:const Color.fromARGB(255, 0, 0, 0),
                    ),
                    color:const Color.fromRGBO(63, 62, 76, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                              (route) => false);
                    showToast(message: "Se ha cerrado la sesión");
                  },
                  child: Container(
                    height: 45,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Cerrar sesión",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:  EdgeInsets.only(top: 15, bottom: 8),
                      child: Text(
                        " General",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:const Color.fromARGB(255, 0, 0, 0),
                        ),
                        color:const Color.fromRGBO(63, 62, 76, 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const IconItemRow(
                            title: "Seguridad",
                            icon: "assets/img/face_id.png",
                            value: "Huella Digital",
                          ),
                          IconItemSwitchRow(
                            title: "Servicio en la nube",
                            icon: "assets/img/icloud.png",
                            value: isActive,
                            didChange: (newVal) {
                              setState(() {
                                isActive = newVal;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
      
                    const Padding(
                      padding:  EdgeInsets.only(top: 20, bottom: 8),
                      child: Text(
                        " Mis eventos",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:const Color.fromARGB(255, 0, 0, 0),
                        ),
                        color:const Color.fromRGBO(63, 62, 76, 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          IconItemRow(
                            title: "Ordeno",
                            icon: "assets/img/sorting.png",
                            value: "Fecha",
                          ),
      
                          IconItemRow(
                            title: "Resumen",
                            icon: "assets/img/chart.png",
                            value: "Promedio",
                          ),
      
                          IconItemRow(
                            title: "Moneda predeterminada",
                            icon: "assets/img/money.png",
                            value: "LPS",
                          ),
                          
                        ],
                      ),
                    ),
      
                    const Padding(
                      padding:  EdgeInsets.only(top: 20, bottom: 8),
                      child: Text(
                        " Apariencia",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:const Color.fromARGB(255, 0, 0, 0),
                        ),
                        color:const Color.fromRGBO(63, 62, 76, 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          IconItemRow(
                            title: "Icono de la app",
                            icon: "assets/img/app_icon.png",
                            value: "Por defecto",
                          ),
                          IconItemRow(
                            title: "Tema",
                            icon: "assets/img/light_theme.png",
                            value: "Dark",
                          ),
                          IconItemRow(
                            title: "Fuente",
                            icon: "assets/img/font.png",
                            value: "Roboto",
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
