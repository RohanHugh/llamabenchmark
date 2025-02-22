import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Llama Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBar(title: Text('Llama Flutter')),
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
