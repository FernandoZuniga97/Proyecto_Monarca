import 'package:flutter/material.dart';
import '../common/color_extension.dart';
import 'dart:math';
class BudgetsRow extends StatelessWidget {
  final Map bObj;
 
  final VoidCallback onPressed;
  final Color color;

  BudgetsRow({super.key, required this.bObj, required this.onPressed,
  required int colorSeed }): color = _generateRandomColor(colorSeed);
  static Color _generateRandomColor(int seed) {
    final random = Random(seed);
    return Color.fromRGBO(
      random.nextInt(256), // Rojo
      random.nextInt(256), // Verde
      random.nextInt(256), // Azul
      1, // Opacidad
    );
  }
  @override
  Widget build(BuildContext context) {
  var proVal = (bObj["Monto"] as int?)?.toDouble() ?? 0.0;
    return SingleChildScrollView(
      child: MaterialApp(
        color: color,
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
                  color:const Color.fromRGBO(63, 62, 76, 1),
                ),
                color:const Color.fromRGBO(63, 62, 76, 1),
              //color:Color.fromARGB(255, 248, 229, 216),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bObj["Nombre"],
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                  decorationThickness: 0,
                                  color: TColor.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${bObj["Descripcion"]}",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                  decorationThickness: 0,
                                    color: TColor.white,
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
                              "${bObj["Monto"]} Lps",
                              style: TextStyle(
                              color: TColor.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 0,
                                  ),
                                  
                            ),
                            
                          ]),
                          
                    ],
                  ),
                
                  const SizedBox(height: 8,), 
                  LinearProgressIndicator(
                    backgroundColor: TColor.gray60,
                    valueColor: AlwaysStoppedAnimation(color),
                    minHeight: 3,
                    value: proVal ,
                    
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
