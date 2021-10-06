import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(),
          Column(),
          Column(),
          Column(),
          Column(),
          Column(),
          Column(),
        ],
      ),
    );
  }
}
