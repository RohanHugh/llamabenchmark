import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(), // Only one `home` property
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Llamabenchmark'),
      ),
      // Add a Drawer here
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[800],
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Drawer Items
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle navigation to the home screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time_filled),
              title: const Text('Benchmark'),
              onTap: () {
                // Handle navigation to the benchmarks
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BenchmarkPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chat'),
              onTap: () {
                // Handle navigation to the chat page
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle navigation to the settings screen
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Handle navigation to the about screen
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
      // Body with the DownloadModelsBox
      body: Center(
        child: DownloadModelsBox(),
      ),
    );
  }
}

class DownloadModelsBox extends StatefulWidget {
  @override
  _DownloadModelsBoxState createState() => _DownloadModelsBoxState();
}

class _DownloadModelsBoxState extends State<DownloadModelsBox> {
  // List to store downloaded models
  List<String> downloadedModels = [];

  // Function to simulate downloading a model
  void _downloadModel() {
    setState(() {
      // Add a new model to the list
      downloadedModels.add('Model ${downloadedModels.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          // List of downloaded models
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: downloadedModels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(downloadedModels[index]),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                );
              },
            ),
          ),
          // Download button
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _downloadModel,
              child: Text('Download Model'),
            ),
          ),
        ],
      ),
    );
  }
}

class BenchmarkPage extends StatefulWidget {
  @override
  _BenchmarkPageState createState() => _BenchmarkPageState();
}

class _BenchmarkPageState extends State<BenchmarkPage> {
  String selectedModel = 'Model 1';
  bool isBenchmarkRunning = false;
  Map<String, String> benchmarkResults = {};

  void _runBenchmark() {
    setState(() {
      isBenchmarkRunning = true;
    });

    // Simulate a benchmark process
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isBenchmarkRunning = false;
        benchmarkResults = {
          'Inference Speed': '50 tokens/sec',
          'Accuracy': '95%',
          'Memory Usage': '2.5 GB',
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Benchmark'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Model Selection
            DropdownButton<String>(
              value: selectedModel,
              onChanged: (newValue) {
                setState(() {
                  selectedModel = newValue!;
                });
              },
              items: ['Model 1', 'Model 2', 'Model 3'].map((model) {
                return DropdownMenuItem(
                  value: model,
                  child: Text(model),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Run Benchmark Button
            ElevatedButton(
              onPressed: isBenchmarkRunning ? null : _runBenchmark,
              child: Text('Run Benchmark'),
            ),
            SizedBox(height: 20),

            // Progress Indicator
            if (isBenchmarkRunning)
              Center(
                child: CircularProgressIndicator(),
              ),

            // Benchmark Results
            if (benchmarkResults.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Benchmark Results',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Metric')),
                      DataColumn(label: Text('Value')),
                    ],
                    rows: benchmarkResults.entries.map((entry) {
                      return DataRow(cells: [
                        DataCell(Text(entry.key)),
                        DataCell(Text(entry.value)),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Theme selection state
  String selectedTheme = 'Light';

  // Storage management state
  double usedStorage = 250; // Example: 250 MB used
  double totalStorage = 1000; // Example: 1000 MB total

  // Function to clear storage
  void _clearStorage() {
    setState(() {
      usedStorage = 0; // Reset used storage
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Storage cleared successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Theme Selection
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('App Theme'),
            trailing: DropdownButton<String>(
              value: selectedTheme,
              onChanged: (newValue) {
                setState(() {
                  selectedTheme = newValue!;
                });
                // Apply theme change logic
                if (newValue == 'Light') {
                  // Set light theme
                } else if (newValue == 'Dark') {
                  // Set dark theme
                }
              },
              items: ['Light', 'Dark'].map((theme) {
                return DropdownMenuItem(
                  value: theme,
                  child: Text(theme),
                );
              }).toList(),
            ),
          ),
          Divider(),

          // Storage Management
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Storage'),
            subtitle: Text('${usedStorage.toStringAsFixed(2)} MB / ${totalStorage.toStringAsFixed(2)} MB'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: _clearStorage,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  String _submittedText = "";

  void _handleSubmit() {
    setState(() {
      _submittedText = _controller.text;
      _controller.clear(); // Clear input field after submission
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                _submittedText.isEmpty ? "Enter text below" : _submittedText,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Enter text",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo or Icon

            // App Name and Tagline
            Center(
              child: Text(
                'Llamabenchmark',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Created by Rohan, Theo and Sahil',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 30),

            // About the App
            Text(
              'About Llamabenchmark',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Llamabenchmark is a powerful tool designed to help users download, manage, and benchmark large language models (LLMs)',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),

            // Features
            Text(
              'Features',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FeatureItem(icon: Icons.download, text: 'Download and manage LLM models.'),
                FeatureItem(icon: Icons.assessment, text: 'Benchmark models for performance evaluation.'),
                FeatureItem(icon: Icons.thumb_up, text: 'Simple and user-friendly interface.'),
                FeatureItem(icon: Icons.update, text: 'Regular updates with new models and features.'),
              ],
            ),
            SizedBox(height: 20),

            // Contact Information
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Have questions or feedback?\nSpam rh609@sussex.ac.uk',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),

            // Version Information
            Center(
              child: Text(
                'Version: 1.0.0',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget for feature items
class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}