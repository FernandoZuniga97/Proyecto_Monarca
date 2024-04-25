import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:godzilla/widget/budgets_row.dart';
import 'package:godzilla/widget/custom_arc_180_painter.dart';

import '../settings/settings_view.dart';

class SpendingBudgetsView extends StatefulWidget {
  const SpendingBudgetsView({super.key});

  @override
  State<SpendingBudgetsView> createState() => _SpendingBudgetsViewState();
}

class _SpendingBudgetsViewState extends State<SpendingBudgetsView> {
  List budgetArr = [
    {
      "name": "Auto & Transport",
      "icon": "assets/img/auto_&_transport.png",
      "spend_amount": "25.99",
      "total_budget": "400",
      "left_amount": "250.01",
      "color": TColor.secondaryG
    },
    {
      "name": "Entertainment",
      "icon": "assets/img/entertainment.png",
      "spend_amount": "50.99",
      "total_budget": "600",
      "left_amount": "300.01",
      "color": TColor.secondary50
    },
    {
      "name": "Security",
      "icon": "assets/img/security.png",
      "spend_amount": "5.99",
      "total_budget": "600",
      "left_amount": "250.01",
      "color": TColor.primary10
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
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
                            width: 25, height: 25, color: TColor.gray30))
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    width: media.width * 0.5,
                    height: media.width * 0.30,
                    child: CustomPaint(
                      painter: CustomArc180Painter(
                        drwArcs: [
                          ArcValueModel(color: TColor.secondaryG, value: 20),
                          ArcValueModel(color: TColor.secondary, value: 45),
                          ArcValueModel(color: TColor.primary10, value: 70),
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
                        "4,500 LPS",
                        style: TextStyle(
                            
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "de 10,0000 LPS",
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
                  onTap: () {},
                  child: Container(
                    height: 64,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(63, 62, 76, 1)
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Estadistica de tu inversión",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: budgetArr.length,
                  itemBuilder: (context, index) {
                    var bObj = budgetArr[index] as Map? ?? {};
      
                    return BudgetsRow(
                      bObj: bObj,
                      onPressed: () {},
                    );
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: DottedBorder(
                    dashPattern: const [5, 4],
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(16),
                    color: const Color.fromRGBO(63, 62, 76, 1),
                    child: Container(
                      height: 64,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add new category ",
                            style: TextStyle(
                                color: TColor.gray70,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Image.asset(
                            "assets/img/add.png",
                            width: 12,
                            height: 12,
                            color: Color.fromRGBO(63, 62, 76, 1)
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 110,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
