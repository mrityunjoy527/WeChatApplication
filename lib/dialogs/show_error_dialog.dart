import 'package:flutter/cupertino.dart';
import 'package:we_chat/dialogs/generic_dialog.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  showGenericDialog(
    context: context,
    title: title,
    content: content,
    optionsBuilder: () {
      return {"OK": null};
    },
  );
}
