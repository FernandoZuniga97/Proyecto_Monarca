import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MaterialApp(
    home:  MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Calendario", // Palabra centrada y en negrita
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true, // Centrar el título
        ),
        body: content(),
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        TableCalendar(
          //locale: "",
          rowHeight: 43,
          headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          focusedDay: today,
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime.utc(2100, 1, 1),
          onDaySelected: _onDaySelected,
        ),
      ],
    );
  }
}