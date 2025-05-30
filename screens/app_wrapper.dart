import 'package:flutter/material.dart';
import 'chat_page.dart';

class AppWrapper extends StatefulWidget {
  final Widget child;

  const AppWrapper({super.key, required this.child});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  Offset _buttonPosition = const Offset(20, 80);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          left: _buttonPosition.dx,
          top: _buttonPosition.dy,
          child: Draggable(
            feedback: const ChatButton(),
            childWhenDragging: const SizedBox.shrink(),
            onDragEnd: (details) {
              setState(() {
                _buttonPosition = details.offset;
              });
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatPage()),
                );
              },
              child: const ChatButton(),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatButton extends StatelessWidget {
  const ChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.teal,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.chat, color: Colors.white),
    );
  }
}
