import 'package:flutter/material.dart';

class Loading {
  static void _start({required BuildContext context}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          height: 50,
          width: 50,
          decoration:
              const BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(Colors.purple[100]),
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> wrap({
    required BuildContext context,
    required Function function,
  }) async {
    _start(context: context);
    await function.call();
    _stop(context: context);
  }

  static void _stop({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
