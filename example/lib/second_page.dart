import 'package:flutter/material.dart';
import 'package:responsive_dashboard/responsive_dashboard.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          Row(
            children: [
              Text(
                'Second Page',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
