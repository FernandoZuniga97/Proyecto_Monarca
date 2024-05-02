import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:godzilla/widget/budgets_row.dart';
import 'package:godzilla/widget/custom_arc_180_painter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../settings/settings_view.dart';
import 'package:godzilla/view/card/new_users_page.dart';

class SpendingBudgetsView extends StatefulWidget {
  const SpendingBudgetsView({Key? key}) : super(key: key);

  @override
  State<SpendingBudgetsView> createState() => _SpendingBudgetsViewState();
  
}


class _SpendingBudgetsViewState extends State<SpendingBudgetsView> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final users = firestore.collection('Adpersonal').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: ( context, snapshot) {
        var media = MediaQuery.of(context);
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(title:  Text('Administración Personal', style: TextStyle(fontWeight: FontWeight.bold, color: TColor.gray20),), backgroundColor:const Color.fromRGBO(63, 62, 76, 1),),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35, right: 10),
                    child: Row(
                      children: [
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                        Navigator.push(
                            context,
                              MaterialPageRoute(
                                      builder: (context) => const SettingsView()));
                            },
                            icon: Image.asset("assets/img/settings.png",
                                width: 25, height: 25, color: TColor.gray30
                                ))
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        width: media.size.width * 0.5,
                        height: media.size.width * 0.30,
                        child: CustomPaint(
                        painter: CustomArc180Painter(
                          drwArcs: [
                              ArcValueModel(color: Colors.blueAccent, value: 20),
                              ArcValueModel(color: Colors.purpleAccent, value: 45),
                              ArcValueModel(color: Colors.redAccent, value: 75),
                              ArcValueModel(color: Colors.green, value: 40),
                            ],
                            end: 50,
                            width: 12,
                            bgWidth: 8,
                          ),
                        ),
                      ),
                      const Column(
                        children: [
                          Text(
                            "Salario",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Mensual",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  NewUserPage()),
                              (route) => false);},
                      child: Container(
                        height: 64,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                          color: TColor.secondary
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: TColor.secondary
                        ),
                        alignment: Alignment.center,
                        child: const  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Agregar gasto",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: users,
                    builder: (context, snapshot) {
                  if (snapshot.hasData) {
              final listaAdpersonal = snapshot.data!.docs;
              return SingleChildScrollView(
                child: ListView.builder(
                  padding: 
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listaAdpersonal.length,
                  itemBuilder: (context, index) {
                    var user = listaAdpersonal[index].data() as Map? ?? {};  
                    return BudgetsRow(
                      
                            bObj: user,
                            onPressed: () {},
                          colorSeed: index,
                    );
                  },
                ),
              );
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}