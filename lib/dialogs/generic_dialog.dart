import 'package:flutter/material.dart';

typedef DialogBuilder = Map<String, Object?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogBuilder optionsBuilder,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      final options = optionsBuilder();
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((option) {
          return TextButton(
            onPressed: () {
              final value = options[option];
              if(value != null) {
                Navigator.of(context).pop(value);
              }else {
                Navigator.of(context).pop();
              }
            },
            child: Text(option),
          );
        }).toList(),
      );
    },
  );
}
