import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godzilla/common/color_extension.dart';
import '../../widget/custom_arc_painter.dart';
import '../../widget/segment_button.dart';
import '../../widget/status_button.dart';
import '../settings/settings_view.dart';
import '../subscription_info/subscription_info_view.dart';
import 'package:godzilla/view/home/event_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSubscription = true;
  List<Map<String, dynamic>> activeEvents = [];
  List<Map<String, dynamic>> upcomingEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    QuerySnapshot eventsSnapshot =
        await FirebaseFirestore.instance.collection('Eventos').get();
    List<Map<String, dynamic>> events =
        eventsSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    DateTime today = DateTime.now();
    DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);

    activeEvents = events
        .where((event) =>
            event['fechaEvento'].toDate().isAfter(today.subtract(const Duration(days: 1))) &&
            event['fechaEvento'].toDate().isBefore(tomorrow))
        .toList();

    upcomingEvents = events
        .where((event) => event['fechaEvento'].toDate().isAfter(tomorrow))
        .toList();

    setState(() {});
  }

   @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
  int activeEventsCount = activeEvents.length;
  int upcomingEventsCount = upcomingEvents.length;
  int totalEventsCount = activeEventsCount + upcomingEventsCount;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        //backgroundColor: TColor.gray,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: media.width * 1.1,
                decoration: BoxDecoration(
                    color: TColor.gray70,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                  Image.asset("assets/img/home_bg.png"),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          padding:  EdgeInsets.only(bottom: media.width * 0.05),
                          width: media.width * 0.72,
                          height: media.width * 0.72,
                          child: CustomPaint(
                            painter: CustomArcPainter(end: 270, ),
                          ),
                        ),
      
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SettingsView()));
                                  },
                                  icon: Image.asset("assets/img/settings.png",
                                      width: 25,
                                      height: 25,
                                      color: TColor.gray30
                                      ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        const Text(
                          "MONARCA",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 223, 223, 236)
                              ),
                        ),
                        SizedBox(
                          height: media.width * 0.07,
                        ),
                        const Text(
                          "5,500",
                          style: TextStyle(
                              color: Color.fromARGB(255, 223, 223, 236),
                              fontSize: 40,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: media.width * 0.077,
                        ),
                        const Text(
                          "Efectivo restante",
                          style: TextStyle(
                              color: Color.fromARGB(255, 223, 223, 236),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: media.width * 0.14,
                        ),
                        
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: StatusButton(
                                  title: "Eventos activos",
                                  value: activeEventsCount.toString(),
                                  statusColor: TColor.secondary,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: StatusButton(
                                  title: "Futuros eventos",
                                  value: upcomingEventsCount.toString(),
                                  statusColor: TColor.primary10,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: StatusButton(
                                  title: "Total de eventos",
                                  value: totalEventsCount.toString(),
                                  statusColor: TColor.secondaryG,
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                height: 50,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(63, 62, 76, 1),
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                child: Row(
                  children: [
                    Expanded(
                      child: SegmentButton(
                        title: "Eventos activos",
                        isActive: isSubscription,
                        onPressed: () {
                          setState(() {
                            isSubscription = !isSubscription;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: SegmentButton(
                        title: "Futuros eventos",
                        isActive: !isSubscription,
                        onPressed: () {
                          setState(() {
                            isSubscription = !isSubscription;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),

              if (isSubscription)
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  
                  itemCount: activeEvents.length,
                  itemBuilder: (context, index) {
                    var eventObj = activeEvents[index];
                    return EventRow(eventData: eventObj);
                  },
                ),

              if (!isSubscription)
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: upcomingEvents.length,
                  itemBuilder: (context, index) {
                    var eventObj = upcomingEvents[index];

                    return EventRow(eventData: eventObj);
                  },
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
