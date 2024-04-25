import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class BudgetsRow extends StatelessWidget {
  final Map bObj;
  final VoidCallback onPressed;

  const BudgetsRow({super.key, required this.bObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    var proVal = (double.tryParse(bObj["left_amount"]) ?? 0) / (double.tryParse(bObj["total_budget"]) ?? 0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Container(
            
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: TColor.border.withOpacity(0.05),
              ),
              color: Color.fromARGB(255, 223, 223, 236),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        bObj["icon"],
                        width: 30,
                        height: 30,
                        color: Color.fromRGBO(23, 23, 24, 1),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bObj["name"],
                            style: TextStyle(
                                color: TColor.gray80,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "\$${bObj["left_amount"]} left to spend",
                            style: TextStyle(
                                  color: TColor.gray60,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${bObj["spend_amount"]}",
                            style: TextStyle(
                            color: TColor.gray40,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "of \$${bObj["total_budget"]}",
                            style: TextStyle(
                                color: TColor.gray40,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ],
                ),
      
                const SizedBox(height: 8,),
                LinearProgressIndicator(
                  backgroundColor: TColor.gray60,
                  valueColor: AlwaysStoppedAnimation(bObj["color"]),
                  minHeight: 3,
                  value: proVal ,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
