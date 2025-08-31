import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _ctrl = TextEditingController();
  final List<Map<String, String>> _messages = [];

  bool _loading = false;

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _loading = true;
    });
    _ctrl.clear();

    try {
      final reply = await AiService.sendMessage(text);
      setState(() {
        _messages.add({'role': 'ai', 'text': reply});
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'ai', 'text': 'Error: ${e.toString()}'});
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(12),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[_messages.length - 1 - index];
              final isUser = msg['role'] == 'user';
              return Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue.shade200 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(msg['text'] ?? ''),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                decoration: const InputDecoration(hintText: 'Ask the assistant...'),
                onSubmitted: (_) => _send(),
              ),
            ),
            IconButton(
              icon: _loading ? const CircularProgressIndicator() : const Icon(Icons.send),
              onPressed: _loading ? null : _send,
            )
          ]),
        )
      ],
    );
  }
}
