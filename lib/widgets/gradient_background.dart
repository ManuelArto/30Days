import 'package:flutter/material.dart';

class GradienBackGround extends StatelessWidget {
  final double height;

  const GradienBackGround({@required this.height, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Colors.teal[400]],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[100]
          ),
        )
      ],
    );
  }
}
