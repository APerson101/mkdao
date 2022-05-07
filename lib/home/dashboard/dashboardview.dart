import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonBar(
        children: [
          ElevatedButton(
              onPressed: () {}, child: const Text("Generate invoice")),
          ElevatedButton(onPressed: () {}, child: const Text("Make Payment")),
        ],
      ),
    );
  }
}
