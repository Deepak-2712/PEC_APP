import 'package:flutter/material.dart';
import 'cgpacalculator.dart'; 
import 'splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panimalar App',
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
      routes: {
        '/main': (context) =>  HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;

  final List<Widget> screens = [
    const EventsScreen(),
    const ScheduleScreen(),
    const CGPACalculatorScreen(), 
    const CourseScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isCGPACalc = myIndex == 2;

    return Scaffold(
      appBar: isCGPACalc
          ? null 
          : PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Container(
                color: const Color.fromARGB(255, 1, 39, 70),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'images/inner-logo.png',
                        height: 115,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton<int>(
                        icon: const Icon(Icons.menu, color: Colors.white, size: 40),
                        padding: const EdgeInsets.only(top: 20, right: 10),
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 1, child: Text("About Us")),
                          PopupMenuItem(value: 2, child: Text("Help")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      body: Column(
        children: [
          if (!isCGPACalc) ...[
            const SizedBox(height: 10),
            const SizedBox(height: 150, child: EventsCarousel()),
          ],
          Expanded(child: screens[myIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myIndex,
        onTap: (index) => setState(() => myIndex = index),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "Events",
            backgroundColor: Color.fromARGB(255, 0, 61, 111),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Schedule",
            backgroundColor: Color.fromARGB(255, 222, 198, 11),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "CGPA Calculator",
            backgroundColor: Color.fromARGB(255, 0, 61, 111),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Course",
            backgroundColor: Color.fromARGB(255, 222, 198, 11),
          ),
        ],
      ),
    );
  }
}

class EventsCarousel extends StatefulWidget {
  const EventsCarousel({super.key});
  @override
  State<EventsCarousel> createState() => _EventsCarouselState();
}

class _EventsCarouselState extends State<EventsCarousel> {
  late PageController _pageController;
  double _currentPage = 1000.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5, initialPage: 1000);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        final int actualIndex = index % logoUrls.length;
        double scale = 1 - (_currentPage - index).abs() * 0.3;
        scale = scale.clamp(0.7, 1.0);

        return Transform.scale(
          scale: scale,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                logoUrls[actualIndex],
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Events Screen"));
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Schedule Screen"));
}

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Course Screen"));
}

final List<String> logoUrls = [
  "images/logo-1.png",
  "images/logo-2.png",
  "images/logo-3.png",
  "images/logo-4.png",
  "images/logo-5.png",
  "images/logo-6.png",
  "images/logo-7.png",
];
