import 'package:flutter/material.dart';
import 'package:next_level_admin/Shared/Values/Constants_Colours.dart';

class ErrorMessageText extends StatelessWidget {

  final ValueNotifier notifier;

  const ErrorMessageText({required this.notifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<dynamic>(
        valueListenable: notifier,
        builder: (context, value, _){
          return Text('$value', style: TextStyle(color: errorTextColor),);
        }
    );
  }
}
