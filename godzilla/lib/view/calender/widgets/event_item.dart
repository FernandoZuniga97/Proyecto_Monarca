import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import 'package:intl/intl.dart';
import '../model/event.dart';

class EventItem extends StatelessWidget {
  final Event event;
  
  final Function()? onTap;
  const EventItem({
    Key? key,
    required this.event,
    
    this.onTap,
  }) : super(key: key);

  @override
  
Widget build(BuildContext context) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(event.fechaEvento);
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
    decoration: BoxDecoration(
      color:const Color.fromRGBO(63, 62, 76, 1),
      border: Border.all(color:const Color.fromARGB(255, 0, 0, 0)),
      borderRadius: BorderRadius.circular(16),
    ),
    child: ListTile(
      title:  Text(
        event.nombreEvento,
        style: TextStyle(color: TColor.white),
      ),
      subtitle: Text(
        formattedDate,
        //event.fechaEvento.toString(),
        style: TextStyle(color: TColor.white),
      ),
      onTap: onTap,
    ),
  );
}
}
