import 'package:flutter/material.dart';

class ToolPage extends StatelessWidget {
  const ToolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: null,
        automaticallyImplyLeading: false,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Công cụ tính nhanh',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 1.5, color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8)),
                    // tileColor: Colors.cyanAccent,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    title: const Text('Tính chỉ số BMI'),
                    leading:
                        Image.asset('assets/icons/speedometer.png', width: 50),
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //     RouteNames.crePatientProfile);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
