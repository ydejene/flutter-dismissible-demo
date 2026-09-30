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
  final List<String> _notifications = [
    'Security Alert: New login detected from Chrome',
    'GitHub: @Niyo11 requested a review on your PR',
    'Canvas: Grade published for Mobile Dev Assignment 1',
    'LinkedIn: 3 recruiters viewed your profile today',
    'Spotify: Your Weekly Release Radar is updated',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Inbox Notifications'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: _notifications.isEmpty
          ? const Center(
              child: Text(
                'No notifications here yet!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];

                // will include the dismissible widget wrapping the tile
                return Dismissible(
                  // key used to differentiate between the similar rows (like passport stamp)
                  // value key changes the text to unique identifer
                  key: ValueKey(notification),
                  onDismissed: (direction) {
                    setState(() {
                      _notifications.removeAt(index);
                    });
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.mail_outline,
                      color: Colors.blueAccent,
                    ),
                    title: Text('notifications'),
                    subtitle: const Text('Swipe to manage notifications'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
    );
  }
}
