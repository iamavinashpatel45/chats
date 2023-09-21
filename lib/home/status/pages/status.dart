import 'package:flutter/material.dart';

class status_page extends StatefulWidget {
  const status_page({super.key});

  @override
  State<status_page> createState() => _status_pageState();
}

class _status_pageState extends State<status_page> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Status',
        ),
      ),
    );
  }
}
