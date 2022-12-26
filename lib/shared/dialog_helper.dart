import 'package:flutter/material.dart';

class DialogHelper {
  static DialogHelper shared = DialogHelper._private();

  DialogHelper._private();

  showAreYouSureDialog({
    required BuildContext context,
    required String title,
    required String subTitle,
    required Function action,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.purple[100],
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          subTitle,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.purple),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10.0),
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () { action() ;},
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.purple),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10.0),
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showErrorDialog({
    required BuildContext context,
    String? title,
    required String subTitle,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.purple[100],
        title: Text(
          title ?? "Error",
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          subTitle,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.purple),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10.0),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
