import 'package:flutter/material.dart';

FloatingActionButton getFab(BuildContext context) {
  return FloatingActionButton(
    child: Icon(
      Icons.file_upload_outlined,
    ),
    elevation: 8,
    onPressed: () {
      print('AA');
    },
    backgroundColor: Theme.of(context).primaryColor,
  );
}
