import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'utils/linearSearch.dart';
import 'utils/curvedSearch.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _curvedOccurrences = 0;
  int _linearOccurrences = 0;

  Future<void> _runCurvedSearch() async {
    final data = await rootBundle.loadString('assets/input.txt');
    final occurrences = runCurvedSearchFromString(data);
    setState(() {
      _curvedOccurrences = occurrences;
    });
  }

  Future<void> _runLinearSearch() async {
    final data = await rootBundle.loadString('assets/example.txt');
    final occurrences = runLinearSearchFromString(data);
    setState(() {
      _linearOccurrences = occurrences;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Click the button to run the search'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _runCurvedSearch,
              child: Text(
                'Run Curved Search (Occurrences: $_curvedOccurrences)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _runLinearSearch,
              child: Text(
                'Run Linear Search (Occurrences: $_linearOccurrences)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
