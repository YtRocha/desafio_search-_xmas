import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'utils/curvedSearch.dart';
import 'utils/linearSearch.dart';

void main() {
  runApp(const XmasApp());
}

class XmasApp extends StatelessWidget {
  const XmasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xmas Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          secondary: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// Enum to represent the type of search
enum SearchType { curved, linear }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedFile = 'assets/input.txt';
  SearchType _selectedType = SearchType.curved;
  int? _result;

  Future<void> _runSearch() async {
    final data = await rootBundle.loadString(_selectedFile);
    int occurrences;
    if (_selectedType == SearchType.curved) {
      occurrences = runCurvedSearchFromString(data);
    } else {
      occurrences = runLinearSearchFromString(data);
    }
    setState(() {
      _result = occurrences;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xmas Search'),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Select file to search
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ToggleButtons(
                  isSelected: [
                    _selectedFile == 'assets/input.txt',
                    _selectedFile == 'assets/example.txt',
                  ],
                  onPressed: (index) {
                    setState(() {
                      _selectedFile = index == 0
                          ? 'assets/input.txt'
                          : 'assets/example.txt';
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: Colors.white,
                  fillColor: colorScheme.primary,
                  color: colorScheme.primary,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Input'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Example'),
                    ),
                  ],
                ),
              ),
              // type of search selection
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ToggleButtons(
                  isSelected: [
                    _selectedType == SearchType.curved,
                    _selectedType == SearchType.linear,
                  ],
                  onPressed: (index) {
                    setState(() {
                      _selectedType = index == 0
                          ? SearchType.curved
                          : SearchType.linear;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: Colors.white,
                  fillColor: colorScheme.secondary,
                  color: colorScheme.secondary,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Curved Search'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Linear Search'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Result card
              Card(
                elevation: 4,
                color: colorScheme.secondary.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: colorScheme.secondary, width: 2),
                ),
                child: SizedBox(
                  width: 300,
                  height: 120,
                  child: Center(
                    child: _result == null
                        ? const Text(
                            'Click in "Run Search" to see the result',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _selectedType == SearchType.curved
                                    ? 'Curved Search'
                                    : 'Linear Search',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Arquivo: ${_selectedFile.split('/').last}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.secondary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Resultado: $_result',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _runSearch,
                icon: const Icon(Icons.search),
                label: const Text('Run Search'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
