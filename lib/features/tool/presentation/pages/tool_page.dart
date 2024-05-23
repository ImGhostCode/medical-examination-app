import 'package:flutter/material.dart';

class ToolPage extends StatelessWidget {
  const ToolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: null,
        title: Row(
          children: [
            Text('Công cụ sức khỏe',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
            const Spacer(), // This will take up all available space between the title and the actions
          ],
        ),
        actions: [
          Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.search_rounded,
              size: 30,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.notifications_outlined,
              size: 30,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Text('Tool Page'),
      ),
    );
  }
}
