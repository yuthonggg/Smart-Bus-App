import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'map_screen.dart';
import 'bus_list_screen.dart';
import '../widgets/chat_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final pages = const [MapScreen(), BusListScreen(), ChatPageWrapper()];
  final titles = ["Map", "Bus Stops", "Chat"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_index]),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Stops'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }
}


class ChatPageWrapper extends StatelessWidget {
  const ChatPageWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: ChatBox());
  }
}
