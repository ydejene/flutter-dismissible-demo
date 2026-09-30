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
      // global style manual for the entire application (appBar, buttons, text field)
      theme: ThemeData(
        // fromSeed takes the blueAccent and automatically generates a complete palette of 20+ matching tones (dark blues, light blues, complementary grays, and accent colors)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        // use Google’s absolute latest design system (Material 3)
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
                "You don't have any notification.",
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
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.archive, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  // acts like an interceptor safety net (prevents deleting data accidentally by a clumsy swipe )
                  confirmDismiss: (DismissDirection direction) async {
                    // Check if the user swiped from right-to-left (Delete direction)
                    if (direction == DismissDirection.endToStart) {
                      // Show a pop-up dialog box and wait for the user's click
                      // Showing a dialog takes time because we have to wait for a user to physically press a button (use await)
                      return await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text(
                              'Are you sure you want to permanentyl delete this notification?',
                            ),
                            actions: [
                              TextButton(
                                // closes the dialog box and throws the true/false value back down to the Dismissible widget.
                                onPressed: () => Navigator.of(
                                  context,
                                ).pop(true), // Returns true (Executes delete)
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    // if swiped left to right (Archive), return true immediately without asking
                    return true;
                  },
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
