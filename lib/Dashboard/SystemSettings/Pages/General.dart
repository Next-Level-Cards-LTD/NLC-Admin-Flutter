import 'package:flutter/material.dart';
import 'package:next_level_admin/main.dart';

class General extends StatefulWidget {
  const General({Key? key}) : super(key: key);

  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () => Navigator.of(context).pushNamed("/Dashboard"), child: Text("HomePage")),
        Text("General"),
      ],
    );
  }
}
