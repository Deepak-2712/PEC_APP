import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PEC App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('PEC App')),
       // body: Center(child: Text('Hello, World!')),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
        onTap: (index){
          setState(() {
            myIndex = index;
          });

        },
         currentIndex: myIndex,
          items: const [
            
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "Events",
            backgroundColor: Color.fromARGB(255, 222, 198, 11)
            ),

            BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Schedule",
            backgroundColor: Color.fromARGB(255, 0, 61, 111)
            ),

            BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "CGPA Calculator",
            backgroundColor: Color.fromARGB(255, 222, 198, 11)
            ),

            BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Course",
             backgroundColor: Color.fromARGB(255, 0, 61, 111)
            ),

        ],),
        ),
      );
  }
}
