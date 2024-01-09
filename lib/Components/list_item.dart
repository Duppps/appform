import 'package:flutter/material.dart';

class ListItemMenu extends StatelessWidget {
  final String labelText;
  final VoidCallback onTap;
  final Icon icon;

  const ListItemMenu(
      {Key? key,
      required this.labelText,
      required this.onTap,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            labelText,
            style: const TextStyle(color: Colors.white),
          ),
          leading: icon,
          tileColor: const Color(0xfff03a2e),
          onTap: onTap,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
