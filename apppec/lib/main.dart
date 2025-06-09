import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Panimalar App',
      home: HomeScreen(),
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          color: const Color.fromARGB(255, 1, 39, 70),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Image.network(
                    'https://panimalar.ac.in/assets/images/inner-logo.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: PopupMenuButton<int>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 1,
                        child: Text("About Us"),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text("Help"),
                      ),
                    ],
                    onSelected: (value) {
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const SizedBox(height: 150, child: EventsCarousel()), 
          Expanded(child: screens[myIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
           BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Events",
            backgroundColor: Color.fromARGB(255, 0, 61, 111),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Schedule",
            backgroundColor:  Color.fromARGB(255, 222, 198, 11),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "CGPA Calculator",
            backgroundColor: Color.fromARGB(255, 0, 61, 111),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Course",
            backgroundColor:  Color.fromARGB(255, 222, 198, 11),
          ),
        ],
      ),
    );
  }
}

class EventsCarousel extends StatefulWidget {
  const EventsCarousel({super.key});
  State<EventsCarousel> createState() => _EventsCarouselState();
}

class _EventsCarouselState extends State<EventsCarousel> {
  late PageController _pageController;
  double _currentPage = 0;
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5, initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: logoUrls.length,
      itemBuilder: (context, index) {
        double scale = 1 - (_currentPage - index).abs() * 0.3;
        scale = scale.clamp(0.7, 1.0);

        return Transform.scale(
          scale: scale,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              child: Image.network(
                logoUrls[index],
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
  Widget build(BuildContext context) {
    return const Center(child: Text("Events Screen"));
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Schedule page"));
  }
}

class CGPACalculatorScreen extends StatelessWidget {
  const CGPACalculatorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("CGPA Calculator page"));
  }
}

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Course page"));
  }
}

final List<String> logoUrls = [
  "https://panimalar.ac.in/assets/images/univ-logos/logo-1.png",
  "https://panimalar.ac.in/assets/images/univ-logos/logo-2.png",
  "https://panimalar.ac.in/assets/images/univ-logos/logo-3.png",
  "https://panimalar.ac.in/assets/images/univ-logos/logo-4.png",
  "https://panimalar.ac.in/assets/images/univ-logos/logo-5.png",
  "https://panimalar.ac.in/assets/images/univ-logos/logo-6.png",
  "https://panimalar.ac.in/assets/images/univ-logos/logo-7.png",
];
