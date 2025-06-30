import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cgpacalculator.dart';
import 'splash.dart';
import 'courses_screen.dart';

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
      home: SplashScreen(),
      routes: {
        '/main': (context) => const HomeScreen(),
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
    const CoursesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isCGPACalc = myIndex == 2;  
  final bool isCoursesTab = myIndex == 3;
  final bool showHeader = !(isCGPACalc || isCoursesTab);
    return Scaffold(
      appBar: showHeader
          ? PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Container(
                color: const Color.fromARGB(255, 1, 39, 70),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'images/inner-logo.png',
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton<int>(
                        icon: const Icon(Icons.menu, color: Colors.white, size: 40),
                        padding: const EdgeInsets.only(top: 20, right: 20),
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 1, child: Text("About Us")),
                          PopupMenuItem(value: 2, child: Text("Help")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            : null,
      body: (isCGPACalc || isCoursesTab)
          ? screens[myIndex]
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: const SizedBox(height: 10),
                ),
                SliverToBoxAdapter(
                  child: const SizedBox(height: 150, child: EventsCarousel()),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: screens[myIndex],
                  ),
                ),
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
            label: "Home",
            backgroundColor: Color.fromARGB(255, 1, 39, 70),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Schedule",
            backgroundColor: Color.fromARGB(255, 244, 202, 17),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "CGPA Calculator",
            backgroundColor: Color.fromARGB(255, 1, 39, 70),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Courses",
            backgroundColor: Color.fromARGB(255, 244, 202, 17),
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

  final List<Map<String, String>> links = const [
    {
      "title": "Placements",
      "url": "https://panimalar.ac.in/placement.php",
      "image": "images/image-placement.png"
    },
    {
      "title": "Infrastructure",
      "url": "https://panimalar.ac.in/infrastructures.php",
      "image": "images/image-infra.png"
    },
    {
      "title": "Hostel",
      "url": "https://panimalar.ac.in/hostel.php",
      "image": "images/image-hostel.png"
    },
    {
      "title": "Library",
      "url": "https://panimalar.ac.in/library.php",
      "image": "images/image-lib.png"
    },
    {
      "title": "Transport",
      "url": "https://panimalar.ac.in/transport.php",
      "image": "images/image-bus.png"
    },
    {
      "title": "Mess",
      "url": "https://panimalar.ac.in/mess.php",
      "image": "images/image-mess.png"
    },
     {
      "title": "Sports",
      "url": "https://panimalar.ac.in/sports.php",
      "image": "images/image-sports.png"
    },
    {
      "title": "Youtube",
      "url": "https://www.youtube.com/@panimalargroupofinstitutio6593/videos",
      "image": "images/image-youtube.png"
    },
  ];

  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Cannot open';
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: links.map((item) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 30),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: Image.asset(
                        item["image"]!,
                        height: 130,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(

                  height: 4,
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(horizontal: 0),
                ),
                ListTile(
                  title: Text(item["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.open_in_new, color: Colors.blue),
                  onTap: () => _launchUrl(context, item["url"]!),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
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
