import 'package:flutter/material.dart';

class Course {
  final String code;
  final String title;
  final String description;
  final int credits;
  final int semester;
  final String department;

  Course({
    required this.code,
    required this.title,
    required this.description,
    required this.credits,
    required this.semester,
    required this.department,
  });
}
final List<Course> kCourses = [
  Course(
    code: 'CS2101',
    title: 'Programming in C',
    description:
        'Fundamentals of structured programming in C, covering control structures, functions and pointers.',
    credits: 3,
    semester: 2,
    department: 'CSE',
  ),
  Course(
    code: 'EE1203',
    title: 'Circuit Theory',
    description:
        'Network theorems, AC/DC analysis and transient response of RLC circuits.',
    credits: 4,
    semester: 2,
    department: 'EEE',
  ),
  Course(
    code: 'IT2304',
    title: 'Database Management Systems',
    description:
        'Relational model, SQL, normalisation and transaction processing concepts.',
    credits: 3,
    semester: 4,
    department: 'IT',
  ),
   Course(
    code: '23AD1405',
    title: 'Foundation of Data Science',
    description:
        'Introduces essential data handling, visualization, and basic statistical analysis techniques.',
    credits: 3,
    semester: 4,
    department: 'CSE',
  ),
   Course(
    code: '23CS1401',
    title: 'Computer Networks',
    description:
        'Covers the fundamentals of network architecture, protocols, and communication systems.',
    credits: 2,
    semester: 4,
    department: 'CSE',
  ),
   Course(
    code: '23CS1402',
    title: 'Computational Thinking',
    description:
        'Teaches logical problem-solving using abstraction, pattern recognition, and algorithms.',
    credits: 2,
    semester: 4,
    department: 'CSE',
  ),
   Course(
    code: '23IT1401',
    title: 'Object Oriented Software Engineering',
    description:
        'Focuses on designing software using object-oriented principles and development practices.',
    credits: 3,
    semester: 4,
    department: 'IT',
  ),
   Course(
    code: '23MA1401',
    title: 'Probability and Statistical Method',
    description:
        'Provides foundational knowledge in probability theory and statistical data analysis.',
    credits: 4,
    semester: 4,
    department: 'CSE',
  ),
];

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    // simple client‑side filter
    final visible = kCourses.where((c) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return c.code.toLowerCase().contains(q) ||
          c.title.toLowerCase().contains(q) ||
          c.department.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        backgroundColor: Color.fromARGB(255, 244, 202, 17), 
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search by code, title, or dept…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor.withOpacity(0.6),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      // ── list of course cards ──────────────────────────────
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: visible.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => _CourseCard(course: visible[i]),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDetail(context, course),
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: kElevationToShadow[2],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.menu_book_outlined, size: 40),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.code,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(course.title,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('Semester ${course.semester} • ${course.credits} Cr.',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetail(BuildContext context, Course c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scroll) => SingleChildScrollView(
          controller: scroll,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.code,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(c.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text('Department: ${c.department}')),
                  Chip(label: Text('Semester ${c.semester}')),
                  Chip(label: Text('${c.credits} Credits')),
                ],
              ),
              const SizedBox(height: 24),
              Text('Description',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(c.description, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
