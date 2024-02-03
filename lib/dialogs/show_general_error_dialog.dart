import 'package:flutter/cupertino.dart';
import 'package:we_chat/dialogs/generic_dialog.dart';

Future<void> showGeneralErrorDialog({
  required BuildContext context,
}) async {
  showGenericDialog(
    context: context,
    title: "Something went wrong!",
    content: "Please try again",
    optionsBuilder: () {
      return {"OK": null};
    },
  );
}
