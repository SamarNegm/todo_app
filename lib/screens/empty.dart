import 'package:flutter/material.dart';

class empty extends StatelessWidget {
  const empty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(child: Text('No Data Yet')),
    );
  }
}
