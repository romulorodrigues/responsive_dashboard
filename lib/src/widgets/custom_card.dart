import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const CustomCard({
    super.key,
    this.header,
    required this.body,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE7E9EB)),
        borderRadius: BorderRadius.circular(4.8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(104, 134, 177, 0.15),
            blurRadius: 35,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: header,
            ),
            const Divider(height: 1, color: Color(0xFFE7E9EB)),
          ],
          Padding(
            padding: padding,
            child: body,
          ),
        ],
      ),
    );
  }
}
