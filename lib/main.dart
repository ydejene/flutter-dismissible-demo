import 'package:flutter/material.dart';

void main() {
  // runApp takes a widget and directly pumps is to the screen
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const DismissibleDemoScreen(),
    );
  }
}

// the public shell widget
class DismissibleDemoScreen extends StatefulWidget {
  const DismissibleDemoScreen({super.key});

  @override
  State<DismissibleDemoScreen> createState() => _DismissibleDemoScreenState();
}

// private state with the brain and muscles
class _DismissibleDemoScreenState extends State<DismissibleDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Inbox Notifications'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Our realistic inbox will go here!'),
      ),
    );
  }
}
