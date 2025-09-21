import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isFirstImage = true;
  bool _isDarkMode = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    //  animation controller setup
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
    _controller.forward(from: 0); // This restarts animation
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Counter + Image Toggle App"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Counter
              Text(
                'Counter: $_counter',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text("Increment"),
              ),

              const SizedBox(height: 30),

              // THis handles the fade transition
              FadeTransition(
                opacity: _animation,
                child: Image.asset(
                  _isFirstImage
                      ? 'assets/image2.png'
                      : 'assets/image1.png',
                  width: 300,
                  height: 300,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _toggleImage,
                child: const Text("Toggle Image"),
              ),

              const SizedBox(height: 20),

              // Theme toggle
              ElevatedButton(
                onPressed: _toggleTheme,
                child: Text(_isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

