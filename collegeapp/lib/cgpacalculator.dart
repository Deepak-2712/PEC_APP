import 'package:flutter/material.dart';

class CGPACalculatorScreen extends StatefulWidget {
  const CGPACalculatorScreen({super.key});

  @override
  State<CGPACalculatorScreen> createState() => _CGPACalculatorScreenState();
}

class _CGPACalculatorScreenState extends State<CGPACalculatorScreen> {
  List<TextEditingController> gpaControllers = [TextEditingController()]; 

  double? cgpa;

  void calculateCGPA() {
    double total = 0;
    int count = 0;

    for (var controller in gpaControllers) {
      final text = controller.text.trim();
      if (text.isNotEmpty) {
        final gpa = double.tryParse(text);
        if (gpa != null && gpa >= 0 && gpa <= 10) {
          total += gpa;
          count++;
        }
      }
    }

    setState(() {
      cgpa = (count > 0) ? total / count : null;
    });
  }

  void resetAll() {
    setState(() {
      for (var controller in gpaControllers) {
        controller.dispose();
      }
      gpaControllers = [TextEditingController()]; 
      cgpa = null;
    });
  }

  void addSemesterField() {
    setState(() {
      gpaControllers.add(TextEditingController());
    });
  }

  void removeSemesterField(int index) {
    setState(() {
      gpaControllers[index].dispose();
      gpaControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    for (var controller in gpaControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF0FF),
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 1, 39, 70),
        title: const Text('CGPA Calculator', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: gpaControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: gpaControllers[index],
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'Semester ${index + 1} GPA',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        if (gpaControllers.length > 1)
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () => removeSemesterField(index),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (cgpa != null)
              Text(
                'Your CGPA is: ${cgpa!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: addSemesterField,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Semester"),
                ),
                ElevatedButton.icon(
                  onPressed: calculateCGPA,
                  icon: const Icon(Icons.calculate),
                  label: const Text("Calculate"),
                ),
                ElevatedButton.icon(
                  onPressed: resetAll,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
