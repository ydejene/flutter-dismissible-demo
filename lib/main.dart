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
                    child: const Row(
                      children: [
                        Icon(Icons.archive, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Archive',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.delete, color: Colors.white),
                      ],
                    ),
                  ),
                  // acts like an interceptor safety net (prevents deleting data accidentally by a clumsy swipe )
                  confirmDismiss: (DismissDirection direction) async {
                    // Check if the user swiped from right-to-left (Delete direction)
                    if (direction == DismissDirection.endToStart) {
                      // Store the dialog response safely in a nullable boolean variable
                      final bool? deleteConfirmed = await showDialog<bool>(
                        context: context,
                        barrierDismissible:
                            false, // Forces user to pick CANCEL or DELETE
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text(
                              "Are you sure you want to permanently delete:\n\n\"$notification\"?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context)
                                        .pop(false), // Returns false

                                child: const Text('CANCEL'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pop(true), // Returns true
                                child: const Text(
                                  'DELETE',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      // The safety guard: If it's true or false, return it. If it's null, default safely to false.
                      return deleteConfirmed ?? false;
                    }
                    // Auto-archive on swipe right without triggering a pop-up
                    return true;
                  },
                  onDismissed: (direction) {
                    setState(() {
                      _notifications.removeAt(index);
                    });
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.mail_outline,
                        color: Colors.blueAccent,
                      ),
                      title: Text(notification),
                      subtitle: const Text(
                        'Swipe left to delelte, right to archive',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
